import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../auth/application/auth_providers.dart';
import '../../rankings/application/rankings_providers.dart';
import '../data/played_match.dart';
import '../data/player_profile.dart';
import '../data/players_repository.dart';
import 'player_stats.dart';
import 'rank_neighbourhood.dart';

final playersRepositoryProvider = Provider<PlayersRepository>(
  (ref) => PlayersRepository(ref.watch(apiClientProvider)),
);

String _myId(Ref ref) {
  final player = ref.watch(currentPlayerProvider);
  if (player == null) throw StateError('Signed out');
  return player.id;
}

/// The game account the player enters competitions with.
final myGameAccountIdProvider = FutureProvider.autoDispose<String?>(
  (ref) => ref.watch(playersRepositoryProvider).myGameAccountId(),
);

/// The signed-in player's public profile: rating, ranks and record.
final myProfileProvider = FutureProvider.autoDispose<PlayerProfile>(
  (ref) => ref.watch(playersRepositoryProvider).profile(_myId(ref)),
);

/// The signed-in player's last 20 confirmed matches, newest first.
final myRecentMatchesProvider = FutureProvider.autoDispose<List<PlayedMatch>>((
  ref,
) async {
  final page = await ref.watch(playersRepositoryProvider).matches(_myId(ref));
  return page.items;
});

final myStatsProvider = FutureProvider.autoDispose<PlayerStats>((ref) async {
  final (profile, recent) = await (
    ref.watch(myProfileProvider.future),
    ref.watch(myRecentMatchesProvider.future),
  ).wait;
  return PlayerStats.from(profile.record, recent);
});

/// The player's slice of their country ladder: up to two places above and
/// below them. A player without a country rank (new, or provisional) gets
/// the top three instead, something to aim for.
/// The player's slice of their country ladder: two places either side of
/// them, at any rank. A player without a rank yet (new, or provisional)
/// gets the top three instead, something to aim for.
final myRankNeighbourhoodProvider =
    FutureProvider.autoDispose<RankNeighbourhood>((ref) async {
      final player = ref.watch(currentPlayerProvider);
      if (player == null) return const RankNeighbourhood([], ranked: false);
      final rankings = ref.watch(rankingsRepositoryProvider);
      final around = await rankings.aroundMe(countryCode: player.countryCode);
      if (around.isNotEmpty) return RankNeighbourhood(around, ranked: true);
      final top = await rankings.list(
        countryCode: player.countryCode,
        limit: 3,
      );
      return RankNeighbourhood(top.items, ranked: false);
    });
