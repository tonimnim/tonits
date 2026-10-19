// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlayerProfile _$PlayerProfileFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PlayerProfile', json, ($checkedConvert) {
      final val = _PlayerProfile(
        playerId: $checkedConvert('playerId', (v) => v as String),
        displayName: $checkedConvert('displayName', (v) => v as String),
        countryCode: $checkedConvert('countryCode', (v) => v as String),
        record: $checkedConvert(
          'record',
          (v) => MatchRecord.fromJson(v as Map<String, dynamic>),
        ),
        ratings: $checkedConvert(
          'ratings',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => GameRating.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const <GameRating>[],
        ),
        joinedAt: $checkedConvert(
          'joinedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

_MatchRecord _$MatchRecordFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_MatchRecord', json, ($checkedConvert) {
      final val = _MatchRecord(
        matchesPlayed: $checkedConvert(
          'matchesPlayed',
          (v) => (v as num).toInt(),
        ),
        wins: $checkedConvert('wins', (v) => (v as num).toInt()),
        draws: $checkedConvert('draws', (v) => (v as num).toInt()),
        losses: $checkedConvert('losses', (v) => (v as num).toInt()),
      );
      return val;
    });

_GameRating _$GameRatingFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_GameRating', json, ($checkedConvert) {
  final val = _GameRating(
    gameId: $checkedConvert('gameId', (v) => v as String),
    rating: $checkedConvert('rating', (v) => (v as num).toInt()),
    globalRank: $checkedConvert('globalRank', (v) => (v as num?)?.toInt()),
    countryRank: $checkedConvert('countryRank', (v) => (v as num?)?.toInt()),
    rankMovement: $checkedConvert('rankMovement', (v) => (v as num?)?.toInt()),
  );
  return val;
});
