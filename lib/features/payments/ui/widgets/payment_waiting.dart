import 'package:flutter/material.dart';

import '../../../../core/format.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/payment.dart';

/// The prompt is on the player's phone; the app waits for M-Pesa's answer.
class PaymentWaiting extends StatelessWidget {
  const PaymentWaiting({
    super.key,
    required this.payment,
    required this.slow,
    required this.onCheckAgain,
  });

  final Payment payment;
  final bool slow;
  final VoidCallback onCheckAgain;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final amount = Format.money(payment.amountMinor, payment.currency);
    final phone = payment.maskedPhone.isEmpty
        ? 'your phone'
        : payment.maskedPhone;
    return Semantics(
      liveRegion: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: TonitsSpace.lg),
          Icon(Icons.phone_android_rounded, size: 52, color: p.primary),
          const SizedBox(height: TonitsSpace.lg),
          Text(
            'Check your phone',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: TonitsSpace.sm),
          Text(
            'Enter your M-Pesa PIN on $phone to pay $amount.',
            textAlign: TextAlign.center,
            style: TextStyle(color: p.subtleForeground),
          ),
          const SizedBox(height: TonitsSpace.xl),
          const LoadingState(height: 32),
          const SizedBox(height: TonitsSpace.sm),
          Text(
            'Waiting for M-Pesa…',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: p.mutedForeground),
          ),
          if (slow) ...[
            const SizedBox(height: TonitsSpace.xl),
            Text(
              "Still waiting? M-Pesa can take a minute. You won't be "
              'charged twice.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: p.subtleForeground),
            ),
            const SizedBox(height: TonitsSpace.md),
            SecondaryButton(label: 'Check again', onPressed: onCheckAgain),
          ],
        ],
      ),
    );
  }
}
