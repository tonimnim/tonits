import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tonits/app/shell/tonits_navigation_bar.dart';
import 'package:tonits/features/evidence/application/screenshot_uploader.dart';

import 'support/fakes.dart';
import 'support/harness.dart';

import 'package:tonits/features/matches/application/matches_providers.dart';
import 'package:tonits/features/evidence/application/evidence_providers.dart';

Map<String, dynamic> bodyOf(http.Request request) =>
    jsonDecode(request.body) as Map<String, dynamic>;

/// Opens match m1 from the Matches tab, with [room] as its current state
/// and [routes] answering the actions.
Future<FakeApi> openRoom(
  WidgetTester tester, {
  required Map<String, dynamic> room,
  Map<String, http.Response Function(http.Request)> routes = const {},
}) async {
  final api = FakeApi(
    routes: {
      '/v1/matches/m1': (_) => jsonResponse({'data': room}, 200),
      ...routes,
    },
  );
  await pumpTonits(
    tester,
    api: api,
    refreshToken: 'stored',
    overrides: [
      // Long enough that no background read happens during a test.
      matchRoomPollIntervalsProvider.overrideWithValue((
        fast: const Duration(hours: 1),
        slow: const Duration(hours: 1),
      )),
      evidencePollDelayProvider.overrideWithValue((_) => Duration.zero),
      screenshotPickerProvider.overrideWithValue(() async => pngBytes),
    ],
  );
  await tester.tap(
    find.descendant(
      of: find.byType(TonitsNavigationBar),
      matching: find.text('Matches'),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('vs Amina Otieno'));
  await tester.pumpAndSettle();
  return api;
}

Future<void> scrollToTop(WidgetTester tester) async {
  await tester.drag(find.byType(Scrollable).first, const Offset(0, 2000));
  await tester.pumpAndSettle();
}

/// A score stepper's button, by its tooltip.
Finder stepper(String tooltip) =>
    find.byWidgetPredicate((w) => w is Tooltip && w.message == tooltip);

/// Taps [finder] [times] times, a frame apart as a player would.
Future<void> tapTimes(WidgetTester tester, Finder finder, int times) async {
  for (var i = 0; i < times; i++) {
    await tester.tap(finder);
    await tester.pump();
  }
}

Future<void> tapText(WidgetTester tester, String text) async {
  if (find.text(text).evaluate().isEmpty) {
    await scrollPageTo(tester, find.text(text));
  }
  // Centred, clear of the app bar and the bottom bar.
  await Scrollable.ensureVisible(
    tester.element(find.text(text).last),
    alignment: 0.5,
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text(text).last);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('checking in sends one keyed request and shows the wait', (
    tester,
  ) async {
    final api = await openRoom(
      tester,
      room: matchRoomJson(),
      routes: {
        '/v1/matches/m1/check-ins': (_) => jsonResponse({
          'data': matchRoomJson(lifecycle: 'checked_in', meCheckedIn: true),
        }, 200),
      },
    );

    expect(
      find.text(
        'Check in to say you\'re ready. If only one player '
        'checks in, that player wins.',
      ),
      findsOneWidget,
    );
    expect(find.textContaining('12:00 left'), findsOneWidget);
    // How to find the opponent in eFootball.
    await scrollPageTo(tester, find.text('8F3K-2P9Q-LM4R'));
    expect(find.text('AminaFC'), findsOneWidget);
    expect(find.text('Start a Friend Match'), findsOneWidget);

    await tapText(tester, 'Check in');
    await scrollToTop(tester);

    expect(find.text("You're checked in"), findsOneWidget);
    expect(find.text('Waiting for Amina Otieno to check in.'), findsOneWidget);
    final checkIn = api.requests.singleWhere(
      (r) => r.url.path.endsWith('/check-ins'),
    );
    expect(checkIn.headers['Idempotency-Key'], isNotEmpty);
  });

  testWidgets('a reported score is sent from the home side', (tester) async {
    final api = await openRoom(
      tester,
      room: matchRoomJson(lifecycle: 'report_required'),
      routes: {
        '/v1/matches/m1/score-reports': (request) => jsonResponse(
          roomActionJson(
            matchRoomJson(
              lifecycle: 'awaiting_opponent_confirmation',
              submitted: submittedJson(2, 1, byMe: true),
            ),
          ),
          201,
        ),
      },
    );
    expect(find.text('Play your match'), findsOneWidget);

    await tapText(tester, 'Report the score');
    // Level scores open the penalty shootout below; these are the score.
    await tapTimes(tester, stepper('One more for You').first, 2);
    await tapTimes(tester, stepper('One more for Amina Otieno').first, 1);

    // Nothing is sent until the player vouches for the score.
    await tapText(tester, 'Send score');
    expect(api.requests.where((r) => r.method == 'POST'), hasLength(1));
    await tapText(
      tester,
      'This is the real score. Reporting a false score can get me removed '
      'from the competition.',
    );
    await tapText(tester, 'Send score');

    expect(
      find.text('Score sent. Amina Otieno has 10 minutes to confirm it.'),
      findsOneWidget,
    );
    await scrollToTop(tester);
    expect(find.text('Waiting for Amina Otieno to confirm'), findsOneWidget);
    expect(find.text('2 – 1'), findsOneWidget);
    final report = api.requests.lastWhere(
      (r) => r.url.path.endsWith('/score-reports'),
    );
    expect(bodyOf(report), {
      'homeScore': 2,
      'awayScore': 1,
      'declarationAccepted': true,
    });
  });

  testWidgets('a level knockout score needs a penalty winner', (tester) async {
    final api = await openRoom(
      tester,
      room: matchRoomJson(lifecycle: 'report_required'),
      routes: {
        '/v1/matches/m1/score-reports': (_) => jsonResponse(
          roomActionJson(
            matchRoomJson(lifecycle: 'awaiting_opponent_confirmation'),
          ),
          201,
        ),
      },
    );
    await tapText(tester, 'Report the score');
    expect(find.text('Penalty shootout'), findsOneWidget);
    await tapText(
      tester,
      'This is the real score. Reporting a false score can get me removed '
      'from the competition.',
    );
    await tapText(tester, 'Send score');
    expect(find.text('A penalty shootout needs a winner.'), findsOneWidget);

    await tapTimes(tester, stepper('One more for You').last, 4);
    await tapTimes(tester, stepper('One more for Amina Otieno').last, 3);
    await tapText(tester, 'Send score');

    final report = api.requests.lastWhere(
      (r) => r.url.path.endsWith('/score-reports'),
    );
    expect(bodyOf(report)['tiebreak'], {
      'type': 'penalties',
      'homeScore': 4,
      'awayScore': 3,
    });
  });

  testWidgets("confirming the opponent's score settles the match", (
    tester,
  ) async {
    final api = await openRoom(
      tester,
      room: matchRoomJson(
        lifecycle: 'confirmation_required',
        submitted: submittedJson(1, 2),
      ),
      routes: {
        '/v1/matches/m1/score-reports/confirmation': (_) => jsonResponse(
          roomActionJson(
            matchRoomJson(
              lifecycle: 'completed',
              outcome: 'lost',
              submitted: submittedJson(1, 2),
              completionReason: 'played',
              result: {
                'homeScore': 1,
                'awayScore': 2,
                'tiebreak': null,
                'origin': 'agreed_reports',
                'confirmedAt': testNow.toIso8601String(),
              },
            ),
          ),
          201,
        ),
      },
    );
    // Shown from the player's side: they're home, and lost 1–2.
    expect(find.text('1 – 2'), findsOneWidget);
    expect(find.text('Reported'), findsOneWidget);
    expect(find.textContaining('8:00 left'), findsOneWidget);

    await tapText(tester, "Yes, that's right");

    expect(find.text('You lost'), findsOneWidget);
    expect(find.text('You confirmed the result.'), findsOneWidget);
    expect(find.text('Full time'), findsOneWidget);
    final answer = api.requests.lastWhere(
      (r) => r.url.path.endsWith('/confirmation'),
    );
    expect(bodyOf(answer), {'decision': 'confirm'});
    // A finished match no longer shows how to find the opponent.
    expect(find.text('AminaFC'), findsNothing);
  });

  testWidgets('after rejecting, the screenshot is uploaded and sent', (
    tester,
  ) async {
    var room = matchRoomJson(
      lifecycle: 'confirmation_required',
      submitted: submittedJson(1, 2),
    );
    var checks = 0;
    final api = await openRoom(
      tester,
      room: room,
      routes: {
        '/v1/matches/m1/score-reports/confirmation': (_) {
          room = matchRoomJson(
            lifecycle: 'screenshot_required',
            submitted: submittedJson(1, 2),
          );
          return jsonResponse(roomActionJson(room), 201);
        },
        '/v1/evidence/uploads': (_) => jsonResponse({
          'data': {
            'id': 'ev1',
            'uploadUrl': 'https://storage.test/evidence/ev1',
            'requiredHeaders': {
              'Content-Type': 'image/png',
              'If-None-Match': '*',
            },
            'expiresAt': testNow.toIso8601String(),
          },
        }, 201),
        '/evidence/ev1': (_) => http.Response('', 200),
        '/v1/evidence/uploads/ev1/complete': (_) =>
            jsonResponse({'data': evidenceJson(ready: false)}, 200),
        '/v1/evidence/uploads/ev1': (_) =>
            jsonResponse({'data': evidenceJson(ready: ++checks > 1)}, 200),
        '/v1/matches/m1/score-reports/screenshot': (_) => jsonResponse(
          roomActionJson(
            matchRoomJson(
              lifecycle: 'awaiting_opponent_screenshot',
              submitted: submittedJson(1, 2),
            ),
          ),
          201,
        ),
      },
    );

    await tapText(tester, "No, it's wrong");
    expect(find.text('Reject this result?'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Reject'));
    await tester.pumpAndSettle();

    expect(find.text('Send your screenshot'), findsOneWidget);
    expect(
      find.text(
        "If you don't send one in time, you're removed from the competition.",
      ),
      findsOneWidget,
    );
    await tapText(tester, 'Choose screenshot');
    await scrollToTop(tester);

    expect(find.text('Screenshot sent'), findsOneWidget);
    final upload = api.requests.singleWhere((r) => r.method == 'PUT');
    expect(upload.bodyBytes, pngBytes);
    expect(upload.headers['If-None-Match'], '*');
    expect(upload.headers.containsKey('Authorization'), isFalse);
    final declared = bodyOf(
      api.requests.singleWhere((r) => r.url.path == '/v1/evidence/uploads'),
    );
    expect(declared['mediaType'], 'image/png');
    expect(declared['byteSize'], pngBytes.length);
    final sent = api.requests.lastWhere(
      (r) => r.url.path.endsWith('/screenshot'),
    );
    expect(bodyOf(sent), {'evidenceId': 'ev1'});
  });

  testWidgets('a stale action shows the room as it is now', (tester) async {
    var room = matchRoomJson();
    await openRoom(
      tester,
      room: room,
      routes: {
        '/v1/matches/m1': (_) => jsonResponse({'data': room}, 200),
        '/v1/matches/m1/check-ins': (_) {
          room = matchRoomJson(lifecycle: 'checked_in', meCheckedIn: true);
          return errorResponse(409, 'match_changed');
        },
      },
    );

    await tapText(tester, 'Check in');

    expect(
      find.text('The match changed. Check the latest and try again.'),
      findsOneWidget,
    );
    expect(find.text("You're checked in"), findsOneWidget);
  });

  test('only JPEG and PNG screenshots are accepted', () {
    expect(ScreenshotUploader.mediaTypeOf(pngBytes), 'image/png');
    expect(
      ScreenshotUploader.mediaTypeOf(
        Uint8List.fromList([0xFF, 0xD8, 0xFF, 0xE0]),
      ),
      'image/jpeg',
    );
    expect(
      ScreenshotUploader.mediaTypeOf(Uint8List.fromList(utf8.encode('GIF89a'))),
      isNull,
    );
  });
}

Map<String, dynamic> evidenceJson({required bool ready}) => {
  'id': 'ev1',
  'status': ready ? 'completed' : 'processing',
  'mediaKind': 'image',
  'mediaType': 'image/png',
  'byteSize': 12,
  'ready': ready,
  'processingStatus': ready ? 'succeeded' : 'running',
  'processingErrorCode': null,
  'completedAt': null,
  'processedAt': null,
};
