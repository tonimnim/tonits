import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tonits/app/shell/tonits_navigation_bar.dart';

import 'fakes.dart';
import 'harness.dart';

/// The signed-in player's entry in c1.
const myEntryId = 'e-me';

/// A `BracketMatch`. Players are (entryId, displayName).
Map<String, dynamic> bracketMatchJson(
  String id, {
  int number = 1,
  String state = 'completed',
  (String, String)? home,
  (String, String)? away,
  (int, int)? score,
  (int, int)? penalties,
  String? winner,
  int bestOf = 1,
  String? reason,
  String? scheduledAt,
  bool awayVoided = false,
}) => {
  'id': id,
  'code': 'M$number',
  'matchNumber': number,
  'bestOf': bestOf,
  'state': state,
  'home': _slot('home', home),
  'away': _slot('away', away, voided: awayVoided),
  'score': score == null
      ? null
      : {
          'submissionId': 'sub-$id',
          'homeScore': score.$1,
          'awayScore': score.$2,
          'tiebreak': penalties == null
              ? null
              : {
                  'type': 'penalties',
                  'homeScore': penalties.$1,
                  'awayScore': penalties.$2,
                },
          'confirmedAt': '2026-10-10T18:00:00Z',
        },
  'winnerEntryId': winner,
  'scheduledAt': scheduledAt,
  'resultDueAt': null,
  'completedAt': null,
  'progression': {
    'graphRank': number,
    'activationRule': 'unconditional',
    'activationSourceMatchId': null,
    'completionReason': reason,
  },
  'version': 1,
};

Map<String, dynamic> _slot(
  String side,
  (String, String)? player, {
  bool voided = false,
}) => {
  'side': side,
  'participant': player == null
      ? null
      : {'entryId': player.$1, 'displayName': player.$2, 'seed': null},
  'source': {
    'kind': 'winner_of',
    'entryId': null,
    'matchId': null,
    'sourceGraphRank': null,
    'resolvedEntryId': player?.$1,
    'resolvedAt': null,
    'voidedAt': voided ? '2026-10-10T18:00:00Z' : null,
  },
};

Map<String, dynamic> roundJson(
  int number,
  List<Map<String, dynamic>> matches, {
  String bracket = 'main',
}) => {
  'number': number,
  'name': 'Round $number',
  'bracket': bracket,
  'matches': matches,
};

Map<String, dynamic> stageJson(
  List<Map<String, dynamic>> rounds, {
  String format = 'single_elimination',
  String status = 'active',
}) => {
  'id': 's1',
  'name': 'Main stage',
  'position': 1,
  'format': format,
  'bestOf': 1,
  'status': status,
  'rounds': rounds,
};

const me = (myEntryId, 'striker.9');
const coast = ('e-coast', 'Coast Ace');
const amina = ('e-amina', 'Amina Otieno');
const rift = ('e-rift', 'Rift Valley FC');
const lake = ('e-lake', 'Lake Striker');
const kibera = ('e-kibera', 'Kibera Maestro');
const mombasa = ('e-mombasa', 'Mombasa Flyer');
const nyeri = ('e-nyeri', 'Nyeri Ace');

/// Eight players, three rounds. The player won their quarter-final and
/// their semi-final is next.
Map<String, dynamic> knockoutJson() => stageJson([
  roundJson(1, [
    bracketMatchJson(
      'q1',
      home: me,
      away: coast,
      score: (2, 1),
      winner: myEntryId,
      reason: 'played',
    ),
    bracketMatchJson(
      'q2',
      number: 2,
      state: 'forfeit',
      home: amina,
      away: rift,
      winner: amina.$1,
      reason: 'walkover',
    ),
    bracketMatchJson(
      'q3',
      number: 3,
      home: lake,
      away: kibera,
      score: (1, 1),
      penalties: (4, 3),
      winner: lake.$1,
      reason: 'played',
    ),
    bracketMatchJson(
      'q4',
      number: 4,
      state: 'cancelled',
      home: mombasa,
      away: nyeri,
      reason: 'double_no_show',
    ),
  ]),
  roundJson(2, [
    bracketMatchJson(
      'm-s1',
      state: 'ready',
      home: me,
      away: amina,
      scheduledAt: '2026-10-14T18:00:00Z',
    ),
    bracketMatchJson(
      's2',
      number: 2,
      state: 'forfeit',
      home: lake,
      awayVoided: true,
      winner: lake.$1,
      reason: 'walkover',
    ),
  ]),
  roundJson(3, [bracketMatchJson('f1', state: 'pending', away: lake)]),
]);

