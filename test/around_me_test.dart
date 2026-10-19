import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/app/shell/tonits_navigation_bar.dart';

import 'support/fakes.dart';
import 'support/harness.dart';

Future<void> openRankings(WidgetTester tester) async {
  await tester.tap(
    find.descendant(
      of: find.byType(TonitsNavigationBar),
      matching: find.text('Rankings'),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets("Home's ladder is the two places either side of the player", (
    tester,
  ) async {
    final api = await pumpTonits(tester, refreshToken: 'stored');
    await scrollPageTo(tester, find.text('Kenya ladder'));

    final around = api.requests.firstWhere(
      (r) =>
          r.url.path == '/v1/rankings' &&
          r.url.queryParameters['around'] == 'me',
    );
    expect(around.url.queryParameters, containsPair('span', '2'));
    expect(around.headers['Authorization'], 'Bearer access-1');
    // 22 to 26: the player is 24th.
    expect(find.text('Rift Valley FC'), findsOneWidget);
    expect(find.text('striker.9 (you)'), findsOneWidget);
    expect(find.text('Lake Striker'), findsNothing);
  });

  testWidgets("an unranked player's Home shows the top three", (tester) async {
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(routes: {'/v1/rankings': rankingsRoute(ranked: false)}),
    );
    await scrollPageTo(tester, find.text('Top in Kenya'));
    final top = api.requests.lastWhere(
      (r) =>
          r.url.path == '/v1/rankings' &&
          r.url.queryParameters['around'] == null,
    );
    expect(top.url.queryParameters['limit'], '3');
  });

  testWidgets('a player below the loaded rows sees their place pinned', (
    tester,
  ) async {
    // The first page is the top 3; the player is 24th.
    final ladder = ladderJson();
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/rankings': (request) =>
              request.url.queryParameters['around'] == 'me'
              ? rankingsRoute(ladder: ladder)(request)
              : jsonResponse(pageJson(ladder.take(3).toList()), 200),
        },
      ),
    );
    await openRankings(tester);

    expect(find.text('Lake Striker'), findsOneWidget);
    expect(find.text('striker.9 (you)'), findsOneWidget);
    // Pinned under the list, not one of its rows.
    expect(
      tester.getTopLeft(find.text('striker.9 (you)')).dy,
      greaterThan(tester.getTopLeft(find.text('Lake Striker')).dy),
    );
  });

  testWidgets('a player already on screen is not pinned twice', (tester) async {
    await pumpTonits(tester, refreshToken: 'stored');
    await openRankings(tester);
    expect(find.text('striker.9 (you)'), findsOneWidget);
  });
}
