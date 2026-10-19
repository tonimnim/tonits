import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/features/competitions/application/draw_rounds.dart';
import 'package:tonits/features/competitions/data/draw.dart';

import 'support/draw_fixtures.dart';
import 'support/fakes.dart';
import 'support/harness.dart';

BracketStage _stage(List<Map<String, dynamic>> rounds) =>
    BracketStage.fromJson(stageJson(rounds));

Map<String, dynamic> _open(String id) => bracketMatchJson(id, state: 'pending');

void main() {
  group('rounds', () {
    test('a knockout is named back from the final', () {
      final stage = _stage([
        for (var n = 1; n <= 5; n++) roundJson(n, [_open('m$n')]),
        roundJson(1, bracket: 'bronze', [_open('b1')]),
      ]);
      expect(
        [for (final r in playableRounds(stage)) roundTitle(r, stage, en)],
        [
          'Round of 32',
          'Round of 16',
          'Quarter-finals',
          'Semi-finals',
          'Final',
          'Third-place match',
        ],
      );
    });

    test('a double elimination runs winners, losers, then the grand '
        'final, without a reset it never needed', () {
      final stage = _stage([
        roundJson(1, bracket: 'grand_final', [_open('g1')]),
        roundJson(2, bracket: 'grand_final', [
          bracketMatchJson(
            'g2',
            state: 'cancelled',
            reason: 'reset_not_required',
          ),
        ]),
        roundJson(1, bracket: 'losers', [_open('l1')]),
        roundJson(2, bracket: 'losers', [_open('l2')]),
        roundJson(1, bracket: 'winners', [_open('w1')]),
        roundJson(2, bracket: 'winners', [_open('w2')]),
      ]);
      expect(
        [for (final r in playableRounds(stage)) roundTitle(r, stage, en)],
        [
          'Winners round 1',
          "Winners' final",
          'Losers round 1',
          "Losers' final",
          'Grand final',
        ],
      );
    });

    test("it opens on the player's next match, else the first round still "
        'going, else the last', () {
      final rounds = playableRounds(BracketStage.fromJson(knockoutJson()));
      expect(openingRound(rounds, myEntryId), 1);
      // Someone not in it sees the first round with a match left: the
      // semi-finals here, as every quarter-final is over.
      expect(openingRound(rounds, 'e-stranger'), 1);
      final over = _stage([
        roundJson(1, [bracketMatchJson('a')]),
        roundJson(2, [bracketMatchJson('b')]),
      ]);
      expect(openingRound(playableRounds(over), myEntryId), 1);
    });

    test('a group key names its group; a single table has none', () {
      expect(groupTitle('group_b', en), 'Group B');
      expect(groupTitle('main', en), isNull);
    });
  });

  testWidgets("a knockout's bracket opens on the player's next match", (
    tester,
  ) async {
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          ...drawRoutes(status: 'running', stages: [knockoutJson()]),
          '/v1/matches/m-s1': (_) =>
              jsonResponse({'data': matchRoomJson()}, 200),
        },
      ),
    );
    await openCompetition(tester, 'Bracket');

    // The bracket comes before the competition's facts.
    expect(
      tester.getTopLeft(find.text('Bracket')).dy,
      lessThan(tester.getTopLeft(find.text('Entry')).dy),
    );
    for (final round in ['Quarter-finals', 'Semi-finals', 'Final']) {
      expect(find.text(round), findsOneWidget);
    }
    // The semi-finals: the player's match is next, the other a walkover.
    expect(find.text('striker.9 (you)'), findsOneWidget);
    expect(find.text('Amina Otieno'), findsOneWidget);
    expect(find.text('No opponent'), findsOneWidget);
    expect(find.text('Walkover'), findsOneWidget);
    expect(find.text('Coast Ace'), findsNothing);
    expect(
      api.requests.where((r) => r.url.path == '/v1/me/registrations'),
      isNotEmpty,
    );

    await tapChip(tester, 'Quarter-finals');
    expect(find.text('Coast Ace'), findsOneWidget);
    expect(find.text('4–3 on penalties'), findsOneWidget);
    expect(find.text('Neither player showed'), findsOneWidget);
    // The winner reads bold, the loser muted.
    final winner = tester.widget<Text>(find.text('Lake Striker'));
    final loser = tester.widget<Text>(find.text('Kibera Maestro'));
    expect(winner.style?.fontWeight, FontWeight.w700);
    expect(loser.style?.fontWeight, FontWeight.w500);

    await tapChip(tester, 'Final');
    expect(find.text('To be decided'), findsOneWidget);

    // Only the player's own match opens a room.
    await tapChip(tester, 'Semi-finals');
    await tester.tap(find.text('striker.9 (you)'));
    await tester.pumpAndSettle();
    expect(find.text('Check in to play'), findsOneWidget);
  });

  testWidgets("a round robin shows the player's group and its matchdays", (
    tester,
  ) async {
    final draw = roundRobinJson();
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: drawRoutes(
          status: 'running',
          stages: [draw.stage],
          tables: [draw.tables],
        ),
      ),
    );
    await openCompetition(tester, 'Standings');

    expect(find.text('Group A'), findsOneWidget);
    expect(find.text('Group B'), findsOneWidget);
    expect(find.text('striker.9 (you)'), findsWidgets);
    expect(find.text('+2'), findsOneWidget);
    expect(find.text('−2'), findsOneWidget);
    expect(find.text('Removed'), findsOneWidget);
    // A best of 1 can be drawn, so its table counts draws.
    expect(find.text('D'), findsOneWidget);

    await scrollPageTo(tester, find.text('Matchday 2'));
    // Opens on the player's next match.
    expect(find.text('Rift Valley FC'), findsWidgets);

    await tapChip(tester, 'Group B');
    expect(find.text('Kibera Maestro'), findsWidgets);
    expect(find.text('Matchday 2'), findsNothing);
  });

  testWidgets('a series round robin has no draws column and counts games', (
    tester,
  ) async {
    final draw = roundRobinJson(bestOf: 3);
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: drawRoutes(
          status: 'running',
          stages: [draw.stage],
          tables: [draw.tables],
        ),
      ),
    );
    await openCompetition(tester, 'Standings');

    expect(find.text('D'), findsNothing);
    // Game difference: 2 won, 1 lost.
    expect(find.text('+1'), findsOneWidget);
    await scrollPageTo(tester, find.text('Best of 3'));
  });

  testWidgets('a finished knockout leads with its final standings', (
    tester,
  ) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: drawRoutes(
          status: 'completed',
          stages: [knockoutJson()],
          placements: [
            {'placement': 1, 'entryId': lake.$1, 'displayName': lake.$2},
            {'placement': 2, 'entryId': amina.$1, 'displayName': amina.$2},
            {'placement': 3, 'entryId': kibera.$1, 'displayName': kibera.$2},
            {'placement': 3, 'entryId': coast.$1, 'displayName': coast.$2},
            {'placement': 5, 'entryId': myEntryId, 'displayName': 'striker.9'},
            {'placement': 5, 'entryId': rift.$1, 'displayName': rift.$2},
          ],
        ),
      ),
    );
    await openCompetition(tester, 'Final standings');

    expect(
      tester.getTopLeft(find.text('Final standings')).dy,
      lessThan(tester.getTopLeft(find.text('Bracket')).dy),
    );
    // The podium, ties included, and the player's own place.
    expect(find.bySemanticsLabel(RegExp('^Place 1\\b')), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('^Place 3\\b')), findsNWidgets(2));
    expect(find.bySemanticsLabel(RegExp('^Place 5\\b')), findsOneWidget);
  });

  testWidgets('before the draw there is no bracket to fetch', (tester) async {
    final api = await pumpTonits(tester, refreshToken: 'stored');
    await openCompetition(tester, 'Entry');

    expect(find.text('Bracket'), findsNothing);
    expect(api.requests.where((r) => r.url.path.endsWith('/bracket')), isEmpty);
  });
}
