import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/error_text.dart';
import '../../../core/l10n.dart';
import '../data/notification_preferences.dart';
import 'notifications_providers.dart';

/// The player's notification switches. A switch moves at once and goes
/// back if saving fails.
class NotificationPreferencesNotifier
    extends AsyncNotifier<NotificationPreferences> {
  @override
  Future<NotificationPreferences> build() =>
      ref.watch(notificationsRepositoryProvider).preferences();

  /// Returns why it didn't save, or null.
  Future<String?> set(NotificationChannel channel, {required bool on}) async {
    final before = state.value;
    if (before == null) return null;
    state = AsyncData(channel.set(before, on));
    try {
      final saved = await ref
          .read(notificationsRepositoryProvider)
          .setPreference(channel, on: on);
      if (ref.mounted) state = AsyncData(saved);
      return null;
    } catch (e) {
      if (ref.mounted) state = AsyncData(before);
      return describeError(e, ref.read(l10nProvider));
    }
  }
}
