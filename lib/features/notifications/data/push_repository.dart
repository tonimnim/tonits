import '../../../core/api/api_client.dart';

/// This device's registration for the signed-in player's pushes.
class PushRepository {
  PushRepository(this._api);

  final ApiClient _api;

  /// Registers (or refreshes) the device's FCM token and returns the
  /// installation's id, which signing out removes again. The server keeps
  /// one installation per [deviceId].
  Future<String> register({
    required String deviceId,
    required String platform,
    required String token,
  }) async {
    final json = await _api.post(
      '/v1/me/push-tokens',
      body: {'deviceId': deviceId, 'platform': platform, 'token': token},
      auth: true,
    );
    // The device comes back as it is, without a data envelope.
    final device = (json!['data'] as Map<String, dynamic>?) ?? json;
    return device['id'] as String;
  }

  Future<void> unregister(String id) => _api.send(
    'DELETE',
    '/v1/me/push-tokens/${Uri.encodeComponent(id)}',
    auth: true,
  );
}
