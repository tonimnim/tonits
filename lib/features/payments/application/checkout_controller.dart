import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/error_text.dart';
import '../../../core/l10n.dart';
import '../../competitions/application/competitions_providers.dart';
import '../../players/application/players_providers.dart';
import '../data/payment.dart';
import '../data/payments_repository.dart';
import 'payments_providers.dart';

/// After this long without an answer, the player is told it can take a
/// moment and offered a manual check.
const slowPaymentAfter = Duration(seconds: 60);

enum CheckoutPhase {
  /// Asking for the M-Pesa number.
  form,

  /// Sending the prompt, or looking up an earlier payment.
  sending,

  /// The prompt is on the phone; reading the payment until it settles.
  waiting,

  /// The payment settled (see [CheckoutState.payment]) or is under review.
  settled,
}

@immutable
class CheckoutState {
  const CheckoutState({
    this.phase = CheckoutPhase.form,
    this.payment,
    this.error,
    this.slow = false,
    this.stopped = false,
  });

  final CheckoutPhase phase;
  final Payment? payment;

  /// Why the last attempt didn't start, ready to show.
  final String? error;

  /// Waiting longer than [slowPaymentAfter].
  final bool slow;

  /// Waited so long the app stopped reading it; the player checks again.
  final bool stopped;
}

/// Pays a competition's entry fee with M-Pesa: sends the prompt, then reads
/// the payment until the server settles it. Success comes only from the
/// server, never from a timer or the prompt itself.
class CheckoutController extends Notifier<CheckoutState> {
  CheckoutController(this.competitionId);

  final String competitionId;

  /// One per payment attempt, reused only to retry that same attempt.
  String? _idempotencyKey;

  /// Ends polling loops left over from an earlier attempt.
  int _generation = 0;

  /// The wait before the next read, cancelled when the player leaves.
  Timer? _nextPoll;

  @override
  CheckoutState build() {
    ref.onDispose(_stopPolling);
    return const CheckoutState();
  }

  void _stopPolling() {
    _generation++;
    _nextPoll?.cancel();
  }

  /// Completes after [delay], unless polling stops first (then never).
  Future<void> _sleep(Duration delay) {
    final done = Completer<void>();
    _nextPoll = Timer(delay, done.complete);
    return done.future;
  }

  AppLocalizations get _l10n => ref.read(l10nProvider);

  PaymentsRepository get _payments => ref.read(paymentsRepositoryProvider);

  /// Picks up the player's latest payment for this competition, if there
  /// is one, instead of starting another charge.
  Future<void> resumeIfPending() async {
    state = const CheckoutState(phase: CheckoutPhase.sending);
    try {
      final eligibility = await ref.read(
        eligibilityProvider(competitionId).future,
      );
      if (!ref.mounted) return;
      final paymentId = eligibility.paymentId;
      if (paymentId == null) {
        state = const CheckoutState();
        return;
      }
      final payment = await _payments.get(paymentId);
      if (ref.mounted) _track(payment);
    } catch (e) {
      if (ref.mounted) state = CheckoutState(error: describeError(e, _l10n));
    }
  }

  /// Sends the M-Pesa prompt to [phoneNumber] (or the saved phone).
  Future<void> pay({String? phoneNumber}) async {
    state = const CheckoutState(phase: CheckoutPhase.sending);
    final key = _idempotencyKey ??= newUuid();
    try {
      final payments = _payments;
      final gameAccountId = await ref.read(myGameAccountIdProvider.future);
      if (!ref.mounted) return;
      if (gameAccountId == null) {
        throw StateError('No eFootball account to enter with');
      }
      final payment = await payments.startMpesa(
        competitionId: competitionId,
        gameAccountId: gameAccountId,
        idempotencyKey: key,
        phoneNumber: phoneNumber,
      );
      if (ref.mounted) _track(payment);
    } on ApiException catch (e) {
      if (ref.mounted) await _startFailed(e);
    } catch (e) {
      if (ref.mounted) state = CheckoutState(error: describeError(e, _l10n));
    }
  }

  /// Reads the payment once more, such as after a review or a slow wait.
  Future<void> checkAgain() async {
    final payment = state.payment;
    if (payment == null) return resumeIfPending();
    try {
      final latest = await _payments.get(payment.id);
      if (ref.mounted) _track(latest);
    } catch (e) {
      if (!ref.mounted) return;
      state = CheckoutState(
        phase: state.phase,
        payment: payment,
        error: describeError(e, _l10n),
      );
    }
  }

