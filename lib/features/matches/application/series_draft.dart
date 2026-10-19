import '../data/match_room.dart';

/// One game as the player enters it, from their side.
class GameDraft {
  const GameDraft({
    this.mine = 0,
    this.theirs = 0,
    this.penMine = 0,
    this.penTheirs = 0,
  });

  final int mine;
  final int theirs;

  /// A level knockout game's penalty shootout.
  final int penMine;
  final int penTheirs;

  bool get level => mine == theirs;

  GameDraft copyWith({int? mine, int? theirs, int? penMine, int? penTheirs}) =>
      GameDraft(
        mine: mine ?? this.mine,
        theirs: theirs ?? this.theirs,
        penMine: penMine ?? this.penMine,
        penTheirs: penTheirs ?? this.penTheirs,
      );
}

/// Why a draft can't be sent yet.
enum SeriesProblem {
  /// A level knockout game has no penalty winner.
  penaltiesNeedWinner,

  /// Nobody has won the games a knockout series needs.
  noWinnerYet,

  /// A round-robin series without a winner needs every game.
  gamesMissing,
}

/// A match's result as the player enters it, game by game: who leads, when
/// it's decided, and what's missing. A best of 1 is a series of one game.
/// Mirrors the API's rules; the server stays the authority.
class SeriesDraft {
  const SeriesDraft({
    required this.bestOf,
    required this.gamesToWin,
    required this.drawAllowed,
    this.games = const [GameDraft()],
  });

  factory SeriesDraft.of(MatchRoom room) => SeriesDraft(
    bestOf: room.bestOf,
    gamesToWin: room.gamesToWin,
    drawAllowed: room.drawAllowed,
  );

  final int bestOf;
  final int gamesToWin;

  /// Round robin: games (and a series) may end level, with no penalties.
  final bool drawAllowed;
  final List<GameDraft> games;

  bool get isSeries => bestOf > 1;

  /// Whether [game] is a level knockout game, which penalties decide.
  bool needsPenalties(GameDraft game) => !drawAllowed && game.level;

  /// 1 when the player won [game], -1 when they lost it, 0 for a draw or an
  /// undecided shootout.
  int outcome(GameDraft game) {
    if (!game.level) return game.mine > game.theirs ? 1 : -1;
    if (drawAllowed || game.penMine == game.penTheirs) return 0;
    return game.penMine > game.penTheirs ? 1 : -1;
  }

  int get myWins => games.where((g) => outcome(g) > 0).length;
  int get theirWins => games.where((g) => outcome(g) < 0).length;

  /// One side has the games it needs; no more games are played.
  bool get decided => myWins >= gamesToWin || theirWins >= gamesToWin;

  /// Another game can follow: the series isn't decided, there are games
  /// left, and the last game has a result.
  bool get canAddGame {
    if (!isSeries || decided || games.length >= bestOf) return false;
    final last = games.last;
    return !needsPenalties(last) || outcome(last) != 0;
  }

  SeriesDraft withGames(List<GameDraft> games) => SeriesDraft(
    bestOf: bestOf,
    gamesToWin: gamesToWin,
    drawAllowed: drawAllowed,
    games: games,
  );

  SeriesDraft update(int index, GameDraft game) =>
      withGames([...games]..[index] = game);

  SeriesDraft addGame() => withGames([...games, const GameDraft()]);

  SeriesDraft removeLastGame() =>
      games.length <= 1 ? this : withGames(games.sublist(0, games.length - 1));

  /// What stops it being sent, or null when it can be.
  SeriesProblem? get problem {
    if (games.any((g) => needsPenalties(g) && outcome(g) == 0)) {
      return SeriesProblem.penaltiesNeedWinner;
    }
    if (!isSeries) return null;
    if (decided) return null;
    if (!drawAllowed) return SeriesProblem.noWinnerYet;
    // A round-robin series nobody won lists every game.
    return games.length == bestOf ? null : SeriesProblem.gamesMissing;
  }

  Score _game(GameDraft g, {required bool home}) {
    final penalties = needsPenalties(g)
        ? (home ? Score(g.penMine, g.penTheirs) : Score(g.penTheirs, g.penMine))
        : null;
    return home
        ? Score(g.mine, g.theirs, penalties: penalties)
        : Score(g.theirs, g.mine, penalties: penalties);
  }

  /// The result in home–away terms: for a series, games won, with every
  /// game; for a best of 1, the score and its shootout.
  ({Score score, List<Score>? games}) toReport({required bool home}) {
    if (!isSeries) return (score: _game(games.single, home: home), games: null);
    final played = [for (final g in games) _game(g, home: home)];
    return (
      score: home ? Score(myWins, theirWins) : Score(theirWins, myWins),
      games: played,
    );
  }
}
