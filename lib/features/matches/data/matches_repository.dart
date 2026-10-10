import '../../../core/api/api_client.dart';
import '../../../core/api/cursor_page.dart';
import 'match_summary.dart';

enum MatchListKind { active, history }

class MatchesRepository {
  MatchesRepository(this._api);

  final ApiClient _api;

  /// The signed-in player's matches.
  Future<CursorPage<MatchSummary>> mine({
    required MatchListKind kind,
    int limit = 20,
    String? cursor,
  }) async {
    final json = await _api.get(
      withQuery('/v1/me/matches', {
        'state': kind.name,
        'limit': limit,
        'cursor': cursor,
      }),
      auth: true,
    );
    return CursorPage.fromJson(json!, MatchSummary.fromJson);
  }
}
