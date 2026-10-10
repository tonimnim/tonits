import 'package:flutter/material.dart';

import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/data/models.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.player});

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InitialsAvatar(name: player.displayName, size: 56),
        const SizedBox(width: TonitsSpace.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                player.displayName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              // A new player's display name is their username; don't repeat it.
              if (player.username != null &&
                  player.username != player.displayName)
                Text(
                  '@${player.username}',
                  style: TextStyle(color: context.palette.mutedForeground),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