  /// A fresh attempt after a failed payment: a new key, back to the form.
  void startOver() {
    _idempotencyKey = null;
    _stopPolling();
    state = const CheckoutState();
  }

  Future<void> _startFailed(ApiException e) async {
    switch (e.code) {
      case 'payment_in_progress':
        // Never start another charge: follow the one already running.
        final paymentId = e.details['paymentId'] as String?;
        if (paymentId != null) {
          try {
            final payment = await _payments.get(paymentId);
            if (ref.mounted) _track(payment);
          } catch (_) {
            // Keep the key: trying again finds that same payment.
            if (ref.mounted) {
              state = CheckoutState(error: _l10n.paymentNotConfirmed);
            }
          }
          return;
        }
      case 'already_registered':
        ref.read(entryServiceProvider).refreshAfterEntry(competitionId);
      case 'mpesa_request_failed' || 'payment_record_failed':
        // The prompt may have reached the phone. Retrying with the same key
        // returns that payment rather than charging again, so keep the key.
        state = CheckoutState(error: _l10n.paymentNotConfirmed);
        return;
      case 'competition_ineligible':
        ref.invalidate(eligibilityProvider(competitionId));
    }
    // Anything else is a new decision next time, so it gets a new key.
    _idempotencyKey = null;
    state = CheckoutState(error: _describe(e));
  }

  /// The payment refusals worth their own words; the rest as the app says
  /// them everywhere.
  String _describe(ApiException e) => switch (e.code) {
    'mpesa_unavailable' => _l10n.paymentMpesaUnavailable,
    'phone_required' => _l10n.paymentPhoneRequired,
    'unsupported_fee' || 'payment_not_available' => _l10n.paymentNotAvailable,
    _ => describeError(e, _l10n),
  };

  void _track(Payment payment) {
    if (!payment.isSettling) {
      _settle(payment);
      return;
    }
    state = CheckoutState(phase: CheckoutPhase.waiting, payment: payment);
    unawaited(_poll(payment.id, ++_generation, DateTime.now()));
  }

  void _settle(Payment payment) {
    state = CheckoutState(phase: CheckoutPhase.settled, payment: payment);
    if (payment.registrationStatus != RegistrationOutcome.pending) {
      ref.read(entryServiceProvider).refreshAfterEntry(competitionId);
    }
  }

  /// Reads the payment until it settles: often at first, less after a
  /// few minutes, and not at all after [paymentPollLimitsProvider]'s stop,
  /// so a payment stuck on the server doesn't drain the phone. The time is
  /// what the loop waited, so it holds however the phone sleeps.
  Future<void> _poll(String paymentId, int generation, DateTime since) async {
    final interval = ref.read(paymentPollIntervalProvider);
    final limits = ref.read(paymentPollLimitsProvider);
    var waited = Duration.zero;
    while (true) {
      if (waited >= limits.stopAfter) {
        state = CheckoutState(
          phase: CheckoutPhase.waiting,
          payment: state.payment,
          slow: true,
          stopped: true,
        );
        return;
      }
      final delay = waited >= limits.slowAfter ? limits.slow : interval;
      await _sleep(delay);
      waited += delay;
      if (!ref.mounted || generation != _generation) return;
      try {
        final payment = await _payments.get(paymentId);
        if (!ref.mounted || generation != _generation) return;
        if (!payment.isSettling) return _settle(payment);
        state = CheckoutState(
          phase: CheckoutPhase.waiting,
          payment: payment,
          slow:
              waited > slowPaymentAfter ||
              DateTime.now().difference(since) > slowPaymentAfter,
        );
      } on ApiException catch (e) {
        if (e.status == 404 || e.status == 400) {
          // That payment can't be read; stop rather than poll forever.
          state = CheckoutState(error: describeError(e, _l10n));
          return;
        }
      } on NetworkException {
        // Keep waiting; the next read may get through.
      } catch (_) {
        // A reply the app can't read: stop, and let the player check again.
        state = CheckoutState(
          phase: CheckoutPhase.waiting,
          payment: state.payment,
          slow: true,
          stopped: true,
        );
        return;
      }
    }
  }
}
