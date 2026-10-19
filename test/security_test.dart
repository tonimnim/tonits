import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tonits/app/shell/tonits_navigation_bar.dart';

import 'support/fakes.dart';
import 'support/harness.dart';
import 'support/match_room_helpers.dart';

Map<String, dynamic> _session(
  String id,
  String name, {
  bool current = false,
  Duration ago = const Duration(hours: 2),
  bool revoked = false,
}) => {
  'id': id,
  'deviceName': name,
  'userAgent': 'Dart/3.13 (dart:io)',
  'createdIp': '',
  'lastUsedIp': '',
  'createdAt': testNow.subtract(const Duration(days: 9)).toIso8601String(),
  'lastUsedAt': testNow.subtract(ago).toIso8601String(),
  'revokedAt': revoked ? testNow.toIso8601String() : null,
  'current': current,
};

Map<String, dynamic> _deletion({required Duration until}) => {
  'id': 'del1',
  'status': 'pending',
  'requestedAt': testNow.toIso8601String(),
  'executeAfter': testNow.add(until).toIso8601String(),
  'cancelledAt': null,
  'completedAt': null,
};

Future<void> _openProfileRow(WidgetTester tester, String row) async {
  await tester.tap(
    find.descendant(
      of: find.byType(TonitsNavigationBar),
      matching: find.text('Profile'),
    ),
  );
  await tester.pumpAndSettle();
  await tapText(tester, row);
}

/// The deletion endpoints over a request that's [initial], with the wait
/// ending [waitLeft] after the request.
FakeApi _deletionApi({
  Map<String, dynamic>? initial,
  Duration waitLeft = const Duration(hours: 24),
  http.Response Function()? execute,
}) {
  var request = initial;
  return FakeApi(
    routes: {
      '/v1/me/account-deletion': (r) {
        switch (r.method) {
          case 'POST':
            request = _deletion(until: waitLeft);
            return jsonResponse(request!, 202);
          case 'DELETE':
            request = null;
            return http.Response('', 204);
        }
        return jsonResponse({'data': request}, 200);
      },
      '/v1/me/account-deletion/execute': (_) =>
          execute?.call() ?? http.Response('', 204),
    },
  );
}

void main() {
  testWidgets('another device can be signed out; this one is marked', (
    tester,
  ) async {
    var sessions = [
      _session('s-old', 'Ozone on android', ago: const Duration(days: 3)),
      _session('s-me', 'Ozone on iOS', current: true, ago: Duration.zero),
      _session('s-gone', 'Ozone on android', revoked: true),
    ];
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/me/sessions': (_) => jsonResponse({'data': sessions}, 200),
          '/v1/me/sessions/s-old': (_) {
            sessions = [sessions[1]];
            return http.Response('', 204);
          },
        },
      ),
    );
    await _openProfileRow(tester, 'Signed-in devices');

    // This device first, then the other active one; signed-out ones never.
    // Early builds sent the platform in lower case.
    expect(find.text('This device'), findsOneWidget);
    expect(
      tester.getTopLeft(find.text('Ozone on iOS')).dy,
      lessThan(tester.getTopLeft(find.text('Ozone on Android')).dy),
    );
    expect(find.text('Ozone on Android'), findsOneWidget);
    expect(find.text('Sign out'), findsOneWidget);

    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();
    expect(find.text('Sign out Ozone on Android?'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Sign out').last);
    await tester.pumpAndSettle();

    expect(
      api.requests.where(
        (r) => r.method == 'DELETE' && r.url.path == '/v1/me/sessions/s-old',
      ),
      hasLength(1),
    );
    expect(find.text('Signed out Ozone on Android'), findsOneWidget);
    expect(find.text('Ozone on Android'), findsNothing);
  });

  testWidgets('deleting starts a 24-hour wait that can be cancelled', (
    tester,
  ) async {
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: _deletionApi(),
    );
    await _openProfileRow(tester, 'Delete account');

    await tapText(tester, 'Request deletion');
    expect(find.text('Delete your account?'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Request deletion'));
    await tester.pumpAndSettle();

    expect(
      api.requests.where(
        (r) => r.method == 'POST' && r.url.path == '/v1/me/account-deletion',
      ),
      hasLength(1),
    );
    expect(find.text('You can delete it from'), findsOneWidget);
    // Nothing can be deleted for good yet.
    expect(find.text('DELETE'), findsNothing);

    await tapText(tester, 'Cancel request');
    expect(find.text('Deletion cancelled'), findsOneWidget);
    expect(find.text('Request deletion'), findsOneWidget);
  });

  testWidgets('after the wait, typing DELETE deletes the account and signs '
      'out', (tester) async {
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: _deletionApi(initial: _deletion(until: const Duration(hours: -1))),
    );
    await _openProfileRow(tester, 'Delete account');

    final delete = find.widgetWithText(FilledButton, 'Delete account');
    expect(tester.widget<FilledButton>(delete).onPressed, isNull);
    await tester.enterText(find.byType(TextField), 'delete');
    await tester.pump();
    // Exactly DELETE, as the API asks; a lower-case word isn't enough.
    expect(tester.widget<FilledButton>(delete).onPressed, isNull);
    await tester.enterText(find.byType(TextField), 'DELETE');
    await tester.pump();
    await tester.tap(delete);
    await tester.pumpAndSettle();

    final executed = api.requests.singleWhere(
      (r) => r.url.path == '/v1/me/account-deletion/execute',
    );
    expect(jsonDecode(executed.body), {
      'requestId': 'del1',
      'confirmation': 'DELETE',
    });
    expect(find.byType(TonitsNavigationBar), findsNothing);
    expect(find.text('Your game, ranked.'), findsOneWidget);
  });

  testWidgets('a refused deletion says why and keeps the player in', (
    tester,
  ) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: _deletionApi(
        initial: _deletion(until: const Duration(hours: -1)),
        execute: () => errorResponse(
          409,
          'active_competition_blocks_deletion',
          message:
              'Withdraw from or finish active competitions before deleting '
              'this account.',
        ),
      ),
    );
    await _openProfileRow(tester, 'Delete account');
    await tester.enterText(find.byType(TextField), 'DELETE');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Delete account'));
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Withdraw from or finish active competitions before deleting this '
        'account.',
      ),
      findsOneWidget,
    );
    expect(find.widgetWithText(AppBar, 'Delete account'), findsOneWidget);
  });
}
