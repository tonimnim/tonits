import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../auth/data/models.dart';
import 'new_recovery_code_flow.dart';

/// The few steps that make an account safe and quick to pay with, until
/// they're all done.
class SetupChecklist extends ConsumerWidget {
  const SetupChecklist({super.key, required this.player});

  final Player player;

  /// Whether there's anything left to do; the profile hides the list when
  /// there isn't.
  static bool isNeeded(Player player) =>
      _steps(player).any((step) => !step.done);

  static List<_Step> _steps(Player player) => [
    _Step(
      title: 'Save a recovery code',
      detail: 'Your way back in if you forget your password.',
      done: player.recoveryCodeSet,
      open: startNewRecoveryCode,
    ),
    _Step(
      title: 'Verify your email',
      detail: 'Another way to reset your password.',
      done: player.email != null && player.emailVerified,
      open: (context, _) => context.push(Routes.email),
    ),
    // M-Pesa is Kenya only, so the number only saves time there.
    if (player.countryCode == 'KE')
      _Step(
        title: 'Add your M-Pesa number',
        detail: 'Pay entry fees without typing it each time.',
        done: player.phoneNumber != null,
        open: (context, _) => context.push(Routes.phone),
      ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final steps = _steps(player);
    final done = steps.where((s) => s.done).length;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Expanded(
                      child: Text(
                        'Finish setting up',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      '$done of ${steps.length} done',
                      style: TextStyle(fontSize: 13, color: p.mutedForeground),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _Progress(done: done, total: steps.length),
              ],
            ),
          ),
          for (final step in steps) ...[
            const Divider(),
            _StepRow(step: step, onTap: () => step.open(context, ref)),
          ],
        ],
      ),
    );
  }
}

class _Step {
  const _Step({
    required this.title,
    required this.detail,
    required this.done,
    required this.open,
  });

  final String title;
  final String detail;
  final bool done;
  final void Function(BuildContext, WidgetRef) open;
}

/// One segment per step, filled as each is done.
class _Progress extends StatelessWidget {
  const _Progress({required this.done, required this.total});

  final int done;
  final int total;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return ExcludeSemantics(
      child: Row(
        children: [
          for (var i = 0; i < total; i++) ...[
            if (i > 0) const SizedBox(width: 6),
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: i < done ? p.primary : p.muted,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({required this.step, required this.onTap});

  final _Step step;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final done = step.done;
    return Semantics(
      button: !done,
      label: done ? '${step.title}, done' : null,
      excludeSemantics: done,
      child: InkWell(
        onTap: done ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
          child: Row(
            children: [
              Icon(
                done ? Icons.check_circle : Icons.radio_button_unchecked,
                size: 22,
                color: done ? p.primary : p.mutedForeground,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: done ? p.mutedForeground : p.foreground,
                        decoration: done ? TextDecoration.lineThrough : null,
                        decorationColor: p.mutedForeground,
                      ),
                    ),
                    if (!done) ...[
                      const SizedBox(height: 2),
                      Text(
                        step.detail,
                        style: TextStyle(
                          fontSize: 13,
                          color: p.subtleForeground,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (!done)
                Icon(Icons.chevron_right, size: 20, color: p.mutedForeground),
            ],
          ),
        ),
      ),
    );
  }
}
