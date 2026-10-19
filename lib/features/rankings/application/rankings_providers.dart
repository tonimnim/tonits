import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/paged.dart';
import '../../../core/providers.dart';
import '../../auth/application/auth_providers.dart';
import '../data/ranked_player.dart';
import '../data/rankings_repository.dart';
import 'rankings_notifier.dart';

final rankingsRepositoryProvider = Provider<RankingsRepository>(
  (ref) => RankingsRepository(ref.watch(apiClientProvider)),
);

/// A ladder: global when the country code is null.
final rankingsProvider = AsyncNotifierProvider.autoDispose
    .family<RankingsNotifier, Paged<RankedPlayer>, String?>(
      RankingsNotifier.new,
    );

/// The signed-in player's own row on a ladder (global when the country code
/// is null), or null while they aren't ranked on it.
final myPlaceProvider = FutureProvider.autoDispose
    .family<RankedPlayer?, String?>((ref, countryCode) async {
      final me = ref.watch(currentPlayerProvider)?.id;
      final rows = await ref
          .watch(rankingsRepositoryProvider)
          .aroundMe(countryCode: countryCode, span: 1);
      return rows.where((r) => r.playerId == me).firstOrNull;
    });
