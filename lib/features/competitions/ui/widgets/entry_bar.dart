import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/error_text.dart';
import '../../../../core/format.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/competitions_providers.dart';
import '../../application/entry_service.dart';
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

class _EntryBarState extends ConsumerState<EntryBar> {
  bool _busy = false;
  String? _error;

  String get _id => widget.competition.id;

  Future<void> _run(Future<void> Function() action) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
    } on ApiException catch (e) {
      if (!mounted) return;
      if (e.code == 'payment_required') {
        await context.push(Routes.checkout(_id));
      } else {
        setState(() => _error = describeError(e));
      }
    } catch (e) {
      if (mounted) setState(() => _error = describeError(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _withdraw() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Withdraw from this competition?'),
        content: const Text(
          'Your place goes back to the pool. You can enter again while '
          'registration is open.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Stay in'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Withdraw'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await _run(() => ref.read(entryServiceProvider).withdraw(_id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final eligibility = ref.watch(eligibilityProvider(_id));
    final c = widget.competition;
    final fee = Format.money(c.entryFeeMinor, c.currency);

    final Widget content = switch (eligibility) {
      AsyncData(value: final e) => _forDecision(e, fee),
      AsyncError() => _Message(
        icon: Icons.cloud_off_outlined,
        text: "Couldn't check whether you can enter.",
        action: TextButton(
          onPressed: () => ref.invalidate(eligibilityProvider(_id)),
          child: const Text('Try again'),
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
          if (_error != null) ...[
            Notice(_error!),
            const SizedBox(height: TonitsSpace.md),
          ],
          content,
        ],
      ),
    );
  }

  Widget _forDecision(Eligibility e, String fee) {
    // A payment in flight decides, whatever the action says.
    if (e.paymentId != null && !e.isRegistered) {
      return PrimaryButton(
        label: 'Check your payment',
        onPressed: () => context.push(Routes.checkout(_id)),
      );
    }
    if (e.isRegistered) {
      return _Registered(
        canWithdraw:
            !widget.competition.isPaid &&
            widget.competition.status == CompetitionStatus.registrationOpen,
        busy: _busy,
        onWithdraw: _withdraw,
      );
    }
    return switch (e.requiredAction) {
      RequiredAction.submitRegistration => PrimaryButton(
        label: 'Enter for free',
        busy: _busy,
        onPressed: () =>
            _run(() => ref.read(entryServiceProvider).enterFree(_id)),
      ),
      RequiredAction.startPayment => PrimaryButton(
        label: 'Pay $fee with M-Pesa',
        onPressed: () => context.push(Routes.checkout(_id)),
      ),
      RequiredAction.pollPayment => PrimaryButton(
        label: 'Check your payment',
        onPressed: () => context.push(Routes.checkout(_id)),
      ),
      RequiredAction.viewRefund => const _Message(
        icon: Icons.replay_outlined,
        text: 'Your entry fee is being refunded.',
      ),
      _ => _Message(
        icon: Icons.block_outlined,
        text: e.blockingIssue?.message ?? "You can't enter this competition.",
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
              "You're in",
              style: TextStyle(fontWeight: FontWeight.w600, color: text),
            ),
          ),
          if (canWithdraw)
            TextButton(
              onPressed: busy ? null : onWithdraw,
              child: const Text('Withdraw'),
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
