import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/features/matches/application/series_draft.dart';
import 'package:tonits/features/matches/data/match_room.dart';

SeriesDraft bestOf(int n, {bool drawAllowed = false}) =>
    SeriesDraft(bestOf: n, gamesToWin: n ~/ 2 + 1, drawAllowed: drawAllowed);

void main() {
  test('a series stops adding games once a side has the wins it needs', () {
    var d = bestOf(3).update(0, const GameDraft(mine: 2, theirs: 1));
    expect(d.canAddGame, isTrue);
    d = d.addGame().update(1, const GameDraft(mine: 1));
    expect(d.decided, isTrue);
    expect(d.canAddGame, isFalse);
    expect(d.problem, isNull);
  });

  test('a level knockout game needs a penalty winner before the next', () {
    var d = bestOf(3).update(0, const GameDraft(mine: 1, theirs: 1));
    expect(d.needsPenalties(d.games.first), isTrue);
    expect(d.canAddGame, isFalse);
    expect(d.problem, SeriesProblem.penaltiesNeedWinner);
    d = d.update(
      0,
      const GameDraft(mine: 1, theirs: 1, penMine: 5, penTheirs: 4),
    );
    expect(d.myWins, 1);
    expect(d.canAddGame, isTrue);
  });

  test('a knockout series without a winner cannot be sent', () {
    final d = bestOf(5).update(0, const GameDraft(mine: 3));
    expect(d.problem, SeriesProblem.noWinnerYet);
  });

  test('a round-robin series may end level once every game is in', () {
    var d = bestOf(3, drawAllowed: true)
        .update(0, const GameDraft(mine: 1))
        .addGame()
        .update(1, const GameDraft(theirs: 2))
        .addGame()
        .update(2, const GameDraft(mine: 1, theirs: 1));
    expect(d.needsPenalties(d.games.last), isFalse);
    expect(d.decided, isFalse);
    expect(d.canAddGame, isFalse);
    expect(d.problem, isNull);
    d = d.removeLastGame();
    expect(d.problem, SeriesProblem.gamesMissing);
  });

  test('a series reports games won, and every game from the home side', () {
    final d = bestOf(3)
        .update(0, const GameDraft(theirs: 1))
        .addGame()
        .update(
          1,
          const GameDraft(mine: 2, theirs: 2, penMine: 4, penTheirs: 3),
        )
        .addGame()
        .update(2, const GameDraft(mine: 3, theirs: 1));
    // The player is away: home is the opponent.
    final r = d.toReport(home: false);
    expect((r.score.home, r.score.away), (1, 2));
    expect(r.games, [
      const Score(1, 0),
      const Score(2, 2, penalties: Score(3, 4)),
      const Score(1, 3),
    ]);
  });

  test('a best of 1 reports its score with no games', () {
    final r = bestOf(1)
        .update(
          0,
          const GameDraft(mine: 1, theirs: 1, penMine: 4, penTheirs: 2),
        )
        .toReport(home: true);
    expect(r.score, const Score(1, 1, penalties: Score(4, 2)));
    expect(r.games, isNull);
  });
}
