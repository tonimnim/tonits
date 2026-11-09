import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../account/application/account_providers.dart';
import '../../../notifications/ui/widgets/notification_bell.dart';

/// The top of Home: the player's avatar, which opens Profile, and the
/// bell on one line; under them a small greeting and the page's headline.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Tooltip(
              message: l.tabProfile,
              child: Semantics(
                button: true,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => context.push(Routes.profile),
                  child: Consumer(
                    builder: (context, ref, _) => InitialsAvatar(
                      name: name,
                      size: 48,
                      image: ref.watch(myAvatarProvider).value,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            const NotificationBell(),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          l.homeHey(name),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 15, color: p.mutedForeground),
        ),
        const SizedBox(height: 2),
        Semantics(
          header: true,
          child: Text(
            l.homeHeadline,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ],
    );
  }
}
