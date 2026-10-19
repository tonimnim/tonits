import 'package:flutter/material.dart';

import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../data/match_room.dart';

/// A series game by game from the player's side, with who took it, and the
/// series score under it.
class SeriesGames extends StatelessWidget {
  const SeriesGames({
    super.key,
    required this.games,
    required this.home,
    required this.opponent,
  });

  /// Home–away, in order.
  final List<Score> games;
  final bool home;
  final String opponent;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    var mine = 0;
    var theirs = 0;
    final rows = <Widget>[];
    for (final (i, game) in games.indexed) {
      final (gm, gt) = game.forSide(home: home);
      final pens = game.penalties?.forSide(home: home);
      final won = gm > gt || (pens != null && pens.$1 > pens.$2);
      final lost = gm < gt || (pens != null && pens.$1 < pens.$2);
      if (won) mine++;
      if (lost) theirs++;
      rows.add(
        _GameRow(
          label: l.seriesGame(i + 1),
          score: pens == null
              ? '$gm–$gt'
              : l.matchScoreWithPens(gm, gt, pens.$1, pens.$2),
          outcome: won
              ? 1
              : lost
              ? -1
              : 0,
        ),
      );
    }
    final summary = mine > theirs
        ? l.seriesYouWin(mine, theirs)
        : theirs > mine
        ? l.seriesTheyWin(opponent, theirs, mine)
        : l.seriesLevel(mine, theirs);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: p.muted,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...rows,
          const SizedBox(height: 6),
          Text(
            summary,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _GameRow extends StatelessWidget {
  const _GameRow({
    required this.label,
    required this.score,
    required this.outcome,
  });

  final String label;
  final String score;

  /// 1 won, -1 lost, 0 drawn.
  final int outcome;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final color = switch (outcome) {
      1 => p.good.$1,
      -1 => p.destructive,
      _ => p.mutedForeground,
    };
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Text(label, style: TextStyle(color: p.subtleForeground)),
          const SizedBox(width: 12),
          // One line: a long score with penalties shrinks rather than wraps.
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Text(
                score,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
