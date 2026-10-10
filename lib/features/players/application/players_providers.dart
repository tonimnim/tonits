import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../auth/application/auth_controller.dart';
import '../../rankings/application/rankings_providers.dart';
import '../../rankings/data/ranked_player.dart';
import '../data/played_match.dart';
import '../data/player_profile.dart';
import '../data/players_repository.dart';
import 'player_stats.dart';

final playersRepositoryProvider = Provider<PlayersRepository>(
  (ref) => PlayersRepository(ref.watch(apiClientProvider)),
);

String _myId(Ref ref) {
  final player = ref.watch(currentPlayerProvider);
  if (player == null) throw StateError('Signed out');
  return player.id;
}

/// The signed-in player's public profile: rating, ranks and record.
final myProfileProvider = FutureProvider.autoDispose<PlayerProfile>(
  (ref) => ref.watch(playersRepositoryProvider).profile(_myId(ref)),
);

/// The signed-in player's last 20 confirmed matches, newest first.
final myRecentMatchesProvider = FutureProvider.autoDispose<List<PlayedMatch>>((
  ref,
) async {
  final page = await ref
      .watch(playersRepositoryProvider)
      .matches(_myId(ref), limit: 20);
  return page.items;
});

final myStatsProvider = FutureProvider.autoDispose<PlayerStats>((ref) async {
  final (profile, recent) = await (
    ref.watch(myProfileProvider.future),
    ref.watch(myRecentMatchesProvider.future),
  ).wait;
  return PlayerStats.from(profile.record, recent);
});

/// The rating line for the player card, or null while the API doesn't serve
/// rating history.
final myRatingHistoryProvider = FutureProvider.autoDispose<List<RatingPoint>?>(
  (ref) => ref.watch(playersRepositoryProvider).ratingHistory(_myId(ref)),
);

/// The player's slice of their country ladder: up to two places above and
/// below them. A player without a country rank (new, or provisional) gets
/// the top three instead, something to aim for.
final myRankNeighbourhoodProvider =
    FutureProvider.autoDispose<RankNeighbourhood>((ref) async {
      final player = ref.watch(currentPlayerProvider);
      if (player == null) return const RankNeighbourhood([], ranked: false);
      final profile = await ref.watch(myProfileProvider.future);
      // A dedicated "around me" query is requested in docs/backend-requests.md;
      // until then, look within the first 50 places.
      final page = await ref
          .watch(rankingsRepositoryProvider)
          .list(countryCode: player.countryCode, limit: 50);
      final ranked = profile.rating?.countryRank != null;
      return RankNeighbourhood(
        ranked
            ? neighbourhood(page.items, player.id)
            : page.items.take(3).toList(),
        ranked: ranked,
      );
    });

class RankNeighbourhood {
  const RankNeighbourhood(this.rows, {required this.ranked});

  final List<RankedPlayer> rows;

  /// Whether [rows] are around the player (true) or the top of the ladder.
  final bool ranked;
}

/// Up to [around] rows either side of [playerId], or the top three when the
/// player isn't in [ladder].
List<RankedPlayer> neighbourhood(
  List<RankedPlayer> ladder,
  String playerId, {
  int around = 2,
}) {
  final i = ladder.indexWhere((r) => r.playerId == playerId);
  if (i < 0) return ladder.take(3).toList();
  final start = (i - around).clamp(0, ladder.length);
  final end = (i + around + 1).clamp(0, ladder.length);
  return ladder.sublist(start, end);
}
