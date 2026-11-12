import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../account/application/account_providers.dart';
import '../../../notifications/ui/widgets/notification_bell.dart';

/// The top of Home: the player's avatar, which opens Profile, their name
/// beside it and the bell, on one line, avatar and bell in a hairline ring
/// on a white disc; under them the page's headline.
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
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: p.card,
                      shape: BoxShape.circle,
                      border: Border.all(color: p.border),
                    ),
                    child: Consumer(
                      builder: (context, ref, _) => InitialsAvatar(
                        name: name,
                        size: 50,
                        image: ref.watch(myAvatarProvider).value,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 19,
                  letterSpacing: -0.3,
                  fontWeight: FontWeight.w600,
                  color: p.foreground,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const NotificationBell(),
          ],
        ),
        const SizedBox(height: 20),
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
