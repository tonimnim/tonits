import '../../../core/api/api_client.dart';
import 'match_room.dart';

/// The match room's reads and actions. Every action returns the updated
/// room, and takes an idempotency key so a retry after a dropped
/// connection never acts twice.
class MatchRoomRepository {
  MatchRoomRepository(this._api);

  final ApiClient _api;

  String _path(String matchId) => '/v1/matches/${Uri.encodeComponent(matchId)}';

  Future<MatchRoom> get(String matchId) async {
    final json = await _api.get(_path(matchId), auth: true);
    return MatchRoom.fromJson(json!['data'] as Map<String, dynamic>);
  }

  Future<MatchRoom> checkIn(String matchId, {required String key}) async {
    final json = await _api.post(
      '${_path(matchId)}/check-ins',
      auth: true,
      headers: {'Idempotency-Key': key},
    );
    return MatchRoom.fromJson(json!['data'] as Map<String, dynamic>);
  }

  /// Submits the result: the score in goals for a best of 1, with
  /// penalties for a level knockout match, or games won for a series.
  Future<MatchRoom> reportScore(
    String matchId, {
    required Score score,
    required String key,
  }) => _action(matchId, 'score-reports', key, {
    'homeScore': score.home,
    'awayScore': score.away,
    if (score.penalties case final p?)
      'tiebreak': {
        'type': 'penalties',
        'homeScore': p.home,
        'awayScore': p.away,
      },
    'declarationAccepted': true,
  });

  Future<MatchRoom> answer(
    String matchId, {
    required bool confirm,
    required String key,
  }) => _action(matchId, 'score-reports/confirmation', key, {
    'decision': confirm ? 'confirm' : 'reject',
  });

  /// Sends this side's Full Time screenshots after a rejection, by game.
  /// A best of 1 sends its one screenshot as `evidenceId`.
  Future<MatchRoom> sendScreenshots(
    String matchId, {
    required Map<int, String> evidenceByGame,
    required bool perGame,
    required String key,
  }) => _action(
    matchId,
    'score-reports/screenshot',
    key,
    perGame
        ? {
            'screenshots': [
              for (final MapEntry(key: game, value: id)
                  in (evidenceByGame.entries.toList()
                    ..sort((a, b) => a.key.compareTo(b.key))))
                {'game': game, 'evidenceId': id},
            ],
          }
        : {'evidenceId': evidenceByGame.values.single},
  );

  Future<MatchRoom> _action(
    String matchId,
    String action,
    String key,
    Map<String, Object> body,
  ) async {
    final json = await _api.post(
      '${_path(matchId)}/$action',
      body: body,
      auth: true,
      headers: {'Idempotency-Key': key},
    );
    final data = json!['data'] as Map<String, dynamic>;
    return MatchRoom.fromJson(data['match'] as Map<String, dynamic>);
  }
}
