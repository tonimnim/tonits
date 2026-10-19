import '../../../core/api/api_client.dart';
import 'identity_providers.dart';
import 'models.dart';

/// The authentication routes of the Tonits API. Players sign in with Google
/// or Apple; Konami ID and password exist only for local test accounts.
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

  /// A local test account. Production answers 403.
  Future<AuthSession> devSignIn({
    required String konamiId,
    required String password,
    String? deviceName,
  }) => _session('/v1/auth/login', {
    'konamiId': konamiId,
    'password': password,
    'deviceName': ?deviceName,
  });

  /// Creates a local test account, already onboarded. Production answers
  /// 403 password_registration_disabled.
  Future<AuthSession> devRegister({
    required String username,
    required String konamiId,
    required String password,
    String? deviceName,
  }) => _session('/v1/auth/register', {
    'username': username,
    'konamiId': konamiId,
    'password': password,
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
