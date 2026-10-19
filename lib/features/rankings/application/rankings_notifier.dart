import '../../../core/api/cursor_page.dart';
import '../../../core/api/paged.dart';
import '../data/ranked_player.dart';
import 'rankings_providers.dart';

class RankingsNotifier extends PagedNotifier<RankedPlayer> {
  RankingsNotifier(this.countryCode);

  final String? countryCode;

  @override
  Future<CursorPage<RankedPlayer>> fetchPage(String? cursor) => ref
      .read(rankingsRepositoryProvider)
      .list(countryCode: countryCode, cursor: cursor);
}
