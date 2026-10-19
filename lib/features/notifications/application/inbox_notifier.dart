import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/cursor_page.dart';
import '../../../core/api/paged.dart';
import '../data/app_notification.dart';
import 'notifications_providers.dart';

/// The inbox, all items or unread only, newest first. Marking read updates
/// the item in place and the unread count.
class InboxNotifier extends PagedNotifier<AppNotification> {
  InboxNotifier(this.unreadOnly);

  final bool unreadOnly;

  @override
  Future<CursorPage<AppNotification>> fetchPage(String? cursor) => ref
      .read(notificationsRepositoryProvider)
      .list(unreadOnly: unreadOnly, cursor: cursor);

  /// Marks [item] read, showing it read straight away. A failure leaves it
  /// unread; the next refresh shows the truth.
  Future<void> markRead(AppNotification item) async {
    if (item.isRead) return;
    _replace(item.copyWith(readAt: DateTime.now()));
    try {
      final readAt = await ref
          .read(notificationsRepositoryProvider)
          .markRead(item.id);
      if (ref.mounted) _replace(item.copyWith(readAt: readAt));
    } on Exception {
      if (ref.mounted) _replace(item);
    }
    ref.invalidate(unreadCountProvider);
  }

  Future<void> markAllRead() async {
    await ref.read(notificationsRepositoryProvider).markAllRead();
    if (!ref.mounted) return;
    final current = state.value;
    if (current != null) {
      final now = DateTime.now();
      state = AsyncData(
        current.withItems([
          for (final n in current.items) n.isRead ? n : n.copyWith(readAt: now),
        ]),
      );
    }
    ref.invalidate(unreadCountProvider);
    // The other tab's list is stale too.
    ref.invalidate(inboxProvider(!unreadOnly));
  }

  void _replace(AppNotification item) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      current.withItems([
        for (final n in current.items) n.id == item.id ? item : n,
      ]),
    );
  }
}
