import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../players/application/player_stats.dart';
import '../../../players/application/players_providers.dart';
import '../../../players/data/played_match.dart';
import '../../../players/ui/widgets/record_bar.dart';

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
    final tiles = _tiles(stats, p);

    return Padding(
      padding: const EdgeInsets.only(top: TonitsSpace.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(title: 'Overview'),
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

  static List<Widget> _tiles(PlayerStats stats, TonitsPalette p) {
    final record = stats.record;
    final winRate = record.winRate;
    final streak = stats.streak;
    return [
      StatTile(
        value: winRate == null ? '—' : '${(winRate * 100).round()}%',
        label: 'Win rate',
        detail: '${record.wins} of ${record.matchesPlayed} won',
      ),
      StatTile(
        value: '${record.matchesPlayed}',
        label: 'Matches',
        detail: 'All time',
      ),
      StatTile(
        value: stats.goalsPerMatch == null
            ? '—'
            : stats.goalsPerMatch!.toStringAsFixed(1),
        label: 'Goals per match',
        detail: 'Last ${stats.goalsSample} matches',
      ),
      StatTile(
        value: streak == null ? '—' : '${streak.$1.letter}${streak.$2}',
        label: 'Current streak',
        detail: switch (streak?.$1) {
          MatchResult.win => 'Wins in a row',
          MatchResult.loss => 'Losses in a row',
          MatchResult.draw => 'Draws in a row',
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
