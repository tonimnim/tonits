// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Competition _$CompetitionFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Competition',
  json,
  ($checkedConvert) {
    final val = _Competition(
      id: $checkedConvert('id', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      gameName: $checkedConvert('gameName', (v) => v as String),
      organizerName: $checkedConvert('organizerName', (v) => v as String),
      format: $checkedConvert(
        'format',
        (v) => $enumDecode(
          _$CompetitionFormatEnumMap,
          v,
          unknownValue: CompetitionFormat.unknown,
        ),
      ),
      status: $checkedConvert(
        'status',
        (v) => $enumDecode(
          _$CompetitionStatusEnumMap,
          v,
          unknownValue: CompetitionStatus.unknown,
        ),
      ),
      maxEntries: $checkedConvert('maxEntries', (v) => (v as num).toInt()),
      entryCount: $checkedConvert('entryCount', (v) => (v as num).toInt()),
      entryType: $checkedConvert(
        'entryType',
        (v) => $enumDecode(_$EntryTypeEnumMap, v, unknownValue: EntryType.free),
      ),
      entryFeeMinor: $checkedConvert(
        'entryFeeMinor',
        (v) => (v as num?)?.toInt() ?? 0,
      ),
      currency: $checkedConvert('currency', (v) => v as String),
      prizeAmountMinor: $checkedConvert(
        'prizeAmountMinor',
        (v) => (v as num?)?.toInt() ?? 0,
      ),
      startsAt: $checkedConvert('startsAt', (v) => DateTime.parse(v as String)),
      registrationClosesAt: $checkedConvert(
        'registrationClosesAt',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      description: $checkedConvert('description', (v) => v as String? ?? ''),
      matchFormat: $checkedConvert(
        'matchFormat',
        (v) =>
            v == null ? null : MatchFormat.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
);

const _$CompetitionFormatEnumMap = {
  CompetitionFormat.singleElimination: 'single_elimination',
  CompetitionFormat.doubleElimination: 'double_elimination',
  CompetitionFormat.roundRobin: 'round_robin',
  CompetitionFormat.unknown: 'unknown',
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

const _$EntryTypeEnumMap = {EntryType.free: 'free', EntryType.paid: 'paid'};

_MatchFormat _$MatchFormatFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_MatchFormat', json, ($checkedConvert) {
      final val = _MatchFormat(
        bestOf: $checkedConvert('bestOf', (v) => (v as num?)?.toInt() ?? 1),
        rounds: $checkedConvert(
          'rounds',
          (v) =>
              (v as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toInt()),
              ) ??
              const <String, int>{},
        ),
      );
      return val;
    });
