import 'package:flutter/material.dart';

import '../../../../core/theme.dart';

/// How full a competition is: a thin bar with "23 of 32 players".
class CapacityBar extends StatelessWidget {
  const CapacityBar({super.key, required this.entries, required this.max});

  final int entries;
  final int max;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final fraction = max == 0 ? 0.0 : (entries / max).clamp(0.0, 1.0);
    return Semantics(
      label: '$entries of $max players',
      excludeSemantics: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '$entries of $max players',
            style: TextStyle(fontSize: 13, color: p.subtleForeground),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: fraction,
              minHeight: 4,
              color: p.primary,
              backgroundColor: p.muted,
            ),
          ),
        ],
      ),
    );
  }
}
