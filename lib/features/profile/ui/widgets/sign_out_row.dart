import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/widgets.dart';
import '../../../auth/application/auth_controller.dart';

/// Signs out after a confirmation, since it ends the session on this device.
class SignOutRow extends ConsumerWidget {
  const SignOutRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsGroup(
      rows: [
        SettingsRow(
          icon: Icons.logout,
          label: 'Sign out',
          destructive: true,
          chevron: false,
          onTap: () async {
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Sign out of Tonits?'),
                content: const Text(
                  'You can sign back in any time with your Konami ID.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Sign out'),
                  ),
                ],
              ),
            );
            if (confirmed == true) {
              await ref.read(authControllerProvider.notifier).signOut();
            }
          },
        ),
      ],
    );
  }
}
