import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tonits/app/shell/tonits_navigation_bar.dart';
import 'package:tonits/features/evidence/application/evidence_providers.dart';
import 'package:tonits/features/matches/application/matches_providers.dart';

import 'fakes.dart';
import 'harness.dart';

/// Helpers for tests that open a match room.

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

/// Jumps the page back to the top. A drag would pull to refresh, and the
/// fake API would answer with the room as it started.
Future<void> scrollToTop(WidgetTester tester) async {
  tester
      .state<ScrollableState>(find.byType(Scrollable).first)
      .position
      .jumpTo(0);
  await tester.pumpAndSettle();
}

/// A score stepper's button, by its tooltip.
Finder stepper(String tooltip) =>
    find.byWidgetPredicate((w) => w is Tooltip && w.message == tooltip);

/// Taps [finder] [times] times, a frame apart as a player would.
Future<void> tapTimes(WidgetTester tester, Finder finder, int times) async {
  await centre(tester, finder);
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

/// Routes for uploading screenshots: each upload is accepted, verified on
/// the second check, and comes back as evidence `ev1`.
Map<String, http.Response Function(http.Request)> evidenceRoutes() {
  var checks = 0;
  return {
    '/v1/evidence/uploads': (_) => jsonResponse({
      'data': {
        'id': 'ev1',
        'uploadUrl': 'https://storage.test/evidence/ev1',
        'requiredHeaders': {'Content-Type': 'image/png', 'If-None-Match': '*'},
        'expiresAt': testNow.toIso8601String(),
      },
    }, 201),
    '/evidence/ev1': (_) => http.Response('', 200),
    '/v1/evidence/uploads/ev1/complete': (_) =>
        jsonResponse({'data': evidenceJson(ready: false)}, 200),
    '/v1/evidence/uploads/ev1': (_) =>
        jsonResponse({'data': evidenceJson(ready: ++checks % 2 == 0)}, 200),
  };
}

/// Scrolls [finder] to the middle of the screen, clear of the bars.
Future<void> centre(WidgetTester tester, Finder finder) async {
  await Scrollable.ensureVisible(tester.element(finder), alignment: 0.5);
  await tester.pumpAndSettle();
}

/// Taps [finder] after bringing it into view.
Future<void> tapFound(WidgetTester tester, Finder finder) async {
  await centre(tester, finder);
  await tester.tap(finder);
  await tester.pumpAndSettle();
}
