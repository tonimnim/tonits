import 'package:flutter/material.dart';

import '../../../../core/theme.dart';
import '../../data/player_profile.dart';

/// Wins, draws and losses as one split bar, with the counts beneath.
class RecordBar extends StatelessWidget {
  const RecordBar({super.key, required this.record});

  final Record record;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final parts = [
      (record.wins, p.good.$1, 'Wins'),
      (record.draws, p.mutedForeground, 'Draws'),
      (record.losses, p.destructive, 'Losses'),
    ];
    return Semantics(
      label:
          '${record.wins} wins, ${record.draws} draws, ${record.losses} losses',
      excludeSemantics: true,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              height: 8,
              child: Row(
                children: [
                  for (final (count, color, _) in parts)
                    if (count > 0)
                      Expanded(
                        flex: count,
                        child: Container(
                          color: color,
                          margin: const EdgeInsets.only(right: 2),
                        ),
                      ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 14,
            runSpacing: 6,
            children: [
              for (final (count, color, label) in parts)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$count ',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      label,
                      style: TextStyle(fontSize: 13, color: p.subtleForeground),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
