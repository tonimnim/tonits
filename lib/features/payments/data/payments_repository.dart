import '../../../core/api/api_client.dart';
import '../../../core/api/cursor_page.dart';
import 'payment.dart';

class PaymentsRepository {
  PaymentsRepository(this._api);

  final ApiClient _api;

  /// Sends the M-Pesa prompt to the player's phone. [idempotencyKey] is one
  /// per payment attempt; retry a failed request only with the same key.
  /// Without [phoneNumber] the API uses the phone saved on the account.
  Future<Payment> startMpesa({
    required String competitionId,
    required String gameAccountId,
    required String idempotencyKey,
    String? phoneNumber,
  }) async {
    final json = await _api.post(
      '/v1/payments/mpesa/stk-push',
      body: {
        'competitionId': competitionId,
        'gameAccountId': gameAccountId,
        'phoneNumber': ?phoneNumber,
      },
      headers: {'Idempotency-Key': idempotencyKey},
      auth: true,
    );
    return Payment.fromJson(json!);
  }

  /// The player's payments, newest first, each with its refund if any.
  Future<CursorPage<Payment>> history({String? cursor}) async {
    final json = await _api.get(
      withQuery('/v1/me/payments', {'limit': 50, 'cursor': cursor}),
      auth: true,
    );
    return CursorPage.fromJson(json!, Payment.fromJson);
  }

  Future<Payment> get(String paymentId) async {
    final json = await _api.get(
      '/v1/payments/${Uri.encodeComponent(paymentId)}',
      auth: true,
    );
    return Payment.fromJson(json!);
  }
}
