import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/clock.dart';
import '../../../../core/format.dart';
import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';

/// A live countdown to the end of the current step, in the warning colour
/// for its last two minutes, with the clock time beside it.
class DeadlinePill extends ConsumerWidget {
  const DeadlinePill({
    super.key,
    required this.deadline,
    this.showClockTime = true,
    this.filled,
  });

  final DateTime deadline;

  /// Whether to add "until 10:49" beside the time left.
  final bool showClockTime;
  final Color? filled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final l = context.l10n;
    final now = ref.watch(clockProvider).value ?? DateTime.now();
    final left = timeLeft(deadline, now, l);
    final urgent = deadline.difference(now) < const Duration(minutes: 2);
    final pill = Pill(
      left ?? l.matchTimesUp,
      icon: Icons.schedule,
      color: urgent ? p.warn.$1 : p.primary,
      filled: filled,
    );
    if (!showClockTime) return pill;
    return Wrap(
      spacing: 10,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        pill,
        Text(
          l.matchUntil(Format.dateTime(deadline, l)),
          style: TextStyle(fontSize: 13, color: p.mutedForeground),
        ),
      ],
    );
  }
}
