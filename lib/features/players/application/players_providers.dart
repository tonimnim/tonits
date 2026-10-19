import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../auth/application/auth_providers.dart';
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
