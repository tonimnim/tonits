import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/widgets.dart';
import '../../../auth/application/auth_providers.dart';

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
            final confirmed = await confirmAction(
              context,
              title: 'Sign out of Ozone?',
              message:
                  'You can sign back in any time with the same Google or Apple '
                  'account.',
              confirmLabel: 'Sign out',
            );
            if (confirmed) {
              await ref.read(authControllerProvider.notifier).signOut();
            }
          },
        ),
      ],
    );
  }
}
