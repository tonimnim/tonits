import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/app/shell/tonits_navigation_bar.dart';

import 'support/fakes.dart';
import 'support/harness.dart';
import 'support/match_room_helpers.dart';

/// The "+" for the player's own goals in the [index]th score stepper pair
/// (games and shootouts in order).
Finder myPlus(int index) => stepper('One more for You').at(index);
Finder theirPlus(int index) => stepper('One more for Amina Otieno').at(index);

void main() {
  testWidgets('a best of 3 is reported game by game, penalties and all', (
    tester,
  ) async {
    final api = await openRoom(
      tester,
      room: matchRoomJson(lifecycle: 'report_required', bestOf: 3),
      routes: {
        '/v1/matches/m1/score-reports': (_) => jsonResponse(
          roomActionJson(
            matchRoomJson(
              lifecycle: 'awaiting_opponent_confirmation',
              bestOf: 3,
            ),
          ),
          201,
        ),
      },
    );
    expect(find.text('Best of 3 · first to 2'), findsOneWidget);
    // The reminder to keep every Full Time screen.
    await scrollPageTo(tester, find.textContaining('Screenshot every'));

    await scrollToTop(tester);
    await tapText(tester, 'Report the score');
    expect(find.text('Game 1'), findsOneWidget);

    // Game 1: 2–1 to the player.
    await tapTimes(tester, myPlus(0), 2);
    await tapTimes(tester, theirPlus(0), 1);
    await scrollToTop(tester);
    expect(find.text('You lead 1–0'), findsOneWidget);
    await tapText(tester, 'Add game 2');

    // Game 2: 1–1, so penalties decide it, and no game 3 until they do.
    await tapTimes(tester, myPlus(1), 1);
    await tapTimes(tester, theirPlus(1), 1);
    expect(find.text('Penalty shootout'), findsOneWidget);
    expect(find.text('Add game 3'), findsNothing);
    await tapTimes(tester, myPlus(2), 4);
    await tapTimes(tester, theirPlus(2), 3);

    // 2–0 in games: decided, so there's no third game to add.
    await scrollToTop(tester);
    expect(find.text('You win the series 2–0'), findsOneWidget);
    expect(find.text('Add game 3'), findsNothing);

    await tapText(
      tester,
      'This is the real score. Reporting a false score can get me removed '
      'from the competition.',
    );
    await tapText(tester, 'Send score');

    final report = api.requests.lastWhere(
      (r) => r.url.path.endsWith('/score-reports'),
    );
    expect(bodyOf(report), {
      'homeScore': 2,
      'awayScore': 0,
      'games': [
        {'homeScore': 2, 'awayScore': 1},
        {
          'homeScore': 1,
          'awayScore': 1,
          'tiebreak': {'type': 'penalties', 'homeScore': 4, 'awayScore': 3},
        },
      ],
      'declarationAccepted': true,
    });
  });

  testWidgets('an undecided series is not sent', (tester) async {
    final api = await openRoom(
      tester,
      room: matchRoomJson(lifecycle: 'report_required', bestOf: 3),
    );
    await tapText(tester, 'Report the score');
    await tapTimes(tester, myPlus(0), 1);
    await tapText(
      tester,
      'This is the real score. Reporting a false score can get me removed '
      'from the competition.',
    );
    await tapText(tester, 'Send score');

    expect(find.text('Add games until one side has 2 wins.'), findsOneWidget);
    expect(
      api.requests.where((r) => r.url.path.endsWith('/score-reports')),
      isEmpty,
    );
  });

  testWidgets('confirming a series shows every game', (tester) async {
    await openRoom(
      tester,
      room: matchRoomJson(
        lifecycle: 'confirmation_required',
        bestOf: 3,
        submitted: submittedJson(
          2,
          1,
          games: [gameJson(1, 2), gameJson(2, 0), gameJson(3, 1)],
        ),
      ),
    );

    expect(find.text('Game 1'), findsOneWidget);
    expect(find.text('1–2'), findsOneWidget);
    expect(find.text('Game 3'), findsOneWidget);
    expect(find.text('You win the series 2–1'), findsOneWidget);
  });

  testWidgets('a disputed series sends one screenshot per game, together', (
    tester,
  ) async {
    final api = await openRoom(
      tester,
      room: matchRoomJson(
        lifecycle: 'screenshot_required',
        bestOf: 3,
        submitted: submittedJson(
          2,
          1,
          games: [gameJson(1, 2), gameJson(2, 0), gameJson(3, 1)],
        ),
      ),
      routes: {
        ...evidenceRoutes(),
        '/v1/matches/m1/score-reports/screenshot': (_) => jsonResponse(
          roomActionJson(
            matchRoomJson(lifecycle: 'awaiting_opponent_screenshot', bestOf: 3),
          ),
          201,
        ),
      },
    );
    expect(find.text('Send your screenshots'), findsOneWidget);
    expect(find.text('Choose'), findsNWidgets(3));

    // Games 1 and 3 only: one is enough to count as responding.
    await tapFound(tester, find.text('Choose').first);
    await tapFound(tester, find.text('Choose').last);
    await tapText(tester, 'Send 2 screenshots');

    expect(find.text('Screenshots sent'), findsOneWidget);
    final sent = api.requests.lastWhere(
      (r) => r.url.path.endsWith('/screenshot'),
    );
    expect(bodyOf(sent), {
      'screenshots': [
        {'game': 1, 'evidenceId': 'ev1'},
        {'game': 3, 'evidenceId': 'ev1'},
      ],
    });
    expect(api.requests.where((r) => r.method == 'PUT'), hasLength(2));
  });

  testWidgets('the competition says how many games each round is', (
    tester,
  ) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/competitions/c1': (_) => jsonResponse({
            'data': competitionJson(
              matchFormat: {
                'bestOf': 1,
                'rounds': {'final': 5, 'semifinal': 3},
              },
            ),
          }, 200),
        },
      ),
    );
    await tester.tap(
      find.descendant(
        of: find.byType(TonitsNavigationBar),
        matching: find.text('Compete'),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Nairobi Weekend Cup'));
    await tester.pumpAndSettle();
    await scrollPageTo(tester, find.text('Final'));

    expect(find.text('Games per match'), findsOneWidget);
    expect(find.text('Other rounds'), findsOneWidget);
    expect(find.text('Semi-finals'), findsOneWidget);
    expect(find.text('Best of 3'), findsOneWidget);
    expect(find.text('First to 2 wins'), findsOneWidget);
    expect(find.text('Best of 5'), findsOneWidget);
    // Semi-finals come before the final.
    expect(
      tester.getTopLeft(find.text('Semi-finals')).dy,
      lessThan(tester.getTopLeft(find.text('Final')).dy),
    );
  });

  testWidgets('a best of 1 shows no series parts', (tester) async {
    await openRoom(tester, room: matchRoomJson(lifecycle: 'report_required'));
    expect(find.textContaining('Best of'), findsNothing);
    expect(find.textContaining('Screenshot every'), findsNothing);
  });
}
