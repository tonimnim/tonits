/// An M-Pesa entry payment (`PaymentIntent`). [status] is only the money;
/// whether the player got a place is [registrationStatus].
class Payment {
  const Payment({
    required this.id,
    required this.competitionId,
    required this.amountMinor,
    required this.currency,
    required this.maskedPhone,
    required this.status,
    required this.registrationStatus,
    this.providerMessage,
    this.refundReason,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    final refund = json['refund'] as Map<String, dynamic>?;
    return Payment(
      id: json['id'] as String,
      competitionId: json['competitionId'] as String,
      amountMinor: json['amountMinor'] as int,
      currency: json['currency'] as String,
      maskedPhone: json['phoneNumber'] as String? ?? '',
      status: PaymentStatus.parse(json['status'] as String),
      registrationStatus: RegistrationOutcome.parse(
        json['registrationStatus'] as String,
      ),
      providerMessage: json['providerResultDescription'] as String?,
      refundReason: refund?['reason'] as String?,
    );
  }

  final String id;
  final String competitionId;
  final int amountMinor;
  final String currency;

  /// As the API returns it, already masked.
  final String maskedPhone;
  final PaymentStatus status;
  final RegistrationOutcome registrationStatus;

  /// M-Pesa's own words for a failed payment, such as "Request cancelled by
  /// user".
  final String? providerMessage;
  final String? refundReason;

  /// Whether to keep polling: the money or the place isn't settled yet. A
  /// payment under review is not polled fast; read it again later.
  bool get isSettling =>
      status == PaymentStatus.initiating ||
      status == PaymentStatus.pending ||
      status == PaymentStatus.callbackReceived ||
      (status == PaymentStatus.succeeded &&
          registrationStatus == RegistrationOutcome.pending);
}

enum PaymentStatus {
  initiating,
  pending,
  callbackReceived,
  succeeded,
  failed,
  review;

  static PaymentStatus parse(String value) => switch (value) {
    'initiating' => initiating,
    'callback_received' => callbackReceived,
    'succeeded' => succeeded,
    'failed' => failed,
    'review' => review,
    _ => pending,
  };
}

/// What the payment did for the player's place.
enum RegistrationOutcome {
  pending,
  registered,
  refundPending,
  refunded,
  removed,
  notRegistered;

  static RegistrationOutcome parse(String value) => switch (value) {
    'registered' => registered,
    'refund_pending' => refundPending,
    'refunded' => refunded,
    'removed' => removed,
    'not_registered' => notRegistered,
    _ => pending,
  };
}
