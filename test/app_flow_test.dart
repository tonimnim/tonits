import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tonits/app/shell/tonits_navigation_bar.dart';

import 'support/fakes.dart';
import 'support/harness.dart';

Future<void> signIn(WidgetTester tester) async {
  await tester.tap(find.text('Continue with Google'));
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
  testWidgets('without a session the app opens on the welcome screen', (
    tester,
  ) async {
    await pumpTonits(tester);

    expect(find.text('Your game, ranked.'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);
    // Apple is offered on iPhone only.
    expect(find.text('Continue with Apple'), findsNothing);
    expect(find.byType(TonitsNavigationBar), findsNothing);
  });

  testWidgets('a sign-in the server refuses says why', (tester) async {
    await pumpTonits(
      tester,
      api: FakeApi(
        routes: {
          '/v1/auth/google': (_) => errorResponse(503, 'sign_in_unavailable'),
        },
      ),
    );

    await signIn(tester);

    expect(
      find.text("That sign-in option isn't available yet. Try again later."),
      findsOneWidget,
    );
  });

  testWidgets('signing in opens Home with the next match and recent '
      'results', (tester) async {
    await pumpTonits(tester);
    await signIn(tester);

    expect(find.byType(TonitsNavigationBar), findsOneWidget);
    expect(find.text('striker.9'), findsWidgets);
    expect(find.text('1,542'), findsOneWidget);
    expect(find.text('#24'), findsOneWidget);
    expect(find.text('Up next'), findsOneWidget);
    expect(find.text('vs Amina Otieno'), findsWidgets);
    // With a match coming, what's open stays on Compete.
    expect(find.text('Open now'), findsNothing);

    await scrollPageTo(tester, find.text('Recent matches'));
    expect(find.text('vs Coast Ace'), findsOneWidget);
  });

  testWidgets('a stored session resumes straight to Home', (tester) async {
    await pumpTonits(tester, refreshToken: 'stored');

    expect(find.text('1,542'), findsOneWidget);
  });

  testWidgets("without a match, what's open takes Up next's place", (
    tester,
  ) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {'/v1/me/matches': (_) => jsonResponse(pageJson([]), 200)},
      ),
    );

    expect(find.text('1,542'), findsOneWidget);
    expect(find.text('Up next'), findsNothing);
    expect(find.text('Open now'), findsOneWidget);
    expect(find.text('Mombasa Masters'), findsOneWidget);
    expect(find.text('Ksh 8,000'), findsOneWidget);

    await tester.tap(find.text('Nairobi Weekend Cup'));
    await tester.pumpAndSettle();
    expect(find.text('Enter for free'), findsOneWidget);
  });

  testWidgets("what's open leaves out what the player can't enter, and "
      'shows the three closing soonest', (tester) async {
    Map<String, dynamic> closing(String id, String name, String at) => {
      ...competitionJson(id: id, name: name),
      'registrationClosesAt': at,
    };
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/me/matches': (_) => jsonResponse(pageJson([]), 200),
          '/v1/competitions': (_) => jsonResponse(
            pageJson([
              closing('c5', 'Late Cup', '2027-02-01T16:00:00Z'),
              competitionJson(),
              closing('c3', 'Closed Cup', '2020-01-01T16:00:00Z'),
              // Every place taken (the fixture has 32).
              competitionJson(id: 'c4', name: 'Full Cup', entryCount: 32),
              closing('c6', 'Early Cup', '2027-01-10T16:00:00Z'),
              closing('c7', 'Middle Cup', '2027-01-20T16:00:00Z'),
            ]),
            200,
          ),
        },
      ),
    );

    for (final name in ['Closed Cup', 'Full Cup', 'Late Cup']) {
      expect(find.text(name), findsNothing);
    }
    final top = [
      'Early Cup',
      'Nairobi Weekend Cup',
      'Middle Cup',
    ].map((name) => tester.getTopLeft(find.text(name)).dy).toList();
    expect(top[0], lessThan(top[1]));
    expect(top[1], lessThan(top[2]));
  });

  testWidgets('with nothing open, Home says so', (tester) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/me/matches': (_) => jsonResponse(pageJson([]), 200),
          '/v1/competitions': (_) => jsonResponse(pageJson([]), 200),
        },
      ),
    );

    expect(find.text('Open now'), findsOneWidget);
    expect(find.text('Nothing open right now'), findsOneWidget);
  });

  testWidgets("a competition the player is in leaves what's open", (
    tester,
  ) async {
    Map<String, dynamic> entry(String competitionId, String status) => {
      'id': 'r-$competitionId',
      'competitionId': competitionId,
      'status': status,
    };
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/me/matches': (_) => jsonResponse(pageJson([]), 200),
          '/v1/me/registrations': (_) => jsonResponse(
            pageJson([entry('c1', 'registered'), entry('c2', 'withdrawn')]),
            200,
          ),
        },
      ),
    );

    expect(find.text('Open now'), findsOneWidget);
    expect(find.text('Nairobi Weekend Cup'), findsNothing);
    // Having left one, the player can see it again.
    expect(find.text('Mombasa Masters'), findsOneWidget);
  });

  testWidgets('a new player gets the same card at zero, from the starting '
      'rating and its level', (tester) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/players/$myPlayerId': (_) =>
              jsonResponse(newPlayerProfileJson(), 200),
          '/v1/players/$myPlayerId/matches': (_) =>
              jsonResponse(pageJson([]), 200),
          '/v1/me/matches': (_) => jsonResponse(pageJson([]), 200),
        },
      ),
    );

    expect(find.text('1,500'), findsOneWidget);
    expect(find.text('Amateur'), findsOneWidget);
    expect(find.text('New'), findsOneWidget);
    // No matches and no wins yet, and no place on the ladder.
    expect(find.text('0'), findsNWidgets(2));
    expect(find.bySemanticsLabel(RegExp('^Unranked')), findsOneWidget);
    expect(find.text('Kenya rank'), findsOneWidget);
    expect(find.text('Open now'), findsOneWidget);
    expect(find.text('Recent matches'), findsNothing);
  });

  testWidgets('from a server before levels, a new player still starts at '
      '1,500, without a level', (tester) async {
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

    expect(find.text('1,500'), findsOneWidget);
    expect(find.text('New'), findsOneWidget);
    expect(find.text('Amateur'), findsNothing);
  });

  testWidgets('the rating card carries matches, wins and the country rank', (
    tester,
  ) async {
    await pumpTonits(tester, refreshToken: 'stored');

    expect(find.text('1,542'), findsOneWidget);
    expect(find.text('Amateur'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('Up 3 places')), findsOneWidget);
    expect(find.text('21'), findsOneWidget);
    expect(find.text('13'), findsOneWidget);
    expect(find.text('#24'), findsOneWidget);
    expect(find.text('Kenya rank'), findsOneWidget);
    expect(find.text('New'), findsNothing);
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
          '/v1/players/$myPlayerId': (_) => fail
              ? errorResponse(503, 'database_unavailable')
              : jsonResponse(profileJson(), 200),
        },
      ),
    );

    expect(find.text("Couldn't load this"), findsOneWidget);
    expect(find.text('Up next'), findsOneWidget);

    fail = false;
    await tester.ensureVisible(find.text('Try again'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();
    expect(find.text("Couldn't load this"), findsNothing);
    expect(find.text('1,542'), findsOneWidget);
  });

  testWidgets('the bottom bar switches between all four tabs', (tester) async {
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
    // Each player's level follows their handle.
    expect(find.textContaining('@lake.striker · Amateur'), findsOneWidget);

    await openTab(tester, 'Home');
    expect(find.text('1,542'), findsOneWidget);
  });

  testWidgets("Profile opens from Home's avatar, not the bottom bar", (
    tester,
  ) async {
    await pumpTonits(tester, refreshToken: 'stored');
    expect(
      find.descendant(
        of: find.byType(TonitsNavigationBar),
        matching: find.text('Profile'),
      ),
      findsNothing,
    );

    await openProfileFromHome(tester);
    await scrollPageTo(tester, find.text('ABCD-1234-EFGH'));
    expect(find.text('Konami ID'), findsOneWidget);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.text('1,542'), findsOneWidget);
  });

  testWidgets('Profile keeps the Terms, Privacy Notice and the version', (
    tester,
  ) async {
    PackageInfo.setMockInitialValues(
      appName: 'Ozone',
      packageName: 'com.ozone',
      version: '1.0.0',
      buildNumber: '7',
      buildSignature: '',
    );
    await pumpTonits(tester, refreshToken: 'stored');
    await openProfileFromHome(tester);

    await scrollPageTo(tester, find.text('Terms of Service'));
    expect(find.text('Privacy Notice'), findsOneWidget);
    // Until the server serves contest rules, there's no link to them.
    expect(find.text('Contest rules'), findsNothing);
    await scrollPageTo(tester, find.text('Ozone 1.0.0 (7)'));
  });

  testWidgets('contest rules, once served, open from a competition and '
      'Profile; the sponsor line shows anyway', (tester) async {
    final legal = jsonDecode(
      FakeApi()
          .routes['/v1/legal/documents/current']!(
            http.Request('GET', Uri.parse('http://api.test')),
          )
          .body,
    ) as Map<String, dynamic>;
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/legal/documents/current': (_) => jsonResponse({
            'data': [
              ...legal['data'] as List,
              {
                'documentType': 'contest_rules',
                'version': '1.0',
                'contentUrl': 'https://example.test/rules',
                'effectiveAt': '2026-10-01T00:00:00Z',
              },
            ],
          }, 200),
        },
      ),
    );

    await openTab(tester, 'Compete');
    await tester.tap(find.text('Nairobi Weekend Cup'));
    await tester.pumpAndSettle();
    await scrollPageTo(tester, find.textContaining("aren't sponsors"));
    expect(find.text('Contest rules'), findsOneWidget);

    await openTab(tester, 'Home');
    await openProfileFromHome(tester);
    await scrollPageTo(tester, find.text('Contest rules'));
  });

  testWidgets('signing out from Profile returns to sign in', (tester) async {
    await pumpTonits(tester, refreshToken: 'stored');
    await openProfileFromHome(tester);

    await scrollPageTo(tester, find.text('Sign out'));
    await Scrollable.ensureVisible(
      tester.element(find.text('Sign out')),
      alignment: 0.5,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();
    expect(find.text('Sign out of Ozone?'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Sign out'));
    await tester.pumpAndSettle();

    expect(find.text('Your game, ranked.'), findsOneWidget);
    expect(find.byType(TonitsNavigationBar), findsNothing);
  });

  testWidgets("the player's own profile is read with their token", (
    tester,
  ) async {
    final api = await pumpTonits(tester, refreshToken: 'stored');

    final reads = api.requests.where(
      (r) => r.url.path.startsWith('/v1/players/$myPlayerId'),
    );
    expect(reads, isNotEmpty);
    for (final read in reads) {
      expect(read.headers['Authorization'], 'Bearer access-1');
    }
  });
}
