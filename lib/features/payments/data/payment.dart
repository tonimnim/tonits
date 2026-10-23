import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

/// An M-Pesa entry payment (`PaymentIntent`). [status] is only the money;
/// whether the player got a place is [registrationStatus].
@freezed
abstract class Payment with _$Payment {
  const Payment._();

  const factory Payment({
    required String id,
    required String competitionId,
    required int amountMinor,
    required String currency,

    /// As the API returns it, already masked.
    @JsonKey(name: 'phoneNumber') @Default('') String maskedPhone,
    @JsonKey(unknownEnumValue: PaymentStatus.pending)
    required PaymentStatus status,
    @JsonKey(unknownEnumValue: RegistrationOutcome.pending)
    required RegistrationOutcome registrationStatus,

    /// M-Pesa's own words for a failed payment, such as "Request cancelled
    /// by user".
    @JsonKey(name: 'providerResultDescription') String? providerMessage,
    @JsonKey(readValue: _refundReason) String? refundReason,

    /// Where the refund stands, when there is one: `requested`, `approved`,
    /// `processing`, `manual_review`, `succeeded`, `rejected` or `failed`.
    @JsonKey(readValue: _refundStatus) String? refundStatus,

    /// Looked up from the competition if an older API leaves it out.
    String? competitionName,
    DateTime? createdAt,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  /// Whether to keep polling: the money or the place isn't settled yet. A
  /// payment under review is not polled fast; read it again later.
  bool get isSettling =>
      status == PaymentStatus.initiating ||
      status == PaymentStatus.pending ||
      status == PaymentStatus.callbackReceived ||
      (status == PaymentStatus.succeeded &&
          registrationStatus == RegistrationOutcome.pending);
}

/// `refund.reasonCode`, when there is a refund.
Object? _refundReason(Map<dynamic, dynamic> json, String _) =>
    (json['refund'] as Map?)?['reasonCode'];

Object? _refundStatus(Map<dynamic, dynamic> json, String _) =>
    (json['refund'] as Map?)?['status'];

@JsonEnum(fieldRename: FieldRename.snake)
enum PaymentStatus {
  initiating,
  pending,
  callbackReceived,
  succeeded,
  failed,
  review,
}

/// What the payment did for the player's place.
@JsonEnum(fieldRename: FieldRename.snake)
enum RegistrationOutcome {
  pending,
  registered,
  refundPending,
  refunded,
  removed,
  notRegistered,
}
