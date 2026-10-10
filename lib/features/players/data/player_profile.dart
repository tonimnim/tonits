/// A player's public profile (`PublicPlayerProfile`), reduced to what the app
/// shows: their record and their rating for the one game we run.
class PlayerProfile {
  const PlayerProfile({
    required this.playerId,
    required this.displayName,
    required this.countryCode,
    required this.record,
    required this.rating,
  });

  factory PlayerProfile.fromJson(Map<String, dynamic> json) {
    final ratings = (json['ratings'] as List? ?? const [])
        .cast<Map<String, dynamic>>();
    final efootball = ratings
        .where((r) => r['gameId'] == gameId)
        .map(GameRating.fromJson)
        .firstOrNull;
    return PlayerProfile(
      playerId: json['playerId'] as String,
      displayName: json['displayName'] as String,
      countryCode: json['countryCode'] as String,
      record: Record.fromJson(json['record'] as Map<String, dynamic>),
      rating: efootball,
    );
  }

  static const gameId = 'efootball-mobile';

  final String playerId;
  final String displayName;
  final String countryCode;
  final Record record;

  /// Null until the player has a rating for eFootball.
  final GameRating? rating;

  bool get hasPlayed => record.matchesPlayed > 0;
}

/// Wins, draws and losses across confirmed matches.
class Record {
  const Record({
    required this.matchesPlayed,
    required this.wins,
    required this.draws,
    required this.losses,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    matchesPlayed: json['matchesPlayed'] as int,
    wins: json['wins'] as int,
    draws: json['draws'] as int,
    losses: json['losses'] as int,
  );

  final int matchesPlayed;
  final int wins;
  final int draws;
  final int losses;

  /// 0–1, or null before the first match.
  double? get winRate => matchesPlayed == 0 ? null : wins / matchesPlayed;
}

class GameRating {
  const GameRating({
    required this.rating,
    required this.globalRank,
    required this.countryRank,
    required this.rankMovement,
  });

  factory GameRating.fromJson(Map<String, dynamic> json) => GameRating(
    rating: json['rating'] as int,
    globalRank: json['globalRank'] as int?,
    countryRank: json['countryRank'] as int?,
    rankMovement: json['rankMovement'] as int?,
  );

  final int rating;

  /// Null while provisional.
  final int? globalRank;
  final int? countryRank;

  /// Places gained (positive) or lost since the previous snapshot.
  final int? rankMovement;
}
