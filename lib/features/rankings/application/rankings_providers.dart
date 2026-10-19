import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/paged.dart';
import '../../../core/providers.dart';
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
