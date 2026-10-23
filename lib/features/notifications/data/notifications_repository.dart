import '../../../core/api/api_client.dart';
import '../../../core/api/cursor_page.dart';
import 'app_notification.dart';
import 'notification_preferences.dart';

/// The signed-in player's notification inbox.
class NotificationsRepository {
  NotificationsRepository(this._api);

  final ApiClient _api;

  static const _path = '/v1/me/notifications';

  Future<CursorPage<AppNotification>> list({
    bool unreadOnly = false,
    int limit = 20,
    String? cursor,
  }) async {
    final json = await _api.get(
      withQuery(_path, {
        if (unreadOnly) 'unreadOnly': true,
        'limit': limit,
        'cursor': cursor,
      }),
      auth: true,
    );
    return CursorPage.fromJson(json!, AppNotification.fromJson);
  }

  Future<int> unreadCount() async {
    final json = await _api.get('$_path/unread-count', auth: true);
    return (json!['unreadCount'] as num).toInt();
  }

  /// Idempotent: a retry keeps the first read time.
  Future<DateTime> markRead(String id) async {
    final json = await _api.post(
      '$_path/${Uri.encodeComponent(id)}/read',
      auth: true,
    );
    return DateTime.parse(json!['readAt'] as String);
  }

  Future<void> markAllRead() => _api.post('$_path/read-all', auth: true);

  Future<NotificationPreferences> preferences() async {
    final json = await _api.get('/v1/me/notification-preferences', auth: true);
    return NotificationPreferences.fromJson(_unwrap(json!));
  }

  /// Turns one channel on or off and returns them all as saved.
  Future<NotificationPreferences> setPreference(
    NotificationChannel channel, {
    required bool on,
  }) async {
    final json = await _api.send(
      'PATCH',
      '/v1/me/notification-preferences',
      body: {channel.name: on},
      auth: true,
    );
    return NotificationPreferences.fromJson(_unwrap(json!));
  }

  static Map<String, dynamic> _unwrap(Map<String, dynamic> json) =>
      (json['data'] as Map<String, dynamic>?) ?? json;
}
