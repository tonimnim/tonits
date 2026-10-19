import '../../../core/api/api_client.dart';
import 'identity_providers.dart';
import 'models.dart';

/// The authentication routes of the API. Players sign in with Google or
/// Apple.
class AuthRepository {
  AuthRepository(this._api);

  final ApiClient _api;

  Future<AuthSession> signInWithGoogle(
    IdentityToken token, {
    String? deviceName,
  }) => _session('/v1/auth/google', {
    'idToken': token.token,
    'nonce': ?token.nonce,
    'deviceName': ?deviceName,
  });

  Future<AuthSession> signInWithApple(
    IdentityToken token, {
    String? deviceName,
  }) => _session('/v1/auth/apple', {
    'identityToken': token.token,
    'nonce': token.nonce ?? '',
    'deviceName': ?deviceName,
  });

  Future<AuthSession> refresh(String refreshToken) =>
      _session('/v1/auth/refresh', {'refreshToken': refreshToken});

  Future<void> logout() => _api.post('/v1/auth/logout', auth: true);

  /// The one step after a first Google or Apple sign-in. Also records the
  /// current Terms and Privacy Notice as accepted.
  Future<Player> completeOnboarding({
    String? username,
    required String konamiId,
    required String phoneNumber,
    required String countryCode,
  }) async {
    final json = await _api.post(
      '/v1/me/onboarding',
      body: {
        'username': ?username,
        'konamiId': konamiId,
        'phoneNumber': phoneNumber,
        'countryCode': countryCode,
      },
      auth: true,
    );
    return Player.fromJson(json!);
  }

  /// Whether [username] is free. The player's own current handle counts as
  /// available. Submitting can still lose a race, so `username_taken`
  /// stays possible.
  Future<bool> usernameAvailable(String username) async {
    final json = await _api.get(
      '/v1/usernames/${Uri.encodeComponent(username)}/availability',
      auth: true,
    );
    return json!['available'] as bool;
  }

  Future<List<LegalDocument>> currentLegalDocuments() async {
    final json = await _api.get('/v1/legal/documents/current');
    return (json!['data'] as List)
        .cast<Map<String, dynamic>>()
        .map(LegalDocument.fromJson)
        .toList();
  }

  Uri resolve(String reference) => _api.resolve(reference);

  Future<AuthSession> _session(String path, Map<String, Object> body) async {
    final json = await _api.post(path, body: body);
    return AuthSession.fromJson(json!);
  }
}
