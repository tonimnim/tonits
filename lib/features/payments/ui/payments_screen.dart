import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/error_text.dart';
import '../../../core/format.dart';
import '../../../core/l10n.dart';
import '../../../core/routes.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../competitions/application/competitions_providers.dart';
import '../application/payments_providers.dart';
import '../data/payment.dart';

/// Every payment the player made, newest first, and where any refund
/// stands. A row opens its receipt.
class PaymentsScreen extends ConsumerWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l.paymentsTitle)),
      body: PagedListView(
        value: ref.watch(paymentHistoryProvider),
        onRefresh: () => ref.refresh(paymentHistoryProvider.future),
        onLoadMore: () => ref.read(paymentHistoryProvider.notifier).loadMore(),
        errorText: (e) => describeError(e, l),
        separator: const Divider(height: 1),
        itemBuilder: (context, payment) => _PaymentRow(payment: payment),
        empty: EmptyState(
          icon: Icons.receipt_long_outlined,
          title: l.paymentsEmpty,
          message: l.paymentsEmptyMessage,
        ),
      ),
    );
  }
}

/// Where a payment stands for the player, money and place together: a
/// refund, when there is one, says the most.
(String, StatusTone) paymentStanding(Payment p, AppLocalizations l) {
  switch (p.refundStatus) {
    case 'succeeded':
      return (l.paymentRefundedShort, StatusTone.muted);
    case 'rejected':
      return (l.paymentRefundDeclined, StatusTone.bad);
    case 'failed' || 'manual_review':
      return (l.paymentRefundDelayed, StatusTone.warn);
    case 'requested' || 'approved' || 'processing':
      return (l.paymentRefundPending, StatusTone.warn);
  }
  return switch (p.status) {
    PaymentStatus.failed => (l.paymentNotPaid, StatusTone.bad),
    PaymentStatus.review => (l.paymentReview, StatusTone.info),
    PaymentStatus.succeeded => switch (p.registrationStatus) {
      RegistrationOutcome.refundPending => (
        l.paymentRefundPending,
        StatusTone.warn,
      ),
      RegistrationOutcome.refunded => (
        l.paymentRefundedShort,
        StatusTone.muted,
      ),
      RegistrationOutcome.removed => (l.paymentRemoved, StatusTone.bad),
      _ => (l.paymentPaid, StatusTone.good),
    },
    _ => (l.paymentWaitingShort, StatusTone.info),
  };
}

/// The competition's name: from the payment when the API sends it, else
/// from the competition.
String? _competitionName(WidgetRef ref, Payment payment) =>
    payment.competitionName ??
    ref.watch(competitionProvider(payment.competitionId)).value?.name;

class _PaymentRow extends ConsumerWidget {
  const _PaymentRow({required this.payment});

  final Payment payment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final l = context.l10n;
    final (label, tone) = paymentStanding(payment, l);
    final at = payment.createdAt;
    return InkWell(
      onTap: () => _showReceipt(context, payment),
      borderRadius: BorderRadius.circular(TonitsRadius.control),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _competitionName(ref, payment) ?? '…',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    [
                      Format.money(payment.amountMinor, payment.currency),
                      if (at != null) Format.dateTime(at, l),
                    ].join(' · '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: p.mutedForeground),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            StatusBadge(label, tone: tone),
          ],
        ),
      ),
    );
  }
}

/// A payment's receipt: the amount, where it stands, and the way to its
/// competition.
Future<void> _showReceipt(BuildContext context, Payment payment) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheet) => Consumer(
        builder: (sheet, ref, _) {
          final p = sheet.palette;
          final l = sheet.l10n;
          final (label, tone) = paymentStanding(payment, l);
          final at = payment.createdAt;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                TonitsSpace.lg,
                0,
                TonitsSpace.lg,
                TonitsSpace.lg,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _competitionName(ref, payment) ?? '…',
                          style: Theme.of(sheet).textTheme.headlineSmall,
                        ),
                      ),
                      const SizedBox(width: 12),
                      StatusBadge(label, tone: tone),
                    ],
                  ),
                  const SizedBox(height: TonitsSpace.md),
                  Text(
                    Format.money(payment.amountMinor, payment.currency),
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.8,
                    ),
                  ),
                  Text(
                    [
                      if (at != null) Format.dateTime(at, l),
                      if (payment.maskedPhone.isNotEmpty)
                        l.paymentFromPhone(payment.maskedPhone),
                    ].join(' · '),
                    style: TextStyle(color: p.subtleForeground),
                  ),
                  if (payment.status == PaymentStatus.failed &&
                      payment.providerMessage != null) ...[
                    const SizedBox(height: TonitsSpace.md),
                    Text(
                      payment.providerMessage!,
                      style: TextStyle(color: p.subtleForeground),
                    ),
                  ],
                  const SizedBox(height: TonitsSpace.lg),
                  SecondaryButton(
                    label: l.paymentOpenCompetition,
                    onPressed: () {
                      Navigator.of(sheet).pop();
                      context.go(Routes.competition(payment.competitionId));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
