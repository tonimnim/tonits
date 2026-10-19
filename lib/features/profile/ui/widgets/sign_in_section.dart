import 'package:flutter/material.dart';

import '../../../../core/widgets/widgets.dart';
import '../../../auth/data/models.dart';

/// How the player signs in: the Google or Apple account linked to Tonits.
class SignInSection extends StatelessWidget {
  const SignInSection({super.key, required this.player});

  final Player player;

  @override
  Widget build(BuildContext context) {
    final methods = player.signInMethods;
    return SettingsGroup(
      title: 'Sign-in',
      rows: [
        if (methods.contains('google'))
          SettingsRow(
            icon: Icons.account_circle_outlined,
            label: 'Google',
            value: player.email ?? 'Linked',
          ),
        if (methods.contains('apple'))
          SettingsRow(
            icon: Icons.apple,
            label: 'Apple',
            value: methods.contains('google')
                ? 'Linked'
                : player.email ?? 'Linked',
          ),
        if (!methods.contains('google') && !methods.contains('apple'))
          const SettingsRow(
            icon: Icons.key_outlined,
            label: 'Konami ID and password',
            value: 'Test account',
          ),
      ],
    );
  }
}
