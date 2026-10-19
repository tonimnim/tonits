import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_profile.freezed.dart';
part 'player_profile.g.dart';

/// A player's public profile (`PublicPlayerProfile`): their record, and
/// their rating for the one game we run.
@freezed
abstract class PlayerProfile with _$PlayerProfile {
  const PlayerProfile._();

  const factory PlayerProfile({
    required String playerId,
    required String displayName,
    required String countryCode,
    required MatchRecord record,
    @Default(<GameRating>[]) List<GameRating> ratings,
    DateTime? joinedAt,
  }) = _PlayerProfile;

  factory PlayerProfile.fromJson(Map<String, dynamic> json) =>
      _$PlayerProfileFromJson(json);

  static const gameId = 'efootball-mobile';

  /// Null until the player has a rating for eFootball.
  GameRating? get rating =>
      ratings.where((r) => r.gameId == gameId).firstOrNull;

  bool get hasPlayed => record.matchesPlayed > 0;
}

/// Wins, draws and losses across confirmed matches.
@freezed
abstract class MatchRecord with _$MatchRecord {
  const MatchRecord._();

  const factory MatchRecord({
    required int matchesPlayed,
    required int wins,
    required int draws,
    required int losses,
  }) = _MatchRecord;

  factory MatchRecord.fromJson(Map<String, dynamic> json) =>
      _$MatchRecordFromJson(json);

  /// 0–1, or null before the first match.
  double? get winRate => matchesPlayed == 0 ? null : wins / matchesPlayed;
}

@freezed
abstract class GameRating with _$GameRating {
  const factory GameRating({
    required String gameId,
    required int rating,

    /// Null while provisional.
    int? globalRank,
    int? countryRank,

    /// Places gained (positive) or lost since the previous snapshot.
    int? rankMovement,
  }) = _GameRating;

  factory GameRating.fromJson(Map<String, dynamic> json) =>
      _$GameRatingFromJson(json);
}
