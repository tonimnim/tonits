// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Payment _$PaymentFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Payment',
  json,
  ($checkedConvert) {
    final val = _Payment(
      id: $checkedConvert('id', (v) => v as String),
      competitionId: $checkedConvert('competitionId', (v) => v as String),
      amountMinor: $checkedConvert('amountMinor', (v) => (v as num).toInt()),
      currency: $checkedConvert('currency', (v) => v as String),
      maskedPhone: $checkedConvert('phoneNumber', (v) => v as String? ?? ''),
      status: $checkedConvert(
        'status',
        (v) => $enumDecode(
          _$PaymentStatusEnumMap,
          v,
          unknownValue: PaymentStatus.pending,
        ),
      ),
      registrationStatus: $checkedConvert(
        'registrationStatus',
        (v) => $enumDecode(
          _$RegistrationOutcomeEnumMap,
          v,
          unknownValue: RegistrationOutcome.pending,
        ),
      ),
      providerMessage: $checkedConvert(
        'providerResultDescription',
        (v) => v as String?,
      ),
      refundReason: $checkedConvert(
        'refundReason',
        (v) => v as String?,
        readValue: _refundReason,
      ),
      refundStatus: $checkedConvert(
        'refundStatus',
        (v) => v as String?,
        readValue: _refundStatus,
      ),
      competitionName: $checkedConvert('competitionName', (v) => v as String?),
      createdAt: $checkedConvert(
        'createdAt',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'maskedPhone': 'phoneNumber',
    'providerMessage': 'providerResultDescription',
  },
);

const _$PaymentStatusEnumMap = {
  PaymentStatus.initiating: 'initiating',
  PaymentStatus.pending: 'pending',
  PaymentStatus.callbackReceived: 'callback_received',
  PaymentStatus.succeeded: 'succeeded',
  PaymentStatus.failed: 'failed',
  PaymentStatus.review: 'review',
};

const _$RegistrationOutcomeEnumMap = {
  RegistrationOutcome.pending: 'pending',
  RegistrationOutcome.registered: 'registered',
  RegistrationOutcome.refundPending: 'refund_pending',
  RegistrationOutcome.refunded: 'refunded',
  RegistrationOutcome.removed: 'removed',
  RegistrationOutcome.notRegistered: 'not_registered',
};
