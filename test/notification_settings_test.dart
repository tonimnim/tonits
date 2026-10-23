import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'support/fakes.dart';
import 'support/harness.dart';
import 'support/match_room_helpers.dart';

Map<String, dynamic> _prefs({bool matchPush = true}) => {
  'competitionPush': true,
  'matchPush': matchPush,
  'resultPush': true,
  'competitionEmail': true,
  'matchEmail': true,
  'marketingEmail': false,
  'updatedAt': testNow.toIso8601String(),
};

Future<FakeApi> _open(
  WidgetTester tester, {
  http.Response Function(http.Request)? onPatch,
}) async {
  var current = _prefs();
  final api = await pumpTonits(
    tester,
    refreshToken: 'stored',
    api: FakeApi(
      routes: {
        '/v1/me/notification-preferences': (request) {
          if (request.method == 'PATCH') {
            final answer = onPatch?.call(request);
            if (answer != null) return answer;
            current = {
              ...current,
              ...jsonDecode(request.body) as Map<String, dynamic>,
            };
          }
          return jsonResponse(current, 200);
        },
      },
    ),
  );
  await openProfileFromHome(tester);
  await tapText(tester, 'Notifications');
  return api;
}

Switch _switchFor(WidgetTester tester, String label) => tester.widget<Switch>(
  find.descendant(
    of: find.ancestor(of: find.text(label), matching: find.byType(InkWell)),
    matching: find.byType(Switch),
  ),
);

void main() {
  testWidgets('a switch saves just its channel', (tester) async {
    final api = await _open(tester);
    expect(_switchFor(tester, 'Matches and chat').value, isTrue);
    expect(_switchFor(tester, 'News and offers').value, isFalse);

    await tester.tap(find.text('Matches and chat'));
    await tester.pumpAndSettle();

    final patch = api.requests.singleWhere((r) => r.method == 'PATCH');
    expect(jsonDecode(patch.body), {'matchPush': false});
    expect(_switchFor(tester, 'Matches and chat').value, isFalse);
  });

  testWidgets('a switch that fails to save goes back and says why', (
    tester,
  ) async {
    await _open(
      tester,
      onPatch: (_) => errorResponse(503, 'database_unavailable'),
    );
    await tester.tap(find.text('Results'));
    await tester.pumpAndSettle();

    expect(_switchFor(tester, 'Results').value, isTrue);
    expect(
      find.text('Ozone is having trouble right now. Try again shortly.'),
      findsOneWidget,
    );
  });
}
