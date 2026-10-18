import '../../../core/api/api_client.dart';
import '../../../core/api/cursor_page.dart';
import 'competition.dart';
import 'eligibility.dart';
import 'registration.dart';

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

  Future<Competition> get(String id) async {
    final json = await _api.get('/v1/competitions/${Uri.encodeComponent(id)}');
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
}
