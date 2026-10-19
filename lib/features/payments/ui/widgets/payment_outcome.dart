import 'package:flutter/material.dart';

import '../../../../core/format.dart';
import '../../../../core/l10n.dart';
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
    final l = context.l10n;
    final amount = Format.money(payment.amountMinor, payment.currency);

    final (icon, tone, title, message, actions) = switch (payment) {
      Payment(status: PaymentStatus.review) => (
        Icons.hourglass_top_rounded,
        p.info,
        l.paymentUnderReview,
        l.paymentUnderReviewMessage,
        [SecondaryButton(label: l.paymentCheckAgain, onPressed: onCheckAgain)],
      ),
      Payment(registrationStatus: RegistrationOutcome.registered) => (
        Icons.check_circle_rounded,
        p.good,
        l.paymentYoureIn,
        l.paymentConfirmed(amount),
        [PrimaryButton(label: l.paymentDone, onPressed: onDone)],
      ),
      Payment(registrationStatus: RegistrationOutcome.refundPending) => (
        Icons.replay_rounded,
        p.warn,
        l.paymentNoPlaceLeft,
        l.paymentNoPlaceLeftMessage(amount),
        [PrimaryButton(label: l.paymentDone, onPressed: onDone)],
      ),
      Payment(registrationStatus: RegistrationOutcome.refunded) => (
        Icons.replay_rounded,
        p.info,
        l.paymentRefunded,
        l.paymentRefundedMessage(amount),
        [PrimaryButton(label: l.paymentDone, onPressed: onDone)],
      ),
      Payment(registrationStatus: RegistrationOutcome.removed) => (
        Icons.block_rounded,
        p.warn,
        l.paymentEntryRemoved,
        l.paymentEntryRemovedMessage,
        [PrimaryButton(label: l.paymentDone, onPressed: onDone)],
      ),
      _ => (
        Icons.error_outline_rounded,
        (p.destructive, p.destructive.withValues(alpha: 0.12)),
        l.paymentFailed,
        payment.providerMessage ?? l.paymentFailedMessage,
        [
          PrimaryButton(label: l.tryAgain, onPressed: onTryAgain),
          const SizedBox(height: TonitsSpace.sm),
          SecondaryButton(label: l.paymentNotNow, onPressed: onDone),
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
