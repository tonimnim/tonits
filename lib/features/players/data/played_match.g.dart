// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'played_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlayedMatch _$PlayedMatchFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PlayedMatch', json, ($checkedConvert) {
  final val = _PlayedMatch(
    matchId: $checkedConvert('matchId', (v) => v as String),
    playedAt: $checkedConvert('playedAt', (v) => DateTime.parse(v as String)),
    opponentName: $checkedConvert(
      'opponentName',
      (v) => v as String?,
      readValue: _opponentName,
    ),
    goalsFor: $checkedConvert(
      'goalsFor',
      (v) => (v as num).toInt(),
      readValue: _goalsFor,
    ),
    goalsAgainst: $checkedConvert(
      'goalsAgainst',
      (v) => (v as num).toInt(),
      readValue: _goalsAgainst,
    ),
    result: $checkedConvert(
      'outcome',
      (v) =>
          $enumDecode(_$MatchResultEnumMap, v, unknownValue: MatchResult.draw),
    ),
    competitionName: $checkedConvert(
      'competitionName',
      (v) => v as String,
      readValue: _competitionName,
    ),
    stage: $checkedConvert('stage', (v) => v as String),
  );
  return val;
}, fieldKeyMap: const {'result': 'outcome'});

const _$MatchResultEnumMap = {
  MatchResult.win: 'win',
  MatchResult.draw: 'draw',
  MatchResult.loss: 'loss',
};
