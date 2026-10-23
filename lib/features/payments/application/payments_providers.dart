import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/paged.dart';
import '../../../core/providers.dart';
import '../data/payment.dart';
import '../data/payments_repository.dart';
import 'checkout_controller.dart';
import 'payment_history_notifier.dart';

final paymentsRepositoryProvider = Provider<PaymentsRepository>(
  (ref) => PaymentsRepository(ref.watch(apiClientProvider)),
);

/// How often a settling payment is read again. Tests shorten it.
final paymentPollIntervalProvider = Provider<Duration>(
  (ref) => const Duration(seconds: 3),
);

/// When a payment still unsettled is read less often, and when the app
/// stops reading it and leaves the player a Check again. M-Pesa answers in
/// a minute or so, and the server settles a lost answer itself.
final paymentPollLimitsProvider =
    Provider<({Duration slowAfter, Duration slow, Duration stopAfter})>(
      (ref) => (
        slowAfter: const Duration(minutes: 3),
        slow: const Duration(seconds: 15),
        stopAfter: const Duration(minutes: 10),
      ),
    );

final checkoutControllerProvider = NotifierProvider.autoDispose
    .family<CheckoutController, CheckoutState, String>(CheckoutController.new);

/// Every payment the player made, for Profile's Payments.
final paymentHistoryProvider =
    AsyncNotifierProvider.autoDispose<PaymentHistoryNotifier, Paged<Payment>>(
      PaymentHistoryNotifier.new,
    );
