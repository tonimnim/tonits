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
