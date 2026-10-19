import 'package:flutter/material.dart';

import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/competition.dart';

/// How many games each round's matches are, earliest round first, so
/// players know before entering. Shown only when some match is a series.
class MatchFormatPanel extends StatelessWidget {
  const MatchFormatPanel({super.key, required this.format});

  final MatchFormat format;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final rounds = format.rounds.entries.toList()
      ..sort((a, b) => _order(a.key).compareTo(_order(b.key)));
    final rows = [
      (
        rounds.isEmpty ? l.seriesEveryMatch : l.seriesOtherRounds,
        format.bestOf,
      ),
      for (final MapEntry(:key, :value) in rounds) (roundName(key, l), value),
    ];

    return Panel(
      radius: TonitsRadius.tile,
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      child: Column(
        children: [
          for (final (i, (name, bestOf)) in rows.indexed) ...[
            if (i > 0) const Divider(indent: 50),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: MergeSemantics(
                child: Row(
                  children: [
                    IconDot(
                      icon: bestOf > 1
                          ? Icons.layers_outlined
                          : Icons.sports_soccer_outlined,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          l.seriesBestOf(bestOf),
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        if (bestOf > 1)
                          Text(
                            l.seriesFirstToWins(bestOf ~/ 2 + 1),
                            style: TextStyle(
                              fontSize: 12,
                              color: p.mutedForeground,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// A round's name from its API key, such as `semifinal` or `round_of_16`.
  static String roundName(String key, AppLocalizations l) {
    final roundOf = RegExp(r'^round_of_(\d+)$').firstMatch(key);
    if (roundOf != null) return l.seriesRoundOf(int.parse(roundOf[1]!));
    return switch (key) {
      'final' => l.seriesRoundFinal,
      'semifinal' => l.seriesRoundSemifinal,
      'quarterfinal' => l.seriesRoundQuarterfinal,
      'third_place' => l.seriesRoundThirdPlace,
      'winners_final' => l.seriesRoundWinnersFinal,
      'losers_final' => l.seriesRoundLosersFinal,
      _ => key.replaceAll('_', ' '),
    };
  }

  /// Bracket order: the biggest early round first, the final last.
  static int _order(String key) {
    final roundOf = RegExp(r'^round_of_(\d+)$').firstMatch(key);
    if (roundOf != null) return -int.parse(roundOf[1]!);
    return switch (key) {
      'quarterfinal' => 1,
      'semifinal' => 2,
      'winners_final' => 3,
      'losers_final' => 4,
      'third_place' => 5,
      'final' => 6,
      _ => 0,
    };
  }
}
