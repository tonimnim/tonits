import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/app/shell/tonits_navigation_bar.dart';

import 'support/fakes.dart';
import 'support/harness.dart';

Future<void> signIn(WidgetTester tester) async {
  await tester.enterText(
    find.widgetWithText(TextFormField, 'ABCD-1234-EFGH'),
    'ABCD-1234-EFGH',
  );
  await tester.enterText(
    find.widgetWithText(TextFormField, 'Your password'),
    'correct horse',
  );
  await tester.ensureVisible(find.text('Sign in'));
  await tester.tap(find.text('Sign in'));
  await tester.pumpAndSettle();
}

Future<void> openTab(WidgetTester tester, String label) async {
  await tester.tap(
    find.descendant(
      of: find.byType(TonitsNavigationBar),
      matching: find.text(label),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('without a session the app opens on sign in', (tester) async {
    await pumpTonits(tester);

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.byType(TonitsNavigationBar), findsNothing);
  });

  testWidgets('wrong credentials show a message', (tester) async {
    await pumpTonits(
      tester,
      api: FakeApi(
        routes: {
          '/v1/auth/login': (_) => errorResponse(401, 'invalid_credentials'),
        },
      ),
    );

    await signIn(tester);

    expect(
      find.text("That Konami ID and password don't match."),
      findsOneWidget,
    );
  });

  testWidgets('signing in opens Home with the next match and open '
      'competitions', (tester) async {
    await pumpTonits(tester);
    await signIn(tester);

    expect(find.byType(TonitsNavigationBar), findsOneWidget);
    expect(find.text('striker.9'), findsWidgets);
    expect(find.text('1,542'), findsOneWidget);
    expect(find.text('#24'), findsOneWidget);
    expect(find.text('Up next'), findsOneWidget);
    expect(find.text('vs Amina Otieno'), findsOneWidget);

    await scrollPageTo(tester, find.text('62%'));
    expect(find.text('W3'), findsOneWidget);
    await scrollPageTo(tester, find.text('Kenya ladder'));
    await scrollPageTo(tester, find.text('Recent matches'));
    await scrollPageTo(tester, find.text('Closing soon'));
    expect(find.text('Mombasa Masters'), findsOneWidget);
  });

  testWidgets('a stored session resumes straight to Home', (tester) async {
    await pumpTonits(tester, refreshToken: 'stored');

    expect(find.text('1,542'), findsOneWidget);
  });

  testWidgets('without a match, Up next leaves the page', (tester) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {'/v1/me/matches': (_) => jsonResponse(pageJson([]), 200)},
      ),
    );

    expect(find.text('1,542'), findsOneWidget);
    expect(find.text('Up next'), findsNothing);
  });

  testWidgets('a new player is invited to play instead of shown empty '
      'stats', (tester) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/players/$myPlayerId': (_) => jsonResponse(
            profileJson(wins: 0, draws: 0, losses: 0, rated: false),
            200,
          ),
          '/v1/players/$myPlayerId/matches': (_) =>
              jsonResponse(pageJson([]), 200),
          '/v1/me/matches': (_) => jsonResponse(pageJson([]), 200),
        },
      ),
    );

    expect(find.text('Unranked'), findsOneWidget);
    expect(find.text('Overview'), findsNothing);
    await scrollPageTo(tester, find.text('Top in Kenya'));
    expect(find.text('striker.9 (you)'), findsNothing);
    expect(find.text('Recent matches'), findsNothing);

    await tester.ensureVisible(find.text('Find a competition'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Find a competition'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Competitions'), findsOneWidget);
  });

  testWidgets('without rating history the card leaves out the trend', (
    tester,
  ) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/players/$myPlayerId/rating-history': (_) =>
              errorResponse(404, 'not_found'),
        },
      ),
    );

    expect(find.text('1,542'), findsOneWidget);
    expect(find.text('Last 30 days'), findsNothing);
  });

  testWidgets('a failing section offers a retry and the rest still loads', (
    tester,
  ) async {
    var fail = true;
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/competitions': (_) => fail
              ? errorResponse(503, 'database_unavailable')
              : jsonResponse(pageJson([competitionJson()]), 200),
        },
      ),
    );

    expect(find.text('1,542'), findsOneWidget);
    await scrollPageTo(tester, find.text("Couldn't load this"));

    fail = false;
    await tester.ensureVisible(find.text('Try again'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();
    expect(find.text("Couldn't load this"), findsNothing);
    expect(find.text('Nairobi Weekend Cup'), findsOneWidget);
  });

  testWidgets('the bottom bar switches between all five tabs', (tester) async {
    await pumpTonits(tester, refreshToken: 'stored');

    await openTab(tester, 'Compete');
    expect(find.widgetWithText(AppBar, 'Competitions'), findsOneWidget);
    expect(find.text('Mombasa Masters'), findsOneWidget);
    expect(find.text('Ksh 100 entry'), findsOneWidget);

    await openTab(tester, 'Matches');
    expect(find.widgetWithText(AppBar, 'Matches'), findsOneWidget);
    expect(find.text('vs Amina Otieno'), findsOneWidget);
    await tester.tap(find.text('History'));
    await tester.pumpAndSettle();
    expect(find.text('Won'), findsOneWidget);

    await openTab(tester, 'Rankings');
    expect(find.text('Lake Striker'), findsOneWidget);
    expect(find.text('striker.9 (you)'), findsOneWidget);

    await openTab(tester, 'Profile');
    expect(find.text('Konami ID'), findsOneWidget);
    expect(find.text('ABCD-1234-EFGH'), findsOneWidget);

    await openTab(tester, 'Home');
    expect(find.text('1,542'), findsOneWidget);
  });

  testWidgets('signing out from Profile returns to sign in', (tester) async {
    await pumpTonits(tester, refreshToken: 'stored');
    await openTab(tester, 'Profile');

    await tester.ensureVisible(find.text('Sign out'));
    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();
    expect(find.text('Sign out of Tonits?'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Sign out'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.byType(TonitsNavigationBar), findsNothing);
  });
}
