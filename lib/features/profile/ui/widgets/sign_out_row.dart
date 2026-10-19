import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/application/auth_providers.dart';

/// Signs out after a confirmation, since it ends the session on this device.
class SignOutRow extends ConsumerWidget {
  const SignOutRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    return SettingsGroup(
      rows: [
        SettingsRow(
          icon: Icons.logout,
          label: l.profileSignOut,
          destructive: true,
          chevron: false,
          onTap: () async {
            final confirmed = await confirmAction(
              context,
              title: l.profileSignOutTitle,
              message: l.profileSignOutMessage,
              confirmLabel: l.profileSignOut,
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
