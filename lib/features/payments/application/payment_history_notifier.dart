import '../../../core/api/cursor_page.dart';
import '../../../core/api/paged.dart';
import '../data/payment.dart';
import 'payments_providers.dart';

/// The player's payments, newest first, each with its refund if any.
class PaymentHistoryNotifier extends PagedNotifier<Payment> {
  @override
  Future<CursorPage<Payment>> fetchPage(String? cursor) =>
      ref.read(paymentsRepositoryProvider).history(cursor: cursor);
}
