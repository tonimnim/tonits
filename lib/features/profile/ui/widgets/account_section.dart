import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/countries.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/data/models.dart';
import 'change_country.dart';

/// How the player appears to others: name, country and Konami ID.
class AccountSection extends ConsumerWidget {
  const AccountSection({super.key, required this.player});

  final Player player;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final country = Country.byCode(player.countryCode);
    final konamiId = player.konamiId;
    return SettingsGroup(
      title: 'Account',
      rows: [
        SettingsRow(
          icon: Icons.person_outline,
          label: 'Display name',
          value: player.displayName,
          onTap: () => context.push(Routes.editName),
        ),
        SettingsRow(
          icon: Icons.public,
          label: 'Country',
          value: country == null
              ? player.countryCode
              : '${country.flag}  ${country.name}',
          onTap: () => changeCountry(context, ref),
        ),
        SettingsRow(
          icon: Icons.badge_outlined,
          label: 'Konami ID',
          value: konamiId ?? 'Not linked',
          valueStyle: konamiId == null
              ? null
              : monoFont.copyWith(color: p.subtleForeground, fontSize: 14),
          trailing: konamiId == null
              ? null
              : Icon(Icons.copy_rounded, size: 18, color: p.mutedForeground),
          onTap: konamiId == null
              ? null
              : () => copyToClipboard(context, konamiId, what: 'Konami ID'),
        ),
      ],
    );
  }
}
