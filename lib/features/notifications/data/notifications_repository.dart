import '../../../core/api/api_client.dart';
import '../../../core/api/cursor_page.dart';
import 'app_notification.dart';

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
}
