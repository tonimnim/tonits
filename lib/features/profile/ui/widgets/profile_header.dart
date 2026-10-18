import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/countries.dart';
import '../../../../core/format.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/data/models.dart';
import '../../../players/application/players_providers.dart';

/// Who the player is: avatar, name, handle, country and how long they've
/// played on Tonits.
class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({super.key, required this.player});

  final Player player;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final country = Country.byCode(player.countryCode);
    // The join date is on the public profile; the line waits for it.
    final joinedAt = ref.watch(myProfileProvider).value?.joinedAt;
    final handle = player.username;
    final details = [
      if (handle != null && handle != player.displayName) '@$handle',
      country == null ? player.countryCode : '${country.flag} ${country.name}',
    ].join('  ·  ');

    return Column(
      children: [
        InitialsAvatar(name: player.displayName, size: 76),
        const SizedBox(height: TonitsSpace.md),
        Text(
          player.displayName,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 4),
        Text(
          details,
          textAlign: TextAlign.center,
          style: TextStyle(color: p.subtleForeground),
        ),
        if (joinedAt != null) ...[
          const SizedBox(height: 2),
          Text(
            'Member since ${Format.monthYear(joinedAt)}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: p.mutedForeground),
          ),
        ],
      ],
    );
  }
}
