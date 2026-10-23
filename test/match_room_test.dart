import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tonits/features/evidence/application/screenshot_uploader.dart';

import 'support/fakes.dart';
import 'support/harness.dart';
import 'support/match_room_helpers.dart';

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

    expect(find.text('Check in to play'), findsOneWidget);
    expect(find.textContaining('12:00 left'), findsOneWidget);
    // How to find the opponent in eFootball.
    await scrollPageTo(tester, find.text('8F3K-2P9Q-LM4R'));
    expect(find.text('AminaFC'), findsOneWidget);
    expect(find.text('Start a Friend Match'), findsOneWidget);

    await tapText(tester, 'Check in');
    await scrollToTop(tester);

    expect(find.text('Waiting for Amina Otieno to check in'), findsOneWidget);
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
    expect(find.text('Play, then report the score'), findsOneWidget);

    await tapText(tester, 'Report the score');
    // Level scores open the penalty shootout below; these are the score.
    await tapTimes(tester, stepper('One more for You').first, 2);
    await tapTimes(tester, stepper('One more for Amina Otieno').first, 1);

    // Nothing is sent until the player vouches for the score.
    await tapText(tester, 'Send score');
    expect(api.requests.where((r) => r.method == 'POST'), hasLength(1));
    await tapText(tester, 'I confirm this is the real score.');
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
    await tapText(tester, 'I confirm this is the real score.');
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

    await tapText(tester, 'Accept');

    expect(find.text('You lost'), findsOneWidget);
    expect(find.text('You confirmed it'), findsOneWidget);
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

    await tapText(tester, 'Decline');
    expect(find.text('Reject this result?'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Decline'));
    await tester.pumpAndSettle();

    expect(find.text('Send your Full Time screenshot'), findsOneWidget);
    expect(find.text("Send in time, or you're removed."), findsOneWidget);
    await tapText(tester, 'Send screenshot');
    // Shown big first: nothing goes before Send.
    expect(find.text('Is this the Full Time screen?'), findsOneWidget);
    expect(api.requests.where((r) => r.method == 'PUT'), isEmpty);
    await tester.tap(find.widgetWithText(FilledButton, 'Send'));
    await tester.pumpAndSettle();
    await scrollToTop(tester);

    expect(find.text("Waiting for Amina Otieno's screenshots"), findsOneWidget);
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

  testWidgets('the screenshot can be swapped or dropped before it is sent', (
    tester,
  ) async {
    var picks = 0;
    final api = await openRoom(
      tester,
      room: matchRoomJson(
        lifecycle: 'screenshot_required',
        submitted: submittedJson(1, 2),
      ),
      picker: () async {
        picks++;
        return pngBytes;
      },
    );

    await tapText(tester, 'Send screenshot');
    await tester.tap(find.widgetWithText(OutlinedButton, 'Pick another'));
    await tester.pumpAndSettle();
    // The gallery opens again, then the new one is shown.
    expect(picks, 2);
    expect(find.text('Is this the Full Time screen?'), findsOneWidget);

    // Closing the preview sends nothing.
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(find.text('Is this the Full Time screen?'), findsNothing);
    expect(
      api.requests.where((r) => r.url.path.startsWith('/v1/evidence')),
      isEmpty,
    );
  });

  testWidgets('a camera photo is turned away before anything is sent', (
    tester,
  ) async {
    // How an iPhone saves a camera photo: HEIC, in an ISO file box.
    final heic = Uint8List.fromList([
      0,
      0,
      0,
      24,
      ...'ftypheic'.codeUnits,
      0,
      0,
      0,
      0,
      ...'mif1'.codeUnits,
    ]);
    final api = await openRoom(
      tester,
      room: matchRoomJson(
        lifecycle: 'screenshot_required',
        submitted: submittedJson(1, 2),
      ),
      picker: () async => heic,
    );

    await tapText(tester, 'Send screenshot');

    expect(
      find.text('Send the screenshot, not a photo of the screen.'),
      findsOneWidget,
    );
    expect(find.text('Is this the Full Time screen?'), findsNothing);
    expect(
      api.requests.where((r) => r.url.path.startsWith('/v1/evidence')),
      isEmpty,
    );
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
    expect(find.text('Waiting for Amina Otieno to check in'), findsOneWidget);
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
