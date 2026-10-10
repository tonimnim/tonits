import '../data/played_match.dart';
import '../data/player_profile.dart';

/// The numbers on the player's overview, derived from their record and
/// recent matches.
class PlayerStats {
  const PlayerStats({
    required this.record,
    required this.goalsPerMatch,
    required this.goalsSample,
    required this.streak,
  });

  /// [recent] is newest first.
  factory PlayerStats.from(Record record, List<PlayedMatch> recent) {
    // Goals come from the recent matches until the API reports totals
    // (docs/backend-requests.md).
    final goals = recent.fold(0, (sum, m) => sum + m.goalsFor);
    var streakLength = 0;
    for (final m in recent) {
      if (m.result != recent.first.result) break;
      streakLength++;
    }
    return PlayerStats(
      record: record,
      goalsPerMatch: recent.isEmpty ? null : goals / recent.length,
      goalsSample: recent.length,
      streak: recent.isEmpty ? null : (recent.first.result, streakLength),
    );
  }

  final Record record;

  /// Average goals scored over [goalsSample] recent matches.
  final double? goalsPerMatch;
  final int goalsSample;

  /// The current run of identical results, such as three wins.
  final (MatchResult, int)? streak;
}
