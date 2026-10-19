import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../data/payments_repository.dart';
import 'checkout_controller.dart';

final paymentsRepositoryProvider = Provider<PaymentsRepository>(
  (ref) => PaymentsRepository(ref.watch(apiClientProvider)),
);

/// How often a settling payment is read again. Tests shorten it.
final paymentPollIntervalProvider = Provider<Duration>(
  (ref) => const Duration(seconds: 3),
);

final checkoutControllerProvider = NotifierProvider.autoDispose
    .family<CheckoutController, CheckoutState, String>(CheckoutController.new);
