import '../../../core/api/api_client.dart';
import '../../../core/api/cursor_page.dart';
import 'played_match.dart';
import 'player_profile.dart';

class PlayersRepository {
  PlayersRepository(this._api);

  final ApiClient _api;

  Future<PlayerProfile> profile(String playerId) async {
    final json = await _api.get('/v1/players/${Uri.encodeComponent(playerId)}');
    return PlayerProfile.fromJson(json!);
  }

  /// Confirmed matches, newest first.
  Future<CursorPage<PlayedMatch>> matches(
    String playerId, {
    int limit = 20,
    String? cursor,
  }) async {
    final json = await _api.get(
      withQuery('/v1/players/${Uri.encodeComponent(playerId)}/matches', {
        'limit': limit,
        'cursor': cursor,
      }),
    );
    return CursorPage.fromJson(json!, PlayedMatch.fromJson);
  }

  /// The player's rating over the last [days] days, oldest first.
  ///
  /// Proposed endpoint (see docs/backend-requests.md): returns null while the
  /// API doesn't serve it, so the trend line is simply left out.
  Future<List<RatingPoint>?> ratingHistory(
    String playerId, {
    int days = 30,
  }) async {
    try {
      final json = await _api.get(
        withQuery(
          '/v1/players/${Uri.encodeComponent(playerId)}/rating-history',
          {'gameId': PlayerProfile.gameId, 'days': days},
        ),
      );
      return (json!['data'] as List)
          .cast<Map<String, dynamic>>()
          .map(RatingPoint.fromJson)
          .toList();
    } on ApiException catch (e) {
      if (e.status == 404) return null;
      rethrow;
    }
  }
}
