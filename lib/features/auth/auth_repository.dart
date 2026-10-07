import '../../core/api/api_client.dart';
import 'models.dart';

/// The authentication routes of the Tonits API.
class AuthRepository {
  AuthRepository(this._api);

  final ApiClient _api;

  Future<AuthSession> register({
    required String username,
    required String konamiId,
    required String password,
    String? deviceName,
  }) async {
    final json = await _api.post(
      '/v1/auth/register',
      body: {
        'username': username,
        'konamiId': konamiId,
        'password': password,
        'deviceName': ?deviceName,
      },
    );
    return AuthSession.fromJson(json!);
  }

  Future<AuthSession> signIn({
    required String konamiId,
    required String password,
    String? deviceName,
  }) async {
    final json = await _api.post(
      '/v1/auth/login',
      body: {
        'konamiId': konamiId,
        'password': password,
        'deviceName': ?deviceName,
      },
    );
    return AuthSession.fromJson(json!);
  }

  Future<AuthSession> refresh(String refreshToken) async {
    final json = await _api.post(
      '/v1/auth/refresh',
      body: {'refreshToken': refreshToken},
    );
    return AuthSession.fromJson(json!);
  }

  Future<void> logout() => _api.post('/v1/auth/logout', auth: true);

  /// Always succeeds for a well-formed Konami ID; a code is emailed only if
  /// the account has a verified email.
  Future<void> requestPasswordReset(String konamiId) => _api.post(
    '/v1/auth/password-reset/request',
    body: {'konamiId': konamiId},
  );

  Future<void> confirmPasswordReset({
    required String konamiId,
    required String code,
    required String newPassword,
  }) => _api.post(
    '/v1/auth/password-reset/confirm',
    body: {'konamiId': konamiId, 'code': code, 'newPassword': newPassword},
  );

  Future<Player> currentPlayer() async {
    final json = await _api.get('/v1/me', auth: true);
    return Player.fromJson(json!);
  }

  /// Sets the player's country. A chosen country is kept when a phone number
  /// is saved later.
  Future<Player> updateCountry(String countryCode) async {
    final json = await _api.send(
      'PATCH',
      '/v1/me',
      body: {'countryCode': countryCode},
      auth: true,
    );
    return Player.fromJson(json!);
  }

  Future<List<LegalDocument>> currentLegalDocuments() async {
    final json = await _api.get('/v1/legal/documents/current');
    return (json!['data'] as List)
        .cast<Map<String, dynamic>>()
        .map(LegalDocument.fromJson)
        .toList();
  }

  Uri resolve(String reference) => _api.resolve(reference);
}
