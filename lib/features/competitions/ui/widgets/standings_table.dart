import 'package:flutter/material.dart';

import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../data/draw.dart';

/// A round-robin group's table on the page, rows split by hairlines. In a
/// series stage there are no draws, so that column goes, and the
/// difference is in games rather than goals.
class StandingsTable extends StatelessWidget {
  const StandingsTable({
    super.key,
    required this.group,
    required this.series,
    this.myEntryId,
  });

  final StandingsGroup group;
  final bool series;
  final String? myEntryId;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final header = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: p.mutedForeground,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
          child: _Line(
            series: series,
            rank: const SizedBox.shrink(),
            name: const SizedBox.shrink(),
            cells: [
              Text(l.drawPlayedShort, semanticsLabel: l.drawPlayed),
              Text(l.drawWonShort, semanticsLabel: l.drawWon),
              Text(l.drawDrawnShort, semanticsLabel: l.drawDrawn),
              Text(l.drawLostShort, semanticsLabel: l.drawLost),
              Text(
                l.drawDifferenceShort,
                semanticsLabel: series
                    ? l.drawGameDifference
                    : l.drawGoalDifference,
              ),
              Text(l.drawPointsShort, semanticsLabel: l.drawPoints),
            ],
            style: header,
          ),
        ),
        for (final (i, row) in group.rows.indexed) ...[
          if (i > 0) const Divider(height: 1),
          _Row(row: row, series: series, isMe: row.entryId == myEntryId),
        ],
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.row, required this.series, required this.isMe});

  final StandingRow row;
  final bool series;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final diff = series ? row.gamesWon - row.gamesLost : row.goalDifference;
    final color = row.removed ? p.mutedForeground : p.foreground;
    final number = TextStyle(
      fontSize: 14,
      color: row.removed ? p.mutedForeground : p.subtleForeground,
      fontFeatures: const [FontFeature.tabularFigures()],
    );

    return MergeSemantics(
      child: Container(
        decoration: isMe
            ? BoxDecoration(
                color: p.soft,
                borderRadius: BorderRadius.circular(TonitsRadius.control),
              )
            : null,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: _Line(
          series: series,
          rank: Text(
            row.rank?.toString() ?? '–',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: color,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          name: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isMe ? l.rankingsYou(row.displayName) : row.displayName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              if (row.removed)
                Text(
                  l.drawRemoved,
                  style: TextStyle(fontSize: 12, color: p.mutedForeground),
                ),
            ],
          ),
          cells: [
            Text('${row.played}'),
            Text('${row.wins}'),
            Text('${row.draws}'),
            Text('${row.losses}'),
            Text(
              diff > 0
                  ? '+$diff'
                  : diff < 0
                  ? '−${-diff}'
                  : '0',
            ),
            Text(
              '${row.points}',
              style: TextStyle(fontWeight: FontWeight.w700, color: color),
            ),
          ],
          style: number,
        ),
      ),
    );
  }
}

/// The table's columns: rank, name, then the numbers. Draws are left out
/// of a series stage. Each number shrinks rather than overflowing at large
/// text sizes.
class _Line extends StatelessWidget {
  const _Line({
    required this.series,
    required this.rank,
    required this.name,
    required this.cells,
    required this.style,
  });

  final bool series;
  final Widget rank;
  final Widget name;

  /// Played, won, drawn, lost, difference, points.
  final List<Widget> cells;
  final TextStyle style;

  static const _widths = [28.0, 28.0, 28.0, 28.0, 38.0, 36.0];

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: style,
      child: Row(
        children: [
          SizedBox(width: 28, child: rank),
          Expanded(child: name),
          for (final (i, cell) in cells.indexed)
            if (!(series && i == 2))
              SizedBox(
                width: _widths[i],
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: cell,
                ),
              ),
        ],
      ),
    );
  }
}
