import 'package:flutter/material.dart';

import '../../../../core/format.dart';
import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/app_notification.dart';

/// One inbox item: what it's about, how long ago, and whether it's read.
class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key, required this.item, required this.onTap});

  final AppNotification item;
  final VoidCallback onTap;

  static IconData iconFor(NotificationCategory category) => switch (category) {
    NotificationCategory.competition => Icons.emoji_events_outlined,
    NotificationCategory.match => Icons.sports_esports_outlined,
    NotificationCategory.result => Icons.scoreboard_outlined,
    NotificationCategory.payment => Icons.payments_outlined,
    NotificationCategory.account => Icons.person_outline,
    NotificationCategory.unknown => Icons.notifications_none,
  };

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final unread = !item.isRead;
    return Semantics(
      label: unread ? l.notifUnreadLabel : null,
      child: Panel(
        radius: TonitsRadius.tile,
        padding: const EdgeInsets.fromLTRB(14, 14, 16, 14),
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconDot(icon: iconFor(item.category)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: TextStyle(
                            fontWeight: unread
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        Format.ago(item.createdAt, l),
                        style: TextStyle(
                          fontSize: 12,
                          color: p.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: p.subtleForeground,
                    ),
                  ),
                ],
              ),
            ),
            if (unread) ...[
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: p.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// The whole item, for one with no screen of its own in the app.
Future<void> showNotificationDetails(
  BuildContext context,
  AppNotification item,
) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  builder: (sheet) {
    final p = sheet.palette;
    final l = sheet.l10n;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          TonitsSpace.lg,
          0,
          TonitsSpace.lg,
          TonitsSpace.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconDot(icon: NotificationTile.iconFor(item.category)),
                const SizedBox(width: 12),
                // Wraps rather than overflowing at large text sizes.
                Expanded(
                  child: Text(
                    Format.dateTime(item.createdAt, l),
                    style: TextStyle(fontSize: 13, color: p.mutedForeground),
                  ),
                ),
              ],
            ),
            const SizedBox(height: TonitsSpace.md),
            Text(item.title, style: Theme.of(sheet).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              item.body,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: p.subtleForeground,
              ),
            ),
          ],
        ),
      ),
    );
  },
);
