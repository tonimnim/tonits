import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:tonits/app.dart';
import 'package:tonits/core/api/api_client.dart';
import 'package:tonits/features/auth/auth_controller.dart';
import 'package:tonits/features/auth/auth_repository.dart';

import 'fakes.dart';

void main() {
  AuthController authWith(MockClient client) {
    final api = ApiClient(baseUrl: 'http://api.test', httpClient: client);
    return AuthController(
      api: api,
      repository: AuthRepository(api),
      tokenStore: MemoryTokenStore(),
    );
  }

  testWidgets('wrong credentials show a message', (tester) async {
    final auth = authWith(
      MockClient((_) async => errorResponse(401, 'invalid_credentials')),
    );
    await tester.pumpWidget(TonitsApp(auth: auth, brandFonts: false));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Konami ID'),
      'ABCD-1234-EFGH',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'wrong password',
    );
    await tester.tap(find.text('SIGN IN'));
    await tester.pumpAndSettle();

    expect(
      find.text("That Konami ID and password don't match."),
      findsOneWidget,
    );
  });

  testWidgets('a correct sign-in opens the home screen', (tester) async {
    final auth = authWith(
      MockClient((_) async => jsonResponse(sessionJson(), 200)),
    );
    await tester.pumpWidget(TonitsApp(auth: auth, brandFonts: false));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Konami ID'),
      'ABCD-1234-EFGH',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'correct horse',
    );
    await tester.tap(find.text('SIGN IN'));
    await tester.pumpAndSettle();

    expect(find.text('WELCOME,\nSTRIKER.9'), findsOneWidget);
  });
}
