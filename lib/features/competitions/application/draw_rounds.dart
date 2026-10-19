import 'dart:math';

import '../../../core/l10n.dart';
import '../data/draw.dart';

/// A stage's rounds in playing order, as the tabs over its matches. A
/// bracket reset that turned out not to be needed is left out.
List<BracketRound> playableRounds(BracketStage stage) {
  final rounds = [
    for (final round in stage.rounds)
      if (round.matches
              .where((m) => m.completionReason != 'reset_not_required')
              .toList()
          case final matches when matches.isNotEmpty)
        round.copyWith(matches: matches),
  ];
  return rounds..sort((a, b) {
    final byBracket = _order(a.bracket).compareTo(_order(b.bracket));
    if (byBracket != 0) return byBracket;
    // Groups by key: group_a before group_b.
    final byKey = a.bracket.compareTo(b.bracket);
    return byKey != 0 ? byKey : a.number.compareTo(b.number);
  });
}

int _order(String bracket) => switch (bracket) {
  'losers' => 1,
  'bronze' => 2,
  'grand_final' => 3,
  _ => 0,
};

/// What a round is called. The API numbers rounds from the first; players
/// know them counted back from the final.
String roundTitle(BracketRound round, BracketStage stage, AppLocalizations l) {
  final last = stage.rounds
      .where((r) => r.bracket == round.bracket)
      .map((r) => r.number)
      .fold(0, max);
  final fromEnd = last - round.number;
  return switch (round.bracket) {
    'main' => switch (fromEnd) {
      0 => l.seriesRoundFinal,
      1 => l.seriesRoundSemifinal,
      2 => l.seriesRoundQuarterfinal,
      _ => l.seriesRoundOf(1 << (fromEnd + 1)),
    },
    'bronze' => l.seriesRoundThirdPlace,
    'winners' =>
      fromEnd == 0
          ? l.seriesRoundWinnersFinal
          : l.drawWinnersRound(round.number),
    'losers' =>
      fromEnd == 0 ? l.seriesRoundLosersFinal : l.drawLosersRound(round.number),
    'grand_final' =>
      round.number == 1 ? l.drawGrandFinal : l.drawGrandFinalReset,
    _ => l.drawMatchday(round.number),
  };
}

/// A group's name from its key: `group_a` is Group A. A single table has
/// none.
String? groupTitle(String key, AppLocalizations l) => key.startsWith('group_')
    ? l.drawGroup(key.substring('group_'.length).toUpperCase())
    : null;

/// The round to open on: the player's own match still to play, else the
/// first round still being played, else the last.
int openingRound(List<BracketRound> rounds, String? myEntryId) {
  int? mine;
  int? live;
  for (final (i, round) in rounds.indexed) {
    for (final match in round.matches.where((m) => !m.isOver)) {
      live ??= i;
      if (match.involves(myEntryId)) mine ??= i;
    }
  }
  return mine ?? live ?? max(0, rounds.length - 1);
}
