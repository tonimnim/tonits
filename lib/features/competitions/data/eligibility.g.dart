// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eligibility.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Eligibility _$EligibilityFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Eligibility', json, ($checkedConvert) {
      final val = _Eligibility(
        status: $checkedConvert('status', (v) => v as String),
        eligible: $checkedConvert('eligible', (v) => v as bool),
        requiredAction: $checkedConvert(
          'requiredAction',
          (v) => $enumDecode(
            _$RequiredActionEnumMap,
            v,
            unknownValue: RequiredAction.none,
          ),
        ),
        entryFeeMinor: $checkedConvert(
          'entryFeeMinor',
          (v) => (v as num?)?.toInt() ?? 0,
        ),
        currency: $checkedConvert('currency', (v) => v as String),
        issues: $checkedConvert(
          'issues',
          (v) =>
              (v as List<dynamic>?)
                  ?.map(
                    (e) => EligibilityIssue.fromJson(e as Map<String, dynamic>),
                  )
                  .toList() ??
              const <EligibilityIssue>[],
        ),
        paymentId: $checkedConvert('paymentId', (v) => v as String?),
        entryId: $checkedConvert('entryId', (v) => v as String?),
      );
      return val;
    });

const _$RequiredActionEnumMap = {
  RequiredAction.none: 'none',
  RequiredAction.submitRegistration: 'submit_registration',
  RequiredAction.startPayment: 'start_payment',
  RequiredAction.pollPayment: 'poll_payment',
  RequiredAction.viewRegistration: 'view_registration',
  RequiredAction.viewRefund: 'view_refund',
};

_EligibilityIssue _$EligibilityIssueFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EligibilityIssue', json, ($checkedConvert) {
      final val = _EligibilityIssue(
        code: $checkedConvert('code', (v) => v as String),
        severity: $checkedConvert('severity', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String),
      );
      return val;
    });
