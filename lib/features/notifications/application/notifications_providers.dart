import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/paged.dart';
import '../../../core/providers.dart';
import '../data/app_notification.dart';
import '../data/notifications_repository.dart';
import 'inbox_notifier.dart';

final notificationsRepositoryProvider = Provider<NotificationsRepository>(
  (ref) => NotificationsRepository(ref.watch(apiClientProvider)),
);

/// The badge on the bell. Refreshed when the inbox changes, when Home is
/// pulled down, and when the app comes back to the foreground.
final unreadCountProvider = FutureProvider.autoDispose<int>(
  (ref) => ref.watch(notificationsRepositoryProvider).unreadCount(),
);

/// The inbox: `true` for unread only.
final inboxProvider = AsyncNotifierProvider.autoDispose
    .family<InboxNotifier, Paged<AppNotification>, bool>(InboxNotifier.new);
