import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/error_text.dart';
import '../../../core/format.dart';
import '../../../core/l10n.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/application/auth_providers.dart';
import '../../competitions/application/competitions_providers.dart';
import '../application/checkout_controller.dart';
import '../application/payments_providers.dart';
import 'widgets/mpesa_form.dart';
import 'widgets/payment_outcome.dart';
import 'widgets/payment_waiting.dart';

/// Pays a competition's entry fee with M-Pesa. Opening it picks up an
/// unfinished payment instead of starting a second charge.
class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key, required this.competitionId});

  final String competitionId;

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  CheckoutController get _controller =>
      ref.read(checkoutControllerProvider(widget.competitionId).notifier);

  @override
  void initState() {
    super.initState();
    unawaited(Future.microtask(_controller.resumeIfPending));
  }

  @override
  Widget build(BuildContext context) {
    final competition = ref.watch(competitionProvider(widget.competitionId));
    final checkout = ref.watch(
      checkoutControllerProvider(widget.competitionId),
    );
    final player = ref.watch(currentPlayerProvider);

    return Scaffold(
      appBar: AppBar(titleSpacing: 0, title: Text(context.l10n.paymentTitle)),
      body: switch (competition) {
        AsyncData(value: final c) => ListView(
          padding: const EdgeInsets.fromLTRB(
            TonitsSpace.lg,
            TonitsSpace.sm,
            TonitsSpace.lg,
            TonitsSpace.xl,
          ),
          children: [
            Text(
              c.name,
              style: TextStyle(color: context.palette.subtleForeground),
            ),
            const SizedBox(height: TonitsSpace.lg),
            switch (checkout.phase) {
              CheckoutPhase.form => MpesaForm(
                amount: Format.money(c.entryFeeMinor, c.currency),
                initialPhone: player?.phoneNumber,
                error: checkout.error,
                onPay: (phone) => _controller.pay(phoneNumber: phone),
              ),
              CheckoutPhase.sending => const LoadingState(height: 240),
              CheckoutPhase.waiting => PaymentWaiting(
                payment: checkout.payment!,
                slow: checkout.slow,
                onCheckAgain: _controller.checkAgain,
              ),
              CheckoutPhase.settled => PaymentOutcome(
                payment: checkout.payment!,
                onDone: () => context.pop(),
                onTryAgain: _controller.startOver,
                onCheckAgain: _controller.checkAgain,
              ),
            },
          ],
        ),
        AsyncError(:final error) => ErrorState(
          message: describeError(error, context.l10n),
          onRetry: () =>
              ref.invalidate(competitionProvider(widget.competitionId)),
        ),
        _ => const LoadingState(height: 320),
      },
    );
  }
}
