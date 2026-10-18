import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import 'new_recovery_code_flow.dart';

/// Shown to a player with neither a recovery code nor a verified email: a
/// forgotten password would lock them out.
class RecoveryPrompt extends ConsumerWidget {
  const RecoveryPrompt({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final (text, _) = p.warn;
    // A plain card: the warning colour is on the icon and title only.
    return Container(
      padding: const EdgeInsets.all(TonitsSpace.md),
      decoration: BoxDecoration(
        color: p.card,
        borderRadius: BorderRadius.circular(TonitsRadius.card),
        border: Border.all(color: p.input),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.shield_outlined, size: 20, color: text),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "You can't recover your account yet",
                  style: TextStyle(fontWeight: FontWeight.w600, color: text),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'If you forget your password, a recovery code is your way back '
            'in. It takes a moment to create.',
            style: TextStyle(fontSize: 13, color: p.subtleForeground),
          ),
          const SizedBox(height: TonitsSpace.md),
          PrimaryButton(
            label: 'Create a recovery code',
            onPressed: () => startNewRecoveryCode(context, ref),
          ),
        ],
      ),
    );
  }
}
