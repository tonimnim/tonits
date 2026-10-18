import 'package:flutter/material.dart';

import '../../../../core/format.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/payment.dart';

/// How a settled payment ended for the player's place. A successful
/// payment is only shown as an entry when the server says it registered.
class PaymentOutcome extends StatelessWidget {
  const PaymentOutcome({
    super.key,
    required this.payment,
    required this.onDone,
    required this.onTryAgain,
    required this.onCheckAgain,
  });

  final Payment payment;
  final VoidCallback onDone;
  final VoidCallback onTryAgain;
  final VoidCallback onCheckAgain;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final amount = Format.money(payment.amountMinor, payment.currency);

    final (icon, tone, title, message, actions) = switch (payment) {
      Payment(status: PaymentStatus.review) => (
        Icons.hourglass_top_rounded,
        p.info,
        'Payment under review',
        "We're checking this payment with M-Pesa. You won't be charged "
            "twice, and you'll be notified when it's settled.",
        [SecondaryButton(label: 'Check again', onPressed: onCheckAgain)],
      ),
      Payment(registrationStatus: RegistrationOutcome.registered) => (
        Icons.check_circle_rounded,
        p.good,
        "You're in",
        'Paid $amount. Your place is confirmed.',
        [PrimaryButton(label: 'Done', onPressed: onDone)],
      ),
      Payment(registrationStatus: RegistrationOutcome.refundPending) => (
        Icons.replay_rounded,
        p.warn,
        'Paid, but no place left',
        'The places filled or registration closed before your payment '
            'arrived. A full refund of $amount is on its way.',
        [PrimaryButton(label: 'Done', onPressed: onDone)],
      ),
      Payment(registrationStatus: RegistrationOutcome.refunded) => (
        Icons.replay_rounded,
        p.info,
        'Refunded',
        '$amount has been returned to your M-Pesa.',
        [PrimaryButton(label: 'Done', onPressed: onDone)],
      ),
      Payment(registrationStatus: RegistrationOutcome.removed) => (
        Icons.block_rounded,
        p.warn,
        'Entry removed',
        'Your entry was removed from this competition.',
        [PrimaryButton(label: 'Done', onPressed: onDone)],
      ),
      _ => (
        Icons.error_outline_rounded,
        (p.destructive, p.destructive.withValues(alpha: 0.12)),
        "Payment didn't go through",
        payment.providerMessage ?? "M-Pesa didn't confirm the payment.",
        [
          PrimaryButton(label: 'Try again', onPressed: onTryAgain),
          const SizedBox(height: TonitsSpace.sm),
          SecondaryButton(label: 'Not now', onPressed: onDone),
        ],
      ),
    };

    return Semantics(
      liveRegion: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: TonitsSpace.lg),
          Icon(icon, size: 52, color: tone.$1),
          const SizedBox(height: TonitsSpace.lg),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: TonitsSpace.sm),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: p.subtleForeground),
          ),
          const SizedBox(height: TonitsSpace.xl),
          ...actions,
        ],
      ),
    );
  }
}
