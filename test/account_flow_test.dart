import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tonits/app/shell/tonits_navigation_bar.dart';

import 'support/fakes.dart';
import 'support/harness.dart';

Future<void> openProfile(WidgetTester tester, {FakeApi? api}) async {
  await pumpTonits(tester, refreshToken: 'stored', api: api);
  await tester.tap(
    find.descendant(
      of: find.byType(TonitsNavigationBar),
      matching: find.text('Profile'),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> tapText(WidgetTester tester, String text) async {
  if (find.text(text).evaluate().isEmpty) {
    await scrollPageTo(tester, find.text(text));
  }
  // Bring it clear of the bottom bar, not just partly into view.
  await tester.ensureVisible(find.text(text).last);
  await tester.pumpAndSettle();
  await tester.tap(find.text(text).last);
  await tester.pumpAndSettle();
}

Future<void> enter(WidgetTester tester, String hint, String text) =>
    tester.enterText(find.widgetWithText(TextFormField, hint), text);

Map<String, dynamic> bodyOf(http.Request request) =>
    jsonDecode(request.body) as Map<String, dynamic>;

/// GET /v1/me as usual; PATCH answers with the change applied.
http.Response Function(http.Request) me(
  Map<String, dynamic> Function(Map<String, dynamic> body) patched,
) =>
    (request) => request.method == 'PATCH'
    ? jsonResponse(patched(bodyOf(request)), 200)
    : jsonResponse(playerJson(), 200);

void main() {
  testWidgets('a new display name shows at once', (tester) async {
    final api = FakeApi(
      routes: {
        '/v1/me': me(
          (body) => playerJson(displayName: body['displayName'] as String),
        ),
      },
    );
    await openProfile(tester, api: api);

    await tapText(tester, 'Display name');
    await tester.enterText(find.byType(TextFormField), 'Lake Striker');
    await tapText(tester, 'Save');

    expect(find.text('Display name updated'), findsOneWidget);
    expect(find.text('Lake Striker'), findsWidgets);
    // The username now shows as the handle, beside the country.
    await tester.drag(find.byType(Scrollable).first, const Offset(0, 1000));
    await tester.pumpAndSettle();
    expect(find.textContaining('@striker.9  ·'), findsOneWidget);
    final patch = api.requests.lastWhere((r) => r.method == 'PATCH');
    expect(bodyOf(patch), {'displayName': 'Lake Striker'});
  });

  testWidgets('changing country asks first, then saves it', (tester) async {
    final api = FakeApi(
      routes: {
        '/v1/me': me(
          (body) => playerJson(countryCode: body['countryCode'] as String),
        ),
      },
    );
    await openProfile(tester, api: api);

    await tapText(tester, 'Country');
    await tester.enterText(find.byType(TextField).last, 'India');
    await tester.pumpAndSettle();
    await tester.tap(find.text('India').last);
    await tester.pumpAndSettle();
    expect(find.text('Change your country to India?'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Change'));
    await tester.pumpAndSettle();

    expect(find.text('Country changed to India'), findsOneWidget);
    final patch = api.requests.lastWhere((r) => r.method == 'PATCH');
    expect(bodyOf(patch), {'countryCode': 'IN'});
  });

  testWidgets('an email is verified with the code sent to it', (tester) async {
    final api = FakeApi(
      routes: {
        '/v1/me/email': (_) => jsonResponse({'expiresInSeconds': 600}, 202),
        '/v1/me/email/verify': (request) => bodyOf(request)['code'] == '123456'
            ? jsonResponse(playerJson(email: 'amina@example.com'), 200)
            : errorResponse(401, 'invalid_code'),
      },
    );
    await openProfile(tester, api: api);
    await tapText(tester, 'Email');
    await enter(tester, 'you@example.com', 'amina@example');
    await tapText(tester, 'Send code');
    expect(find.text('Enter a valid email address'), findsOneWidget);

    await enter(tester, 'you@example.com', 'amina@example.com');
    await tapText(tester, 'Send code');
    expect(
      find.text(
        'We sent a 6-digit code to amina@example.com. It expires in 10 '
        'minutes.',
      ),
      findsOneWidget,
    );

    await enter(tester, '000000', '654321');
    await tapText(tester, 'Verify');
    expect(find.text('That code is wrong or has expired.'), findsOneWidget);

    await enter(tester, '000000', '123456');
    await tapText(tester, 'Verify');
    expect(find.text('Email verified'), findsOneWidget);
    // In Contact, and beside the linked Google account.
    expect(find.text('amina@example.com'), findsWidgets);
  });

  testWidgets("an email on another account isn't accepted", (tester) async {
    await openProfile(
      tester,
      api: FakeApi(
        routes: {'/v1/me/email': (_) => errorResponse(409, 'email_taken')},
      ),
    );
    await tapText(tester, 'Email');
    await enter(tester, 'you@example.com', 'taken@example.com');
    await tapText(tester, 'Send code');

    expect(find.text('That email belongs to another account.'), findsOneWidget);
  });

  testWidgets('an M-Pesa number is saved in international format', (
    tester,
  ) async {
    final api = FakeApi(
      routes: {
        '/v1/me/phone': (request) => jsonResponse(
          playerJson(phoneNumber: bodyOf(request)['phoneNumber'] as String),
          200,
        ),
      },
    );
    await openProfile(tester, api: api);

    await tapText(tester, 'Phone');
    expect(find.text('+254'), findsOneWidget);
    await enter(tester, '0712 345 678', '0712 345 678');
    await tapText(tester, 'Save');

    expect(find.text('Phone number saved'), findsOneWidget);
    final put = api.requests.lastWhere((r) => r.method == 'PUT');
    expect(bodyOf(put), {'phoneNumber': '+254712345678'});
    await scrollPageTo(tester, find.text('+254712345678'));
  });

  testWidgets('a saved phone number can be removed', (tester) async {
    var removed = false;
    final api = FakeApi(
      routes: {
        '/v1/auth/refresh': (_) => jsonResponse(
          sessionJson(player: playerJson(phoneNumber: '+254712345678')),
          200,
        ),
        '/v1/me': (_) => jsonResponse(
          playerJson(phoneNumber: removed ? null : '+254712345678'),
          200,
        ),
        '/v1/me/phone': (_) {
          removed = true;
          return http.Response('', 204);
        },
      },
    );
    await openProfile(tester, api: api);

    await tapText(tester, '+254712345678');
    // Shown the way it's typed at home.
    expect(find.text('0712345678'), findsOneWidget);
    await tapText(tester, 'Remove phone number');
    await tester.tap(find.widgetWithText(TextButton, 'Remove'));
    await tester.pumpAndSettle();

    expect(find.text('Phone number removed'), findsOneWidget);
    expect(api.requests.where((r) => r.method == 'DELETE'), hasLength(1));
  });
}
