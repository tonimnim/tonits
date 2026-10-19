import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/features/matches/application/score_draft.dart';
import 'package:tonits/features/matches/data/match_room.dart';

ScoreDraft bestOf(int n, {bool drawAllowed = false}) =>
    ScoreDraft(bestOf: n, gamesToWin: n ~/ 2 + 1, drawAllowed: drawAllowed);

void main() {
  test('a series is games won, capped at the wins it needs', () {
    var d = bestOf(3);
    expect(d.maxFor(mine: true), 2);
    d = d.copyWith(mine: 2);
    // Once the player has 2, the opponent can have at most 1.
    expect(d.maxFor(mine: false), 1);
    expect(d.needsPenalties, isFalse);
  });

  test('a knockout series needs a winner', () {
    expect(
      bestOf(5).copyWith(mine: 2, theirs: 2).problem,
      ScoreProblem.noWinnerYet,
    );
    expect(bestOf(5).copyWith(mine: 3, theirs: 2).problem, isNull);
  });

  test('a round-robin series may end level', () {
    expect(
      bestOf(3, drawAllowed: true).copyWith(mine: 1, theirs: 1).problem,
      isNull,
    );
  });

  test('a series reports games won from the home side, with no penalties', () {
    final r = bestOf(3).copyWith(mine: 1, theirs: 2).toReport(home: false);
    expect(r, const Score(2, 1));
  });

  test('a level knockout best of 1 needs a shootout winner', () {
    var d = bestOf(1).copyWith(mine: 1, theirs: 1);
    expect(d.needsPenalties, isTrue);
    expect(d.problem, ScoreProblem.penaltiesNeedWinner);
    d = d.copyWith(penMine: 4, penTheirs: 2);
    expect(d.problem, isNull);
    expect(d.toReport(home: true), const Score(1, 1, penalties: Score(4, 2)));
  });
}
