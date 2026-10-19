import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tonits/app/shell/tonits_navigation_bar.dart';

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

Future<void> _openProfile(WidgetTester tester) async {
  await tester.tap(
    find.descendant(
      of: find.byType(TonitsNavigationBar),
      matching: find.text('Profile'),
    ),
  );
  await tester.pumpAndSettle();
}

Map<String, dynamic> _saved(FakeApi api) => jsonDecode(
  api.requests.lastWhere((r) => r.url.path == '/v1/me/profile').body,
) as Map<String, dynamic>;

void main() {
  testWidgets('a new username is checked, saved and shown', (tester) async {
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: _api(profileSettingsJson(bio: 'Left foot only.')),
    );
    await _openProfile(tester);
    expect(find.text('@striker.9'), findsOneWidget);

    await tapText(tester, 'Username');
    await tester.enterText(find.byType(TextFormField), 'striker.10');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(find.text('Available'), findsOneWidget);
    await tapText(tester, 'Save');

    // The whole profile goes back, consents unchanged.
    expect(_saved(api), {
      'handle': 'striker.10',
      'bio': 'Left foot only.',
      'discoverable': true,
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
    await _openProfile(tester);
    await tapText(tester, 'Username');
    await tester.enterText(find.byType(TextFormField), 'striker.10');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    await tapText(tester, 'Save');

    expect(find.text('That username is taken. Try another.'), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Username'), findsOneWidget);
  });

  testWidgets('a bio is saved and shown', (tester) async {
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: _api(profileSettingsJson()),
    );
    await _openProfile(tester);
    await tapText(tester, 'Bio');
    await tester.enterText(
      find.byType(TextField),
      '  Nairobi. Weekends only.  ',
    );
    await tapText(tester, 'Save');

    expect(_saved(api)['bio'], 'Nairobi. Weekends only.');
    expect(find.text('Bio updated'), findsOneWidget);
    expect(find.text('Nairobi. Weekends only.'), findsOneWidget);
  });

  testWidgets('switching the profile off hides it at once', (tester) async {
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: _api(profileSettingsJson()),
    );
    await _openProfile(tester);
    await scrollPageTo(tester, find.text('Public profile'));
    expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(_saved(api)['discoverable'], isFalse);
    expect(_saved(api)['handle'], 'striker.9');
    expect(find.text('Your profile is hidden'), findsOneWidget);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);
  });

  testWidgets('a failed switch goes back and says why', (tester) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: _api(
        profileSettingsJson(),
        onSave: (_) => errorResponse(503, 'database_unavailable'),
      ),
    );
    await _openProfile(tester);
    await scrollPageTo(tester, find.text('Public profile'));
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);
    expect(
      find.text('Ozone is having trouble right now. Try again shortly.'),
      findsOneWidget,
    );
  });
}
