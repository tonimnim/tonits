import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../auth/application/auth_providers.dart';
import '../data/played_match.dart';
import '../data/player_profile.dart';
import '../data/players_repository.dart';

final playersRepositoryProvider = Provider<PlayersRepository>(
  (ref) => PlayersRepository(ref.watch(apiClientProvider)),
);

/// The signed-in player's id. Only the id is watched: an edit to the
/// account (a new name, a phone) must not fetch their profile again.
String _myId(Ref ref) {
  final id = ref.watch(currentPlayerProvider.select((p) => p?.id));
  if (id == null) throw StateError('Signed out');
  return id;
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
