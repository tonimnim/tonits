// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Registration _$RegistrationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Registration', json, ($checkedConvert) {
      final val = _Registration(
        id: $checkedConvert('id', (v) => v as String),
        competitionId: $checkedConvert('competitionId', (v) => v as String),
        status: $checkedConvert('status', (v) => v as String),
        entryFeeMinor: $checkedConvert(
          'entryFeeMinor',
          (v) => (v as num?)?.toInt() ?? 0,
        ),
      );
      return val;
    });
