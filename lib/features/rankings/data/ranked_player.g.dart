// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranked_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RankedPlayer _$RankedPlayerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_RankedPlayer', json, ($checkedConvert) {
  final val = _RankedPlayer(
    playerId: $checkedConvert('playerId', (v) => v as String),
    rank: $checkedConvert('rank', (v) => (v as num?)?.toInt()),
    handle: $checkedConvert('handle', (v) => v as String),
    displayName: $checkedConvert('displayName', (v) => v as String),
    countryCode: $checkedConvert('countryCode', (v) => v as String),
    rating: $checkedConvert('rating', (v) => (v as num?)?.toInt()),
    matchesPlayed: $checkedConvert('matchesPlayed', (v) => (v as num).toInt()),
    rankMovement: $checkedConvert('rankMovement', (v) => (v as num?)?.toInt()),
  );
  return val;
});
