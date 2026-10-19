import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n.dart';
import '../../../../core/routes.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/data/models.dart';

/// How the player signs in: the Google or Apple account linked to Ozone,
/// and the devices signed in with it.
class SignInSection extends StatelessWidget {
  const SignInSection({super.key, required this.player});

  final Player player;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final methods = player.signInMethods;
    return SettingsGroup(
      title: l.profileSignInTitle,
      rows: [
        if (methods.contains('google'))
          SettingsRow(
            icon: Icons.account_circle_outlined,
            label: 'Google',
            value: player.email ?? l.profileLinked,
          ),
        if (methods.contains('apple'))
          SettingsRow(
            icon: Icons.apple,
            label: 'Apple',
            value: methods.contains('google')
                ? l.profileLinked
                : player.email ?? l.profileLinked,
          ),
        if (!methods.contains('google') && !methods.contains('apple'))
          SettingsRow(
            icon: Icons.key_outlined,
            label: l.profileKonamiIdAndPassword,
            value: l.profileTestAccount,
          ),
        SettingsRow(
          icon: Icons.devices_outlined,
          label: l.devicesTitle,
          onTap: () => context.push(Routes.devices),
        ),
      ],
    );
  }
}
