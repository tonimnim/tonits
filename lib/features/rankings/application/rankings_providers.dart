import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/cursor_page.dart';
import '../../../core/api/paged.dart';
import '../../../core/providers.dart';
import '../data/ranked_player.dart';
import '../data/rankings_repository.dart';

final rankingsRepositoryProvider = Provider<RankingsRepository>(
  (ref) => RankingsRepository(ref.watch(apiClientProvider)),
);

/// A ladder: global when the country code is null.
final rankingsProvider = AsyncNotifierProvider.autoDispose
    .family<RankingsNotifier, Paged<RankedPlayer>, String?>(
      RankingsNotifier.new,
    );

class RankingsNotifier extends PagedNotifier<RankedPlayer> {
  RankingsNotifier(this.countryCode);

  final String? countryCode;

  @override
  Future<CursorPage<RankedPlayer>> fetchPage(String? cursor) => ref
      .read(rankingsRepositoryProvider)
      .list(countryCode: countryCode, cursor: cursor);
}
