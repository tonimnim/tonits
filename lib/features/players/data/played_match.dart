import 'package:freezed_annotation/freezed_annotation.dart';

part 'played_match.freezed.dart';
part 'played_match.g.dart';

/// A confirmed match from a player's public history (`PublicMatch`), seen
/// from that player's side.
@freezed
abstract class PlayedMatch with _$PlayedMatch {
  const factory PlayedMatch({
    required String matchId,
    required DateTime playedAt,

    /// Null when the opponent's profile is no longer public.
    @JsonKey(readValue: _opponentName) String? opponentName,
    @JsonKey(readValue: _goalsFor) required int goalsFor,
    @JsonKey(readValue: _goalsAgainst) required int goalsAgainst,
    @JsonKey(name: 'outcome', unknownEnumValue: MatchResult.draw)
    required MatchResult result,
    @JsonKey(readValue: _competitionName) required String competitionName,
    required String stage,
  }) = _PlayedMatch;

  factory PlayedMatch.fromJson(Map<String, dynamic> json) =>
      _$PlayedMatchFromJson(json);
}

Object? _opponentName(Map<dynamic, dynamic> json, String _) =>
    (json['opponent'] as Map?)?['displayName'];
Object? _goalsFor(Map<dynamic, dynamic> json, String _) =>
    (json['score'] as Map?)?['player'];
Object? _goalsAgainst(Map<dynamic, dynamic> json, String _) =>
    (json['score'] as Map?)?['opponent'];
Object? _competitionName(Map<dynamic, dynamic> json, String _) =>
    (json['competition'] as Map?)?['name'];

enum MatchResult {
  win('W'),
  draw('D'),
  loss('L');

  const MatchResult(this.letter);

  final String letter;
}

/// A point on the player's rating line.
@freezed
abstract class RatingPoint with _$RatingPoint {
  const factory RatingPoint({required DateTime at, required int rating}) =
      _RatingPoint;

  factory RatingPoint.fromJson(Map<String, dynamic> json) =>
      _$RatingPointFromJson(json);
}
