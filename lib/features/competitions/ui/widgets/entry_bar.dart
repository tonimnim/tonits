import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/format.dart';
import '../../../../core/l10n.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/competitions_providers.dart';
import '../../data/competition.dart';
import '../../data/eligibility.dart';

/// The bottom of a competition: what the player can do, as the server's
/// eligibility decision says. Enter for free, pay with M-Pesa, follow a
/// payment, or see why they can't enter.
class EntryBar extends ConsumerStatefulWidget {
  const EntryBar({super.key, required this.competition});

  final Competition competition;

  @override
  ConsumerState<EntryBar> createState() => _EntryBarState();
}

class _EntryBarState extends ConsumerState<EntryBar> with BusyState {
  String get _id => widget.competition.id;

  /// Runs an entry action; an entry that turns out to need a fee goes to
  /// checkout instead of showing an error.
  Future<void> _act(Future<void> Function() action) => run(() async {
    try {
      await action();
    } on ApiException catch (e) {
      if (e.code != 'payment_required') rethrow;
      if (mounted) await context.push(Routes.checkout(_id));
    }
  });

  Future<void> _withdraw() async {
    final l = context.l10n;
    final confirmed = await confirmAction(
      context,
      title: l.competitionWithdrawTitle,
      message: l.competitionWithdrawMessage,
      confirmLabel: l.competitionWithdraw,
      cancelLabel: l.competitionStayIn,
    );
    if (confirmed) {
      await _act(() => ref.read(entryServiceProvider).withdraw(_id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final eligibility = ref.watch(eligibilityProvider(_id));
    final c = widget.competition;
    final fee = Format.money(c.entryFeeMinor, c.currency);

    final Widget content = switch (eligibility) {
      AsyncData(value: final e) => _forDecision(e, fee),
      AsyncError() => _Message(
        icon: Icons.cloud_off_outlined,
        text: l.competitionEligibilityFailed,
        action: TextButton(
          onPressed: () => ref.invalidate(eligibilityProvider(_id)),
          child: Text(l.tryAgain),
        ),
      ),
      _ => const LoadingState(height: 52),
    };

    return Container(
      decoration: BoxDecoration(
        color: p.card,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(TonitsRadius.panel),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(
        TonitsSpace.md,
        20,
        TonitsSpace.md,
        TonitsSpace.md,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (error != null) ...[
            Notice(error!),
            const SizedBox(height: TonitsSpace.md),
          ],
          content,
        ],
      ),
    );
  }

  Widget _forDecision(Eligibility e, String fee) {
    final l = context.l10n;
    // A payment in flight decides, whatever the action says.
    if (e.paymentId != null && !e.isRegistered) {
      return PrimaryButton(
        label: l.competitionCheckPayment,
        onPressed: () => context.push(Routes.checkout(_id)),
      );
    }
    if (e.isRegistered) {
      return _Registered(
        canWithdraw:
            !widget.competition.isPaid &&
            widget.competition.status == CompetitionStatus.registrationOpen,
        busy: busy,
        onWithdraw: _withdraw,
      );
    }
    return switch (e.requiredAction) {
      RequiredAction.submitRegistration => PrimaryButton(
        label: l.competitionEnterFree,
        busy: busy,
        onPressed: () =>
            _act(() => ref.read(entryServiceProvider).enterFree(_id)),
      ),
      RequiredAction.startPayment => PrimaryButton(
        label: l.competitionPayWithMpesa(fee),
        onPressed: () => context.push(Routes.checkout(_id)),
      ),
      RequiredAction.pollPayment => PrimaryButton(
        label: l.competitionCheckPayment,
        onPressed: () => context.push(Routes.checkout(_id)),
      ),
      RequiredAction.viewRefund => _Message(
        icon: Icons.replay_outlined,
        text: l.competitionRefundInProgress,
      ),
      _ => _Message(
        icon: Icons.block_outlined,
        text: e.blockingIssue?.message ?? l.competitionCannotEnter,
      ),
    };
  }
}

class _Registered extends StatelessWidget {
  const _Registered({
    required this.canWithdraw,
    required this.busy,
    required this.onWithdraw,
  });

  final bool canWithdraw;
  final bool busy;
  final VoidCallback onWithdraw;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final (text, _) = p.good;
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 6, 8, 6),
      constraints: const BoxConstraints(minHeight: 54),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: p.input),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: text, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              context.l10n.competitionYoureIn,
              style: TextStyle(fontWeight: FontWeight.w600, color: text),
            ),
          ),
          if (canWithdraw)
            TextButton(
              onPressed: busy ? null : onWithdraw,
              child: Text(context.l10n.competitionWithdraw),
            ),
        ],
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.icon, required this.text, this.action});

  final IconData icon;
  final String text;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: p.input),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: p.mutedForeground),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text, style: TextStyle(color: p.subtleForeground)),
          ),
          ?action,
        ],
      ),
    );
  }
}
