import '../../../core/api/api_client.dart';
import '../../../core/api/cursor_page.dart';
import 'ranked_player.dart';

/// The only game for now; the API takes it explicitly.
const _gameId = 'efootball-mobile';

class RankingsRepository {
  RankingsRepository(this._api);

  final ApiClient _api;

  /// The global ladder when [countryCode] is null, else that country's.
  Future<CursorPage<RankedPlayer>> list({
    String? countryCode,
    int limit = 30,
    String? cursor,
  }) async {
    final json = await _api.get(
      withQuery('/v1/rankings', {
        'gameId': _gameId,
        'scope': countryCode == null ? 'global' : 'country',
        'country': countryCode,
        'limit': limit,
        'cursor': cursor,
      }),
    );
    return CursorPage.fromJson(json!, RankedPlayer.fromJson);
  }
}
