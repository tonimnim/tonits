import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/data/models.dart';
import 'new_recovery_code_flow.dart';

/// The password, and the way back in when it's forgotten.
class SecuritySection extends ConsumerWidget {
  const SecuritySection({super.key, required this.player});

  final Player player;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    return SettingsGroup(
      title: 'Security',
      rows: [
        SettingsRow(
          icon: Icons.lock_outline,
          label: 'Password',
          value: 'Change',
          onTap: () => context.push(Routes.password),
        ),
        SettingsRow(
          icon: Icons.key_outlined,
          label: 'Recovery code',
          value: player.recoveryCodeSet ? 'Saved' : 'Not set',
          valueStyle: player.recoveryCodeSet
              ? null
              : TextStyle(color: p.warn.$1, fontWeight: FontWeight.w600),
          onTap: () => startNewRecoveryCode(context, ref),
        ),
      ],
    );
  }
}
