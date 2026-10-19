import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../account/application/account_providers.dart';
import '../../../notifications/ui/widgets/notification_bell.dart';

/// The player's avatar beside a time-of-day greeting and their name.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.name, this.now});

  final String name;

  /// For tests; defaults to the current time.
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final hour = (now ?? DateTime.now()).hour;
    final l = context.l10n;
    final greeting = hour < 12
        ? l.homeGoodMorning
        : hour < 17
        ? l.homeGoodAfternoon
        : l.homeGoodEvening;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(color: p.card, shape: BoxShape.circle),
          child: Consumer(
            builder: (context, ref, _) => InitialsAvatar(
              name: name,
              size: 46,
              image: ref.watch(myAvatarProvider).value,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: TextStyle(fontSize: 14, color: p.subtleForeground),
              ),
              Semantics(
                header: true,
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        const NotificationBell(),
      ],
    );
  }
}
