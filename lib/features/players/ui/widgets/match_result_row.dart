import 'package:flutter/material.dart';

import '../../../../core/format.dart';
import '../../../../core/theme.dart';
import '../../data/played_match.dart';
import 'result_chip.dart';

/// One finished match: result, opponent, where and when, and the score.
class MatchResultRow extends StatelessWidget {
  const MatchResultRow({super.key, required this.match});

  final PlayedMatch match;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return MergeSemantics(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: TonitsSpace.md,
          vertical: 12,
        ),
        child: Row(
          children: [
            ResultChip(match.result),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'vs ${match.opponentName ?? 'a former player'}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${match.competitionName} · ${Format.date(match.playedAt)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: p.mutedForeground),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${match.goalsFor}–${match.goalsAgainst}',
              style: monoFont.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
