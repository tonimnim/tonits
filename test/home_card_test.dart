import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'support/fakes.dart';
import 'support/harness.dart';

/// No match coming, the default two competitions open, and [entries] as
/// the player's entries (none by default).
FakeApi _noMatch({List<Map<String, dynamic>>? entries}) => FakeApi(
  routes: {
    '/v1/me/matches': (_) => jsonResponse(pageJson([]), 200),
    '/v1/me/registrations': (_) => jsonResponse(pageJson(entries ?? []), 200),
  },
);

Map<String, dynamic> _entry(String status, String competitionStatus) => {
  'id': 'e1',
  'competitionId': 'c9',
  'competitionName': 'Nairobi Weekend Cup',
  'status': status,
  'competitionStatus': competitionStatus,
};

void main() {
  testWidgets('a new install sees what is open, and the cross puts it away', (
    tester,
  ) async {
    final store = MemoryFindCardStore();
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: _noMatch(),
      findCardStore: store,
    );

    expect(find.text('Find your next competition'), findsOneWidget);
    expect(find.text('2 open to enter now'), findsOneWidget);

    await tester.tap(find.byTooltip('Not now'));
    await tester.pumpAndSettle();

    expect(find.text('Find your next competition'), findsNothing);
    expect(store.at, testNow);
  });

  testWidgets('it stays away for 8 hours after it was put away', (
    tester,
  ) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: _noMatch(),
      findCardStore: MemoryFindCardStore(
        testNow.subtract(const Duration(hours: 7)),
      ),
    );
    expect(find.text('Find your next competition'), findsNothing);
  });

  testWidgets('after 8 hours it comes back', (tester) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: _noMatch(),
      findCardStore: MemoryFindCardStore(
        testNow.subtract(const Duration(hours: 9)),
      ),
    );
    expect(find.text('Find your next competition'), findsOneWidget);
  });

  testWidgets('a player already in a competition is not pushed to another', (
    tester,
  ) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: _noMatch(entries: [_entry('registered', 'registration_open')]),
    );
    expect(find.text('Find your next competition'), findsNothing);
  });

  testWidgets('an entry in a finished competition does not count', (
    tester,
  ) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: _noMatch(entries: [_entry('accepted', 'completed')]),
    );
    expect(find.text('Find your next competition'), findsOneWidget);
  });

  testWidgets('with nothing open, there is no card', (tester) async {
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
    expect(find.text('Find your next competition'), findsNothing);
    expect(find.text('Your move'), findsNothing);
    expect(find.text('Up next'), findsNothing);
  });

  testWidgets('a match waiting on the player is Your move', (tester) async {
    await pumpTonits(tester, refreshToken: 'stored');
    expect(find.text('Your move'), findsOneWidget);
  });

  testWidgets('a match waiting on the opponent is Up next', (tester) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/me/matches': (http.Request request) => jsonResponse(
            pageJson([matchJson(lifecycle: 'awaiting_opponent_confirmation')]),
            200,
          ),
        },
      ),
    );
    expect(find.text('Up next'), findsOneWidget);
    expect(find.text('Your move'), findsNothing);
  });
}
