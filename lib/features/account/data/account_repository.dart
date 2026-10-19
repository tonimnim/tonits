import '../../../core/api/api_client.dart';
import '../../auth/data/models.dart';

/// Changes to the signed-in player's own account. Every change that
/// returns the player gives back the updated one.
class AccountRepository {
  AccountRepository(this._api);

  final ApiClient _api;

  Future<Player> updateDisplayName(String displayName) =>
      _patch({'displayName': displayName});

  Future<Player> updateCountry(String countryCode) =>
      _patch({'countryCode': countryCode});

  /// Emails a 6-digit code to [email]; it becomes the account's address
  /// once verified. Returns how long the code lasts, when the API says.
  Future<Duration?> requestEmailCode(String email) async {
    final json = await _api.post(
      '/v1/me/email',
      body: {'email': email},
      auth: true,
    );
    final seconds = json?['expiresInSeconds'];
    return seconds is int ? Duration(seconds: seconds) : null;
  }

  Future<Player> verifyEmail(String code) async {
    final json = await _api.post(
      '/v1/me/email/verify',
      body: {'code': code},
      auth: true,
    );
    return Player.fromJson(json!);
  }

  /// [phoneNumber] in international format, such as +254712345678.
  Future<Player> savePhone(String phoneNumber) async {
    final json = await _api.send(
      'PUT',
      '/v1/me/phone',
      body: {'phoneNumber': phoneNumber},
      auth: true,
    );
    return Player.fromJson(json!);
  }

  Future<void> removePhone() => _api.send('DELETE', '/v1/me/phone', auth: true);

  Future<Player> currentPlayer() async {
    final json = await _api.get('/v1/me', auth: true);
    return Player.fromJson(json!);
  }

  Future<Player> _patch(Map<String, Object> changes) async {
    final json = await _api.send('PATCH', '/v1/me', body: changes, auth: true);
    return Player.fromJson(json!);
  }
}
