import 'package:flutter/material.dart';

import '../../../../core/format.dart';
import '../../../../core/l10n.dart';
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
    this.stopped = false,
  });

  final Payment payment;
  final bool slow;

  /// The app stopped reading it: no spinner, just Check again.
  final bool stopped;
  final VoidCallback onCheckAgain;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final amount = Format.money(payment.amountMinor, payment.currency);
    final phone = payment.maskedPhone.isEmpty
        ? l.paymentYourPhone
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
            l.paymentCheckYourPhone,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: TonitsSpace.sm),
          Text(
            l.paymentEnterPin(phone, amount),
            textAlign: TextAlign.center,
            style: TextStyle(color: p.subtleForeground),
          ),
          if (!stopped) ...[
            const SizedBox(height: TonitsSpace.xl),
            const LoadingState(height: 32),
            const SizedBox(height: TonitsSpace.sm),
            Text(
              l.paymentWaiting,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: p.mutedForeground),
            ),
          ],
          if (slow) ...[
            const SizedBox(height: TonitsSpace.xl),
            Text(
              stopped ? l.paymentStopped : l.paymentSlow,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: p.subtleForeground),
            ),
            const SizedBox(height: TonitsSpace.md),
            SecondaryButton(
              label: l.paymentCheckAgain,
              onPressed: onCheckAgain,
            ),
          ],
        ],
      ),
    );
  }
}
