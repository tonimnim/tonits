import '../../../core/api/api_client.dart';
import '../../../core/api/cursor_page.dart';
import 'competition.dart';

class CompetitionsRepository {
  CompetitionsRepository(this._api);

  final ApiClient _api;

  /// Public discovery. Newest-starting first, as the API orders them.
  Future<CursorPage<Competition>> list({
    CompetitionStatus? status,
    int limit = 20,
    String? cursor,
  }) async {
    final json = await _api.get(
      withQuery('/v1/competitions', {
        'status': status?.wire,
        'limit': limit,
        'cursor': cursor,
      }),
    );
    return CursorPage.fromJson(json!, Competition.fromJson);
  }
}
