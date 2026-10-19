import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/clock.dart';
import '../../../../core/format.dart';
import '../../../../core/theme.dart';

/// A live countdown to the end of the current step, turning to the warning
/// colour in its last two minutes.
class DeadlineLine extends ConsumerWidget {
  const DeadlineLine({super.key, required this.deadline});

  final DateTime deadline;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final now = ref.watch(clockProvider).value ?? DateTime.now();
    final left = timeLeft(deadline, now);
    final urgent = deadline.difference(now) < const Duration(minutes: 2);
    final color = urgent ? p.warn.$1 : p.subtleForeground;
    return Row(
      children: [
        Icon(Icons.schedule, size: 16, color: color),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            left == null
                ? "Time's up"
                : '$left · until ${Format.dateTime(deadline)}',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ),
      ],
    );
  }
}
