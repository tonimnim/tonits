import '../data/match_room.dart';

/// Why a score can't be sent yet.
enum ScoreProblem {
  /// A level knockout best of 1 has no penalty winner.
  penaltiesNeedWinner,

  /// Neither side has the games a knockout series needs.
  noWinnerYet,
}

/// The result as the player enters it, from their side. A best of 1 is the
/// score in goals, with penalties when a knockout match is level. A series
/// (best of 3 or 5) is games won, such as 2–1; its games are only shown
/// game by game, with screenshots, if the opponent disputes it. Mirrors the
/// API's rules; the server stays the authority.
class ScoreDraft {
  const ScoreDraft({
    required this.bestOf,
    required this.gamesToWin,
    required this.drawAllowed,
    this.mine = 0,
    this.theirs = 0,
    this.penMine = 0,
    this.penTheirs = 0,
  });

  factory ScoreDraft.of(MatchRoom room) => ScoreDraft(
    bestOf: room.bestOf,
    gamesToWin: room.gamesToWin,
    drawAllowed: room.drawAllowed,
  );

  final int bestOf;
  final int gamesToWin;

  /// Round robin: a match or series may end level.
  final bool drawAllowed;

  /// Goals for a best of 1, games won for a series.
  final int mine;
  final int theirs;

  /// A level knockout best of 1's penalty shootout.
  final int penMine;
  final int penTheirs;

  bool get isSeries => bestOf > 1;

  /// The most a side can have: any number of goals, or up to the games a
  /// series needs, and one fewer once the other side has them.
  int maxFor({required bool mine}) {
    if (!isSeries) return 99;
    final other = mine ? theirs : this.mine;
    return other >= gamesToWin ? gamesToWin - 1 : gamesToWin;
  }

  bool get needsPenalties => !isSeries && !drawAllowed && mine == theirs;

  /// What stops it being sent, or null when it can be.
  ScoreProblem? get problem {
    if (needsPenalties && penMine == penTheirs) {
      return ScoreProblem.penaltiesNeedWinner;
    }
    if (isSeries &&
        !drawAllowed &&
        mine != gamesToWin &&
        theirs != gamesToWin) {
      return ScoreProblem.noWinnerYet;
    }
    return null;
  }

  ScoreDraft copyWith({int? mine, int? theirs, int? penMine, int? penTheirs}) =>
      ScoreDraft(
        bestOf: bestOf,
        gamesToWin: gamesToWin,
        drawAllowed: drawAllowed,
        mine: mine ?? this.mine,
        theirs: theirs ?? this.theirs,
        penMine: penMine ?? this.penMine,
        penTheirs: penTheirs ?? this.penTheirs,
      );

  /// The result in home–away terms.
  Score toReport({required bool home}) {
    final penalties = needsPenalties
        ? (home ? Score(penMine, penTheirs) : Score(penTheirs, penMine))
        : null;
    return home
        ? Score(mine, theirs, penalties: penalties)
        : Score(theirs, mine, penalties: penalties);
  }
}
