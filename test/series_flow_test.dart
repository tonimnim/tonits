import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/app/shell/tonits_navigation_bar.dart';
import 'package:tonits/features/matches/ui/widgets/screenshot_preview.dart';

import 'support/fakes.dart';
import 'support/harness.dart';
import 'support/match_room_helpers.dart';

/// The "+" for the player's own goals in the [index]th score stepper pair
/// (games and shootouts in order).
Finder myPlus(int index) => stepper('One more for You').at(index);
Finder theirPlus(int index) => stepper('One more for Amina Otieno').at(index);

void main() {
  testWidgets('a best of 3 is reported as games won', (tester) async {
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
    expect(find.text('Games won'), findsOneWidget);
    expect(find.text('Penalty shootout'), findsNothing);

    // Won 2 of 3; a third tap can't go past the 2 a best of 3 needs.
    await tapTimes(tester, myPlus(0), 3);
    await tapTimes(tester, theirPlus(0), 2);
    await tapText(tester, 'I confirm this is the real score.');
    await tapText(tester, 'Send score');

    final report = api.requests.lastWhere(
      (r) => r.url.path.endsWith('/score-reports'),
    );
    expect(bodyOf(report), {
      'homeScore': 2,
      'awayScore': 1,
      'declarationAccepted': true,
    });
  });

  testWidgets('an undecided knockout series is not sent', (tester) async {
    final api = await openRoom(
      tester,
      room: matchRoomJson(lifecycle: 'report_required', bestOf: 3),
    );
    await tapText(tester, 'Report the score');
    await tapTimes(tester, myPlus(0), 1);
    await tapTimes(tester, theirPlus(0), 1);
    await tapText(tester, 'I confirm this is the real score.');
    await tapText(tester, 'Send score');

    expect(find.text('One of you needs 2 wins.'), findsOneWidget);
    expect(
      api.requests.where((r) => r.url.path.endsWith('/score-reports')),
      isEmpty,
    );
  });

  testWidgets('confirming a series shows the games won', (tester) async {
    await openRoom(
      tester,
      room: matchRoomJson(
        lifecycle: 'confirmation_required',
        bestOf: 3,
        submitted: submittedJson(2, 1),
      ),
    );

    expect(find.text('2 – 1'), findsOneWidget);
    expect(find.text('Reported'), findsOneWidget);
    expect(find.text('Game 1'), findsNothing);
  });

  testWidgets('a disputed series sends one screenshot per game, together', (
    tester,
  ) async {
    final api = await openRoom(
      tester,
      room: matchRoomJson(
        lifecycle: 'screenshot_required',
        bestOf: 3,
        // 2–1 in games won: three games were played.
        submitted: submittedJson(2, 1),
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
    expect(find.text('Send a screenshot of each game'), findsOneWidget);
    await tapText(tester, 'Send screenshots');
    expect(find.text('Your screenshots'), findsOneWidget);
    expect(find.text('Choose'), findsNWidgets(3));

    // Games 1 and 3 only: one is enough to count as responding.
    await tester.tap(find.text('Choose').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Choose').last);
    await tester.pumpAndSettle();
    // Each chosen game shows its screenshot, which opens big to check.
    expect(find.byType(ScreenshotImage), findsNWidgets(2));
    expect(find.text('Change'), findsNWidgets(2));
    await tester.tap(find.byType(ScreenshotImage).first);
    await tester.pumpAndSettle();
    expect(find.text('Is this the Full Time screen?'), findsNothing);
    expect(find.text('Game 1'), findsWidgets);
    await tester.tap(find.widgetWithText(FilledButton, 'Keep'));
    await tester.pumpAndSettle();
    expect(api.requests.where((r) => r.method == 'PUT'), isEmpty);
    await tester.tap(find.text('Send 2 screenshots'));
    await tester.pumpAndSettle();

    // The sheet closes, and the room shows the wait.
    expect(find.text('Your screenshots'), findsNothing);
    expect(find.text("Waiting for Amina Otieno's screenshots"), findsOneWidget);
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

  testWidgets('a series match card says how many games', (tester) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/me/matches': (_) =>
              jsonResponse(pageJson([matchJson()..['bestOf'] = 3]), 200),
        },
      ),
    );
    expect(
      find.textContaining(
        'Nairobi Weekend Cup · Round of 32 · Best of 3',
        findRichText: true,
      ),
      findsOneWidget,
    );
  });
}
