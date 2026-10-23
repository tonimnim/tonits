import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/paged.dart';
import '../../../core/providers.dart';
import '../data/app_notification.dart';
import '../data/notification_preferences.dart';
import '../data/notifications_repository.dart';
import '../data/push_repository.dart';
import 'inbox_notifier.dart';
import 'notification_preferences_notifier.dart';
import 'push_messaging.dart';
import 'push_service.dart';

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

final pushRepositoryProvider = Provider<PushRepository>(
  (ref) => PushRepository(ref.watch(apiClientProvider)),
);

/// Firebase Cloud Messaging on Android. iOS waits for its Firebase config
/// and an APNs key, so it has no pushes yet.
final pushMessagingProvider = Provider<PushMessaging>(
  (ref) => defaultTargetPlatform == TargetPlatform.android
      ? FirebasePushMessaging(platform: 'android')
      : const NoPushMessaging(),
);

final pushStoreProvider = Provider<PushStore>((ref) => SecurePushStore());

final pushServiceProvider = Provider<PushService>(PushService.new);

/// The player's notification switches, for Profile's Notifications.
final notificationPreferencesProvider =
    AsyncNotifierProvider.autoDispose<
      NotificationPreferencesNotifier,
      NotificationPreferences
    >(NotificationPreferencesNotifier.new);
