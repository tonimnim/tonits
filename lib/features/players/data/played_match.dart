/// A confirmed match from a player's public history (`PublicMatch`), seen
/// from that player's side.
class PlayedMatch {
  const PlayedMatch({
    required this.matchId,
    required this.playedAt,
    required this.opponentName,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.result,
    required this.competitionName,
    required this.stage,
  });

  factory PlayedMatch.fromJson(Map<String, dynamic> json) {
    final score = json['score'] as Map<String, dynamic>;
    final opponent = json['opponent'] as Map<String, dynamic>?;
    return PlayedMatch(
      matchId: json['matchId'] as String,
      playedAt: DateTime.parse(json['playedAt'] as String),
      opponentName: opponent?['displayName'] as String?,
      goalsFor: score['player'] as int,
      goalsAgainst: score['opponent'] as int,
      result: MatchResult.parse(json['outcome'] as String),
      competitionName: (json['competition'] as Map)['name'] as String,
      stage: json['stage'] as String,
    );
  }

  final String matchId;
  final DateTime playedAt;

  /// Null when the opponent's profile is no longer public.
  final String? opponentName;
  final int goalsFor;
  final int goalsAgainst;
  final MatchResult result;
  final String competitionName;
  final String stage;
}

enum MatchResult {
  win('W'),
  draw('D'),
  loss('L');

  const MatchResult(this.letter);

  final String letter;

  static MatchResult parse(String value) => switch (value) {
    'win' => win,
    'loss' => loss,
    _ => draw,
  };
}

/// A point on the player's rating line.
class RatingPoint {
  const RatingPoint({required this.at, required this.rating});

  factory RatingPoint.fromJson(Map<String, dynamic> json) => RatingPoint(
    at: DateTime.parse(json['at'] as String),
    rating: json['rating'] as int,
  );

  final DateTime at;
  final int rating;
}
