import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/error_text.dart';
import '../../../core/l10n.dart';
import '../../../core/routes.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../application/notification_target.dart';
import '../application/notifications_providers.dart';
import '../data/app_notification.dart';
import 'widgets/notification_tile.dart';

/// The inbox, newest first. Tapping an item marks it read and opens what
/// it's about.
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  bool _unreadOnly = false;

  Future<void> _open(AppNotification item) async {
    unawaited(ref.read(inboxProvider(_unreadOnly).notifier).markRead(item));
    switch (NotificationTarget.of(item)) {
      case OpenMatch(:final matchId):
        context.go(Routes.match(matchId));
      case OpenCompetition(:final competitionId):
        context.go(Routes.competition(competitionId));
      case ShowDetails():
        await showNotificationDetails(context, item);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final provider = inboxProvider(_unreadOnly);
    final unread = ref.watch(unreadCountProvider).value ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(l.notifTitle),
        actions: [
          if (unread > 0)
            TextButton(
              onPressed: () => ref.read(provider.notifier).markAllRead(),
              child: Text(l.notifMarkAllRead),
            ),
          const SizedBox(width: TonitsSpace.sm),
        ],
      ),
      body: PagedListView<AppNotification>(
        value: ref.watch(provider),
        onRefresh: () async {
          ref
            ..invalidate(unreadCountProvider)
            ..invalidate(provider);
          await ref.read(provider.future);
        },
        onLoadMore: () => ref.read(provider.notifier).loadMore(),
        errorText: (e) => describeError(e, l),
        separator: const SizedBox(height: 10),
        header: Padding(
          padding: const EdgeInsets.only(bottom: TonitsSpace.md),
          child: SegmentedTabs(
            options: {false: l.notifAll, true: l.notifUnread},
            selected: _unreadOnly,
            onChanged: (v) => setState(() => _unreadOnly = v),
          ),
        ),
        itemBuilder: (context, item) =>
            NotificationTile(item: item, onTap: () => _open(item)),
        empty: EmptyState(
          icon: Icons.notifications_none,
          title: _unreadOnly ? l.notifEmptyUnreadTitle : l.notifEmptyTitle,
          message: l.notifEmptyMessage,
        ),
      ),
    );
  }
}
