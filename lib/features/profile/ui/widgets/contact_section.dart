import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/data/models.dart';

/// How Tonits reaches the player and takes payments.
class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.player});

  final Player player;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final add = TextStyle(color: p.primary, fontWeight: FontWeight.w600);
    final email = player.email;
    return SettingsGroup(
      title: l.profileContactTitle,
      rows: [
        SettingsRow(
          icon: Icons.mail_outline,
          label: l.accountEmailTitle,
          value: email ?? l.profileAdd,
          valueStyle: email == null ? add : null,
          onTap: () => context.push(Routes.email),
        ),
        SettingsRow(
          icon: Icons.phone_outlined,
          label: l.profilePhone,
          value: player.phoneNumber ?? l.profileAdd,
          valueStyle: player.phoneNumber == null ? add : null,
          onTap: () => context.push(Routes.phone),
        ),
      ],
    );
  }
}
