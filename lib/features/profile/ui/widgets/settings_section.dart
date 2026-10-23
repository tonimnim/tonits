import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n.dart';
import '../../../../core/routes.dart';
import '../../../../core/widgets/widgets.dart';

/// How the app behaves for the player: which notifications they get.
class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return SettingsGroup(
      title: l.profileSettingsTitle,
      rows: [
        SettingsRow(
          icon: Icons.notifications_none_rounded,
          label: l.notifSettings,
          onTap: () => context.push(Routes.notificationSettings),
        ),
      ],
    );
  }
}
