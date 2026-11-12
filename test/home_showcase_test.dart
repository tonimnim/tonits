import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'support/fakes.dart';
import 'support/harness.dart';

final _opensAt = testNow.add(const Duration(days: 3)).toIso8601String();

/// Competitions by status: [published] still to open, [completed] over.
http.Response Function(http.Request) _competitions({
  List<Map<String, dynamic>> published = const [],
  List<Map<String, dynamic>> completed = const [],
}) =>
    (request) => jsonResponse(
      pageJson(switch (request.url.queryParameters['status']) {
        'published' => published,
        'completed' => completed,
        _ => [competitionJson()],
      }),
      200,
    );

Map<String, dynamic> _comingUp({bool? reminderSet}) => {
  ...competitionJson(id: 'c5', name: 'Kisumu Cup', status: 'published'),
  'registrationOpensAt': _opensAt,
  'reminderSet': ?reminderSet,
};

/// The latest completed competition, as the API lists it: with its winner,
/// or `null` when first place was shared.
Map<String, dynamic> _completed({String? winner = 'Coast Ace'}) => {
  ...competitionJson(id: 'c8', name: 'Mombasa Masters', status: 'completed'),
  'winner': winner == null
      ? null
      : {'playerId': null, 'displayName': winner, 'avatarUrl': null},
};

void main() {
  testWidgets("the top of the player's country, with their own spot", (
    tester,
  ) async {
    await pumpTonits(tester, refreshToken: 'stored');

    expect(find.text('Top of Kenya'), findsOneWidget);
    expect(find.text('Lake Striker'), findsOneWidget);
    expect(find.text('Your spot: #24'), findsOneWidget);
  });

  testWidgets('an unranked player is told how to get a spot', (tester) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(routes: {'/v1/rankings': rankingsRoute(ranked: false)}),
    );
    expect(
      find.text('Your spot: not ranked yet · play a match to place'),
      findsOneWidget,
    );
  });

  testWidgets('with nothing to show, there are no rotating cards', (
    tester,
  ) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/rankings': rankingsRoute(ladder: []),
          '/v1/competitions': _competitions(),
        },
      ),
    );
    expect(find.text('Top of Kenya'), findsNothing);
    expect(find.text('Recent champion'), findsNothing);
    expect(find.text('Coming up'), findsNothing);
  });

  testWidgets('the cards turn by themselves, to the latest champion and '
      'what opens next', (tester) async {
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/competitions': _competitions(
            published: [_comingUp()],
            completed: [_completed()],
          ),
        },
      ),
    );
    expect(find.text('Top of Kenya'), findsOneWidget);
    // One read names the champion: the newest completed, with its winner.
    final completed = api.requests.singleWhere(
      (r) => r.url.queryParameters['status'] == 'completed',
    );
    expect(completed.url.queryParameters['limit'], '1');
    expect(
      api.requests.where((r) => r.url.path.endsWith('/standings')),
      isEmpty,
    );

    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
    expect(find.text('Recent champion'), findsOneWidget);
    expect(find.text('Coast Ace'), findsOneWidget);
    expect(find.text('Won Mombasa Masters'), findsOneWidget);

    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
    expect(find.text('Coming up'), findsOneWidget);
    expect(find.text('Kisumu Cup'), findsOneWidget);
    expect(find.textContaining('Entries open'), findsOneWidget);
    // The API doesn't offer reminders here, so there's no button.
    expect(find.text('Remind me'), findsNothing);
  });

  testWidgets('a shared first place shows no champion', (tester) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/competitions': _competitions(
            completed: [_completed(winner: null)],
          ),
        },
      ),
    );

    expect(find.text('Recent champion'), findsNothing);
  });

  testWidgets('a reminder set stays on after the cards turn past it', (
    tester,
  ) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/competitions': _competitions(
            published: [_comingUp(reminderSet: false)],
            completed: [_completed()],
          ),
          '/v1/me/competition-reminders/c5': (_) => http.Response('', 204),
        },
      ),
    );
    // Top of Kenya, then the champion, then what's coming up.
    for (var i = 0; i < 2; i++) {
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();
    }
    await Scrollable.ensureVisible(
      tester.element(find.text('Remind me')),
      alignment: 0.5,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Remind me'));
    await tester.pumpAndSettle();
    expect(find.text('Reminder on'), findsOneWidget);

    // Round the row once more, back to the same card.
    for (var i = 0; i < 3; i++) {
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();
    }
    expect(find.text('Coming up'), findsOneWidget);
    expect(find.text('Reminder on'), findsOneWidget);
    expect(find.text('Remind me'), findsNothing);
  });

  testWidgets('Remind me asks the API, and shows it is on', (tester) async {
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/rankings': rankingsRoute(ladder: []),
          '/v1/competitions': _competitions(
            published: [_comingUp(reminderSet: false)],
          ),
          '/v1/me/competition-reminders/c5': (_) => http.Response('', 204),
        },
      ),
    );

    // Centred, clear of the bottom bar.
    await Scrollable.ensureVisible(
      tester.element(find.text('Remind me')),
      alignment: 0.5,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Remind me'));
    await tester.pumpAndSettle();

    final put = api.requests.singleWhere(
      (r) => r.url.path == '/v1/me/competition-reminders/c5',
    );
    expect(put.method, 'PUT');
    expect(find.text('Reminder on'), findsOneWidget);
  });
}
