import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tonits/app/shell/tonits_navigation_bar.dart';

import 'support/fakes.dart';
import 'support/harness.dart';

Future<void> tapText(WidgetTester tester, String text) async {
  await tester.ensureVisible(find.text(text).last);
  await tester.pumpAndSettle();
  await tester.tap(find.text(text).last);
  await tester.pumpAndSettle();
}

/// Signs a new player in with Google, which lands on onboarding.
Future<FakeApi> startOnboarding(
  WidgetTester tester, {
  http.Response Function(http.Request)? onboarding,
}) async {
  final api = FakeApi(
    routes: {
      '/v1/auth/google': (_) =>
          jsonResponse(sessionJson(onboarded: false), 201),
      '/v1/me/onboarding': ?onboarding,
    },
  );
  await pumpTonits(tester, api: api);
  await tapText(tester, 'Continue with Google');
  return api;
}

void main() {
  testWidgets('a new player picks a username, links eFootball, then adds '
      'their country and phone', (tester) async {
    final api = await startOnboarding(tester);

    expect(find.text('Pick your username'), findsOneWidget);
    // The generated handle is the starting point.
    expect(find.text(newPlayerHandle), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'striker.9');
    await tapText(tester, 'Continue');

    expect(find.text('Link eFootball'), findsOneWidget);
    expect(find.text('Step 2 of 4'), findsOneWidget);
    await tapText(tester, 'Continue');
    expect(
      find.text('Enter your Konami ID'),
      findsOneWidget,
      reason: 'each step is checked before the next',
    );
    await tester.enterText(find.byType(TextFormField), 'ABCD-1234-EFGH');
    await tapText(tester, 'Continue');

    // The device's country (the test locale's) is suggested.
    expect(find.text('Where do you play from?'), findsOneWidget);
    expect(find.text('United States'), findsOneWidget);
    await tapText(tester, 'Continue');

    expect(find.text('Your phone number'), findsOneWidget);
    expect(find.text('+1'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), '(512) 555-0134');
    await tapText(tester, 'Finish');

    expect(find.byType(TonitsNavigationBar), findsOneWidget);
    final sent = api.requests.singleWhere(
      (r) => r.url.path == '/v1/me/onboarding',
    );
    expect(jsonDecode(sent.body), {
      'username': 'striker.9',
      'konamiId': 'ABCD-1234-EFGH',
      'phoneNumber': '+15125550134',
      'countryCode': 'US',
    });
  });

  testWidgets('back goes to the previous step, keeping what was typed', (
    tester,
  ) async {
    await startOnboarding(tester);
    await tapText(tester, 'Continue');
    await tester.enterText(find.byType(TextFormField), 'ABCD-1234-EFGH');

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.text('Pick your username'), findsOneWidget);
    await tapText(tester, 'Continue');
    final field = tester.widget<TextFormField>(find.byType(TextFormField));
    expect(field.controller!.text, 'ABCD-1234-EFGH');
  });

  testWidgets('a taken Konami ID sends the player back to that step', (
    tester,
  ) async {
    final api = await startOnboarding(
      tester,
      onboarding: (_) => errorResponse(409, 'konami_id_taken'),
    );
    await tapText(tester, 'Continue');
    await tester.enterText(find.byType(TextFormField), 'ABCD-1234-EFGH');
    await tapText(tester, 'Continue');
    await tapText(tester, 'Continue');
    await tester.enterText(find.byType(TextFormField), '(512) 555-0134');
    await tapText(tester, 'Finish');

    expect(find.text('Link eFootball'), findsOneWidget);
    expect(
      find.text(
        "That Konami ID is linked to another Ozone account. Contact Ozone "
        "support if it's yours.",
      ),
      findsOneWidget,
    );
    // An unchanged generated handle isn't sent.
    final sent = api.requests.singleWhere(
      (r) => r.url.path == '/v1/me/onboarding',
    );
    expect(jsonDecode(sent.body), isNot(contains('username')));
  });
}
