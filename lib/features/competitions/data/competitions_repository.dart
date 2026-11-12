import '../../../core/api/api_client.dart';
import '../../../core/api/cursor_page.dart';
import 'competition.dart';
import 'draw.dart';
import 'eligibility.dart';
import 'registration.dart';

class CompetitionsRepository {
  CompetitionsRepository(this._api);

  final ApiClient _api;

  /// Public discovery. Newest-starting first, as the API orders them.
  /// Signed in ([auth]), each one also says whether the player set a
  /// reminder.
  Future<CursorPage<Competition>> list({
    CompetitionStatus? status,
    int limit = 20,
    String? cursor,
    bool auth = false,
  }) async {
    final json = await _api.get(
      withQuery('/v1/competitions', {
        'status': status?.wire,
        'limit': limit,
        'cursor': cursor,
      }),
      optionalAuth: auth,
    );
    return CursorPage.fromJson(json!, Competition.fromJson);
  }

  /// Public, so it is read signed in when the player is: it then also says
  /// whether they set a reminder.
  Future<Competition> get(String id) async {
    final json = await _api.get(
      '/v1/competitions/${Uri.encodeComponent(id)}',
      optionalAuth: true,
    );
    return Competition.fromJson(json!['data'] as Map<String, dynamic>);
  }

  /// The server's entry decision for the signed-in player.
  Future<Eligibility> eligibility(String id, {String? gameAccountId}) async {
    final json = await _api.get(
      withQuery('/v1/competitions/${Uri.encodeComponent(id)}/eligibility', {
        'gameAccountId': gameAccountId,
      }),
      auth: true,
    );
    return Eligibility.fromJson(json!['data'] as Map<String, dynamic>);
  }

  /// Enters a free competition. [idempotencyKey] is one per entry attempt,
  /// reused only to retry that same attempt.
  Future<Registration> register(
    String id, {
    required String gameAccountId,
    required String idempotencyKey,
  }) async {
    final json = await _api.post(
      '/v1/competitions/${Uri.encodeComponent(id)}/registrations',
      body: {'gameAccountId': gameAccountId},
      headers: {'Idempotency-Key': idempotencyKey},
      auth: true,
    );
    return Registration.fromJson(json!['data'] as Map<String, dynamic>);
  }

  /// Withdraws a free entry.
  Future<void> withdraw(String id) => _api.send(
    'DELETE',
    '/v1/competitions/${Uri.encodeComponent(id)}/registrations/me',
    auth: true,
  );

  /// Asks to leave a paid competition. The entry stays reserved, as
  /// `withdrawal_pending`, until staff review the refund.
  /// [idempotencyKey] is one per request, reused only to retry it.
  Future<void> requestWithdrawal(
    String id, {
    required String idempotencyKey,
  }) => _api.post(
    '/v1/competitions/${Uri.encodeComponent(id)}/registrations/me/withdrawal-requests',
    body: {'reasonCode': 'player_withdrawal'},
    headers: {'Idempotency-Key': idempotencyKey},
    auth: true,
  );

  /// The draw: every stage, round and match. Empty before the draw.
  Future<Bracket> bracket(String id) async {
    final json = await _api.get(
      '/v1/competitions/${Uri.encodeComponent(id)}/bracket',
    );
    return Bracket.fromJson(json!['data'] as Map<String, dynamic>);
  }

  /// Group tables, and the final placings once it's over.
  /// Asks to be told when [id]'s entries open ([on]), or stops asking.
  Future<void> setReminder(String id, {required bool on}) => _api.send(
    on ? 'PUT' : 'DELETE',
    '/v1/me/competition-reminders/${Uri.encodeComponent(id)}',
    auth: true,
  );

  Future<Standings> standings(String id) async {
    final json = await _api.get(
      '/v1/competitions/${Uri.encodeComponent(id)}/standings',
    );
    return Standings.fromJson(json!['data'] as Map<String, dynamic>);
  }

  /// The signed-in player's entries, newest first.
  Future<CursorPage<Registration>> myRegistrations({
    int limit = 50,
    String? cursor,
  }) async {
    final json = await _api.get(
      withQuery('/v1/me/registrations', {'limit': limit, 'cursor': cursor}),
      auth: true,
    );
    return CursorPage.fromJson(json!, Registration.fromJson);
  }
}