Map<String, dynamic> standingRowJson(
  (String, String) player, {
  int? rank,
  int played = 2,
  int wins = 0,
  int draws = 0,
  int losses = 0,
  int gamesWon = 0,
  int gamesLost = 0,
  int goalDifference = 0,
  int points = 0,
  bool removed = false,
}) => {
  'rank': rank,
  'entryId': player.$1,
  'displayName': player.$2,
  'played': played,
  'wins': wins,
  'draws': draws,
  'losses': losses,
  'gamesWon': gamesWon,
  'gamesLost': gamesLost,
  'goalsFor': 0,
  'goalsAgainst': 0,
  'goalDifference': goalDifference,
  'points': points,
  'walkovers': 0,
  'removed': removed,
};

/// Two groups of three. The player tops Group A; one of its players was
/// removed after the draw.
({Map<String, dynamic> stage, Map<String, dynamic> tables}) roundRobinJson({
  int bestOf = 1,
}) => (
  stage: stageJson(format: 'round_robin', [
    roundJson(1, bracket: 'group_a', [
      bracketMatchJson(
        'a1',
        home: me,
        away: coast,
        score: (3, 1),
        winner: myEntryId,
        bestOf: bestOf,
        reason: 'played',
      ),
    ]),
    roundJson(2, bracket: 'group_a', [
      bracketMatchJson(
        'a2',
        state: 'ready',
        home: rift,
        away: me,
        bestOf: bestOf,
        scheduledAt: '2026-10-15T18:00:00Z',
      ),
    ]),
    roundJson(1, bracket: 'group_b', [
      bracketMatchJson(
        'b1',
        home: lake,
        away: kibera,
        score: (0, 2),
        winner: kibera.$1,
        bestOf: bestOf,
        reason: 'played',
      ),
    ]),
  ]),
  tables: {
    'id': 's1',
    'name': 'Main stage',
    'position': 1,
    'status': 'active',
    'groups': [
      {
        'key': 'group_a',
        'rows': [
          standingRowJson(
            me,
            rank: 1,
            played: 1,
            wins: 1,
            gamesWon: 2,
            gamesLost: 1,
            goalDifference: 2,
            points: bestOf > 1 ? 2 : 3,
          ),
          standingRowJson(
            coast,
            rank: 2,
            played: 1,
            losses: 1,
            gamesWon: 1,
            gamesLost: 2,
            goalDifference: -2,
            points: bestOf > 1 ? 1 : 0,
          ),
          standingRowJson(rift, played: 0, removed: true),
        ],
      },
      {
        'key': 'group_b',
        'rows': [
          standingRowJson(
            kibera,
            rank: 1,
            played: 1,
            wins: 1,
            goalDifference: 2,
            points: 3,
          ),
          standingRowJson(
            lake,
            rank: 2,
            played: 1,
            losses: 1,
            goalDifference: -2,
          ),
        ],
      },
    ],
  },
);

/// Routes for c1 with the given draw, and the player entered in it.
Map<String, http.Response Function(http.Request)> drawRoutes({
  required String status,
  List<Map<String, dynamic>> stages = const [],
  List<Map<String, dynamic>> tables = const [],
  List<Map<String, dynamic>> placements = const [],
}) => {
  '/v1/competitions/c1': (_) => jsonResponse({
    'data': {
      ...competitionJson(status: status),
      if (stages.any((s) => s['format'] == 'round_robin'))
        'format': 'round_robin',
    },
  }, 200),
  // Entered, and past entering.
  '/v1/competitions/c1/eligibility': (_) =>
      jsonResponse(eligibilityJson(status: 'registered', action: 'none'), 200),
  '/v1/competitions/c1/bracket': (_) => jsonResponse({
    'data': {'competitionId': 'c1', 'stages': stages},
  }, 200),
  '/v1/competitions/c1/standings': (_) => jsonResponse({
    'data': {'competitionId': 'c1', 'stages': tables, 'placements': placements},
  }, 200),
  '/v1/me/registrations': (_) => jsonResponse(
    pageJson([
      {'id': 'e-other', 'competitionId': 'c2', 'status': 'registered'},
      {'id': myEntryId, 'competitionId': 'c1', 'status': 'accepted'},
    ]),
    200,
  ),
};

/// Opens c1 from the Compete tab and scrolls to [text].
Future<void> openCompetition(WidgetTester tester, String text) async {
  await tester.tap(
    find.descendant(
      of: find.byType(TonitsNavigationBar),
      matching: find.text('Compete'),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('Nairobi Weekend Cup').first);
  await tester.pumpAndSettle();
  await scrollPageTo(tester, find.text(text));
}

/// Taps a chip in a sideways row, bringing it on screen first.
Future<void> tapChip(WidgetTester tester, String label) async {
  // Centred, clear of the app bar and the bottom bar.
  await Scrollable.ensureVisible(
    tester.element(find.text(label)),
    alignment: 0.5,
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text(label));
  await tester.pumpAndSettle();
}
