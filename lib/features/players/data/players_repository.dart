import '../../../core/api/api_client.dart';
import '../../../core/api/cursor_page.dart';
import 'played_match.dart';
import 'player_profile.dart';

class PlayersRepository {
  PlayersRepository(this._api);

  final ApiClient _api;

  // Player reads carry the token: a profile starts private, and only its
  // owner can read it then.

  Future<PlayerProfile> profile(String playerId) async {
    final json = await _api.get(
      '/v1/players/${Uri.encodeComponent(playerId)}',
      auth: true,
    );
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
      auth: true,
    );
    return CursorPage.fromJson(json!, PlayedMatch.fromJson);
  }

  /// The signed-in player's eFootball game account ID, which entries are
  /// made with. Sign-up creates it from the Konami ID, so there is one.
  Future<String?> myGameAccountId() async {
    final json = await _api.get('/v1/me/game-accounts', auth: true);
    final accounts = (json!['data'] as List).cast<Map<String, dynamic>>();
    return accounts
        .where((a) => a['gameId'] == PlayerProfile.gameId)
        .map((a) => a['id'] as String)
        .firstOrNull;
  }
}
