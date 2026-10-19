import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../players/application/player_stats.dart';
import '../../../players/application/players_providers.dart';
import '../../../players/data/played_match.dart';
import '../../../players/ui/widgets/record_bar.dart';
import '../../../players/ui/widgets/result_chip.dart';

/// Win rate, matches, goals and streak, then the W/D/L split. Hidden until
/// the player has played.
class StatsOverview extends ConsumerWidget {
  const StatsOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(myStatsProvider).value;
    if (stats == null || stats.record.matchesPlayed == 0) {
      return const SizedBox.shrink();
    }
    final p = context.palette;
    final tiles = _tiles(stats, p, context.l10n);

    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(title: context.l10n.homeOverview),
          const SizedBox(height: TonitsSpace.sm),
          LayoutBuilder(
            builder: (context, box) {
              const gap = 12.0;
              final width = (box.maxWidth - gap) / 2;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final tile in tiles) SizedBox(width: width, child: tile),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(TonitsSpace.md),
              child: RecordBar(record: stats.record),
            ),
          ),
        ],
      ),
    );
  }

  static List<Widget> _tiles(
    PlayerStats stats,
    TonitsPalette p,
    AppLocalizations l,
  ) {
    final record = stats.record;
    final winRate = record.winRate;
    final streak = stats.streak;
    return [
      StatTile(
        value: winRate == null ? '—' : '${(winRate * 100).round()}%',
        label: l.homeWinRate,
        detail: l.homeWinsOfPlayed(record.wins, record.matchesPlayed),
      ),
      StatTile(
        value: '${record.matchesPlayed}',
        label: l.homeMatches,
        detail: l.homeAllTime,
      ),
      StatTile(
        value: stats.goalsPerMatch == null
            ? '—'
            : stats.goalsPerMatch!.toStringAsFixed(1),
        label: l.homeGoalsPerMatch,
        detail: l.homeLastMatches(stats.goalsSample),
      ),
      StatTile(
        value: streak == null ? '—' : '${streak.$1.letter(l)}${streak.$2}',
        label: l.homeCurrentStreak,
        detail: switch (streak?.$1) {
          MatchResult.win => l.homeWinsInARow,
          MatchResult.loss => l.homeLossesInARow,
          MatchResult.draw => l.homeDrawsInARow,
          null => null,
        },
        valueColor: switch (streak?.$1) {
          MatchResult.win => p.good.$1,
          MatchResult.loss => p.destructive,
          _ => null,
        },
      ),
    ];
  }
}
