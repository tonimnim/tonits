import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/notifications_providers.dart';

/// The round bell that opens the inbox, with the unread count. The count is
/// read again when the app comes back to the foreground.
class NotificationBell extends ConsumerStatefulWidget {
  const NotificationBell({super.key});

  @override
  ConsumerState<NotificationBell> createState() => _NotificationBellState();
}

class _NotificationBellState extends ConsumerState<NotificationBell> {
  late final _lifecycle = AppLifecycleListener(
    onResume: () => ref.invalidate(unreadCountProvider),
  );

  @override
  void initState() {
    super.initState();
    _lifecycle;
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final count = ref.watch(unreadCountProvider).value ?? 0;
    return Semantics(
      label: context.l10n.notifBellLabel(count),
      button: true,
      excludeSemantics: true,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          RoundIconButton(
            icon: Icons.notifications_none_rounded,
            tooltip: context.l10n.notifTitle,
            size: 44,
            background: p.card,
            onPressed: () => context.push(Routes.notifications),
          ),
          if (count > 0)
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                constraints: const BoxConstraints(minWidth: 20),
                height: 20,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: p.destructive,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: p.card, width: 2),
                ),
                child: Text(
                  count > 99 ? '99+' : '$count',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
