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
        competitionName: $checkedConvert(
          'competitionName',
          (v) => v as String? ?? '',
        ),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(
            _$EntryStatusEnumMap,
            v,
            unknownValue: EntryStatus.unknown,
          ),
        ),
        competitionStatus: $checkedConvert(
          'competitionStatus',
          (v) =>
              $enumDecodeNullable(
                _$CompetitionStatusEnumMap,
                v,
                unknownValue: CompetitionStatus.unknown,
              ) ??
              CompetitionStatus.unknown,
        ),
        entryFeeMinor: $checkedConvert(
          'entryFeeMinor',
          (v) => (v as num?)?.toInt() ?? 0,
        ),
        currency: $checkedConvert('currency', (v) => v as String? ?? 'KES'),
        startsAt: $checkedConvert(
          'startsAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

const _$EntryStatusEnumMap = {
  EntryStatus.registered: 'registered',
  EntryStatus.checkedIn: 'checked_in',
  EntryStatus.accepted: 'accepted',
  EntryStatus.withdrawalPending: 'withdrawal_pending',
  EntryStatus.withdrawn: 'withdrawn',
  EntryStatus.disqualified: 'disqualified',
  EntryStatus.unknown: 'unknown',
};

const _$CompetitionStatusEnumMap = {
  CompetitionStatus.published: 'published',
  CompetitionStatus.registrationOpen: 'registration_open',
  CompetitionStatus.checkIn: 'check_in',
  CompetitionStatus.running: 'running',
  CompetitionStatus.completed: 'completed',
  CompetitionStatus.cancelled: 'cancelled',
  CompetitionStatus.unknown: 'unknown',
};
