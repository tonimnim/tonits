import 'dart:typed_data';

import '../../../core/api/api_client.dart';
import '../../auth/data/models.dart';
import '../../evidence/data/evidence.dart';

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

  /// Replaces the public profile. The handle is the username; changing it
  /// leaves the display name and Konami ID alone.
  Future<Player> updateProfile(ProfileSettings profile) async {
    final json = await _api.send(
      'PUT',
      '/v1/me/profile',
      body: {
        'handle': profile.handle,
        'bio': profile.bio,
        'discoverable': profile.discoverable,
        'analyticsConsent': profile.analyticsConsent,
        'scoutingConsent': profile.scoutingConsent,
      },
      auth: true,
    );
    return Player.fromJson(json!);
  }

  /// Declares a new profile photo by its type, size and SHA-256.
  Future<UploadIntent> createAvatarUpload({
    required String mediaType,
    required int byteSize,
    required String sha256,
  }) async {
    final json = await _api.post(
      '/v1/me/avatar/uploads',
      body: {'mediaType': mediaType, 'byteSize': byteSize, 'sha256': sha256},
      auth: true,
    );
    return UploadIntent.fromJson(json!['data'] as Map<String, dynamic>);
  }

  /// Sends the photo straight to storage. False when storage refused it.
  Future<bool> uploadAvatar(UploadIntent intent, Uint8List bytes) async {
    final status = await _api.putBytes(
      intent.url,
      bytes,
      headers: intent.headers,
    );
    // 412: a retried PUT whose first attempt already stored the file.
    return (status >= 200 && status < 300) || status == 412;
  }

  /// Checks the stored photo. True once it's ready to use.
  Future<bool> completeAvatarUpload(String id) async {
    final json = await _api.post(
      '/v1/me/avatar/uploads/${Uri.encodeComponent(id)}/complete',
      auth: true,
    );
    final status = (json!['data'] as Map<String, dynamic>)['status'];
    return status == 'completed' || status == 'attached';
  }

  /// Makes a checked upload the profile photo.
  Future<void> selectAvatar(String uploadId) => _api.send(
    'PATCH',
    '/v1/me/avatar',
    body: {'uploadId': uploadId},
    auth: true,
  );

  /// A short-lived link to the player's own photo, or null without one.
  Future<Uri?> myAvatarUrl() async {
    try {
      final json = await _api.get('/v1/me/avatar', auth: true);
      final data = json!['data'] as Map<String, dynamic>;
      return Uri.parse(data['downloadUrl'] as String);
    } on ApiException catch (e) {
      if (e.status == 404) return null;
      rethrow;
    }
  }

  Future<Player> currentPlayer() async {
    final json = await _api.get('/v1/me', auth: true);
    return Player.fromJson(json!);
  }

  Future<Player> _patch(Map<String, Object> changes) async {
    final json = await _api.send('PATCH', '/v1/me', body: changes, auth: true);
    return Player.fromJson(json!);
  }
}
