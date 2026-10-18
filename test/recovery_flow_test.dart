import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/app/shell/tonits_navigation_bar.dart';

import 'support/fakes.dart';
import 'support/harness.dart';

Future<void> enter(WidgetTester tester, String hint, String text) =>
    tester.enterText(find.widgetWithText(TextFormField, hint), text);

Future<void> tapText(WidgetTester tester, String text) async {
  await tester.ensureVisible(find.text(text).last);
  await tester.pumpAndSettle();
  await tester.tap(find.text(text).last);
  await tester.pumpAndSettle();
}

/// Confirms the code is saved and continues, as a player would.
Future<void> saveCodeAndContinue(WidgetTester tester) async {
  await tapText(tester, "I've saved my recovery code");
  await tapText(tester, 'Continue');
}

void main() {
  testWidgets('sign-up shows the recovery code before Home', (tester) async {
    await pumpTonits(tester);
    await tapText(tester, 'Create an account');

    await enter(tester, 'striker.9', 'striker.9');
    await enter(tester, 'ABCD-1234-EFGH', 'ABCD-1234-EFGH');
    await enter(tester, 'Choose a password', 'correct horse');
    await tapText(tester, 'Create account');

    expect(find.text('Save your recovery code'), findsOneWidget);
    expect(find.text(firstRecoveryCode), findsOneWidget);
    expect(find.byType(TonitsNavigationBar), findsNothing);

    // Continuing needs the player to confirm they saved it.
    await tapText(tester, 'Continue');
    expect(
      find.text("Tick the box once you've saved your code."),
      findsOneWidget,
    );
    expect(find.text('Save your recovery code'), findsOneWidget);

    await saveCodeAndContinue(tester);
    expect(find.byType(TonitsNavigationBar), findsOneWidget);
    expect(find.text('1,542'), findsOneWidget);
  });

  testWidgets('a forgotten password resets with the recovery code', (
    tester,
  ) async {
    final api = await pumpTonits(tester);
    await tapText(tester, 'Forgot password?');

    // The recovery code is the default way in.
    expect(
      find.text('Use the recovery code you saved when you signed up.'),
      findsOneWidget,
    );
    await enter(tester, 'ABCD-1234-EFGH', 'ABCD-1234-EFGH');
    await enter(tester, 'XXXX-XXXX-XXXX-XXXX-XXXX', '7kq0 1xrp 9tvd 4hnw c3ja');
    expect(find.text('7KQ0-1XRP-9TVD-4HNW-C3JA'), findsOneWidget);
    await enter(tester, 'Choose a new password', 'brand new pass');
    await tapText(tester, 'Set new password');

    final reset = api.requests.singleWhere(
      (r) => r.url.path == '/v1/auth/password-reset/recovery-code',
    );
    expect(reset.body, contains('7KQ0-1XRP-9TVD-4HNW-C3JA'));

    // Signed straight in, but first shown the code that replaces the old one.
    expect(find.text('Save your new recovery code'), findsOneWidget);
    expect(find.text(nextRecoveryCode), findsOneWidget);
    await saveCodeAndContinue(tester);
    expect(find.byType(TonitsNavigationBar), findsOneWidget);
  });

  testWidgets('a wrong recovery code says so and stays on the form', (
    tester,
  ) async {
    await pumpTonits(
      tester,
      api: FakeApi(
        routes: {
          '/v1/auth/password-reset/recovery-code': (_) =>
              errorResponse(401, 'invalid_recovery_code'),
        },
      ),
    );
    await tapText(tester, 'Forgot password?');
    await enter(tester, 'ABCD-1234-EFGH', 'ABCD-1234-EFGH');
    await enter(tester, 'XXXX-XXXX-XXXX-XXXX-XXXX', firstRecoveryCode);
    await enter(tester, 'Choose a new password', 'brand new pass');
    await tapText(tester, 'Set new password');

    expect(
      find.text("That Konami ID and recovery code don't match."),
      findsOneWidget,
    );
    expect(find.text('Reset password'), findsOneWidget);
  });

  testWidgets('the email route still works from the same screen', (
    tester,
  ) async {
    await pumpTonits(
      tester,
      api: FakeApi(
        routes: {
          '/v1/auth/password-reset/request': (_) => jsonResponse({
            'status': 'accepted',
            'expiresInSeconds': 600,
          }, 202),
        },
      ),
    );
    await tapText(tester, 'Forgot password?');
    await tapText(tester, 'Email');
    await enter(tester, 'ABCD-1234-EFGH', 'ABCD-1234-EFGH');
    await tapText(tester, 'Send code');

    expect(find.widgetWithText(TextFormField, '000000'), findsOneWidget);
  });

  testWidgets('Profile prompts a player who could not recover their account, '
      'then issues a code', (tester) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/auth/refresh': (_) =>
              jsonResponse(sessionJson(recoveryCodeSet: false), 200),
        },
      ),
    );
    await tester.tap(
      find.descendant(
        of: find.byType(TonitsNavigationBar),
        matching: find.text('Profile'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text("You can't recover your account yet"), findsOneWidget);
    await scrollPageTo(tester, find.text('Not set'));

    await tapText(tester, 'Create a recovery code');
    await enter(tester, 'Your password', 'correct horse');
    await tapText(tester, 'Continue');

    expect(find.text('Save your recovery code'), findsOneWidget);
    expect(find.text(nextRecoveryCode), findsOneWidget);
    await saveCodeAndContinue(tester);

    // Back on Profile, now covered.
    expect(find.text("You can't recover your account yet"), findsNothing);
    await scrollPageTo(tester, find.text('Set'));
  });

  testWidgets('a wrong password when getting a new code says so', (
    tester,
  ) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/me/recovery-code': (_) =>
              errorResponse(401, 'invalid_credentials'),
        },
      ),
    );
    await tester.tap(
      find.descendant(
        of: find.byType(TonitsNavigationBar),
        matching: find.text('Profile'),
      ),
    );
    await tester.pumpAndSettle();

    await tapText(tester, 'New code');
    expect(
      find.text(
        'Your current code will stop working. Confirm your '
        'password to continue.',
      ),
      findsOneWidget,
    );
    await enter(tester, 'Your password', 'wrong one');
    await tapText(tester, 'Continue');

    expect(find.text("That password isn't right."), findsOneWidget);
  });
}
