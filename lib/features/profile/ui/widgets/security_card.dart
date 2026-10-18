import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/format.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/data/models.dart';
import 'new_recovery_code_flow.dart';

/// How the player gets back in after a forgotten password.
class SecurityCard extends ConsumerWidget {
  const SecurityCard({super.key, required this.player});

  final Player player;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final created = player.recoveryCodeCreatedAt;
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          TonitsSpace.md,
          TonitsSpace.md,
          TonitsSpace.sm,
          TonitsSpace.md,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: TonitsSpace.sm,
                    runSpacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text(
                        'Recovery code',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      StatusBadge(
                        player.recoveryCodeSet ? 'Set' : 'Not set',
                        tone: player.recoveryCodeSet
                            ? StatusTone.good
                            : StatusTone.warn,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    player.recoveryCodeSet
                        ? created == null
                              ? 'Resets your password without email.'
                              : 'Created ${Format.date(created)}. Lost it? '
                                    'Get a new one.'
                        : 'Resets your password without email.',
                    style: TextStyle(fontSize: 13, color: p.subtleForeground),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () => startNewRecoveryCode(context, ref),
              child: Text(player.recoveryCodeSet ? 'New code' : 'Create'),
            ),
          ],
        ),
      ),
    );
  }
}
