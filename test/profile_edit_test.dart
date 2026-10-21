import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'support/fakes.dart';
import 'support/harness.dart';
import 'support/match_room_helpers.dart';

/// A signed-in player with [profile], whose saves come back applied.
FakeApi _api(
  Map<String, dynamic> profile, {
  http.Response Function(Map<String, dynamic> body)? onSave,
}) {
  var current = profile;
  return FakeApi(
    routes: {
      '/v1/auth/refresh': (_) =>
          jsonResponse(sessionJson(player: playerJson(profile: current)), 200),
      '/v1/usernames/striker.10/availability': (_) =>
          jsonResponse({'username': 'striker.10', 'available': true}, 200),
      '/v1/me/profile': (request) {
        final body = jsonDecode(request.body) as Map<String, dynamic>;
        final answer = onSave?.call(body);
        if (answer != null) return answer;
        current = body;
        return jsonResponse(playerJson(profile: current), 200);
      },
    },
  );
}

Map<String, dynamic> _saved(FakeApi api) => jsonDecode(
  api.requests.lastWhere((r) => r.url.path == '/v1/me/profile').body,
) as Map<String, dynamic>;

void main() {
  testWidgets('a new username is checked, saved and shown', (tester) async {
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: _api(profileSettingsJson()),
    );
    await openProfileFromHome(tester);
    expect(find.text('@striker.9'), findsOneWidget);

    await tapText(tester, 'Username');
    await tester.enterText(find.byType(TextFormField), 'striker.10');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(find.text('Available'), findsOneWidget);
    await tapText(tester, 'Save');

    // The whole profile goes back, consents unchanged; nothing else, as the
    // API refuses unknown fields.
    expect(_saved(api), {
      'handle': 'striker.10',
      'analyticsConsent': true,
      'scoutingConsent': false,
    });
    expect(find.text('Username updated'), findsOneWidget);
    expect(find.text('@striker.10'), findsOneWidget);
  });

  testWidgets('a taken username says so and stays open', (tester) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: _api(
        profileSettingsJson(),
        onSave: (_) => errorResponse(409, 'handle_taken'),
      ),
    );
    await openProfileFromHome(tester);
    await tapText(tester, 'Username');
    await tester.enterText(find.byType(TextFormField), 'striker.10');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    await tapText(tester, 'Save');

    expect(find.text('That username is taken. Try another.'), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Username'), findsOneWidget);
  });
}
