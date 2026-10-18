import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    final add = TextStyle(color: p.primary, fontWeight: FontWeight.w600);
    final email = player.email;
    return SettingsGroup(
      title: 'Contact',
      rows: [
        SettingsRow(
          icon: Icons.mail_outline,
          label: 'Email',
          value: email ?? 'Add',
          valueStyle: email == null ? add : null,
          onTap: () => context.push(Routes.email),
        ),
        SettingsRow(
          icon: Icons.phone_outlined,
          label: 'Phone',
          value: player.phoneNumber ?? 'Add',
          valueStyle: player.phoneNumber == null ? add : null,
          onTap: () => context.push(Routes.phone),
        ),
      ],
    );
  }
}
