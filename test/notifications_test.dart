import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/core/format.dart';
import 'package:tonits/features/notifications/application/notification_target.dart';
import 'package:tonits/features/notifications/data/app_notification.dart';
import 'package:tonits/features/notifications/ui/widgets/notification_bell.dart';

import 'support/fakes.dart';
import 'support/harness.dart';

Future<FakeApi> openInbox(WidgetTester tester, {FakeApi? api}) async {
  final fake = await pumpTonits(tester, refreshToken: 'stored', api: api);
  await tester.tap(find.byTooltip('Notifications'));
  await tester.pumpAndSettle();
  return fake;
}

final unreadMarks = find.byWidgetPredicate(
  (w) => w is Semantics && w.properties.label == 'Unread',
);

AppNotification item(Map<String, Object?> data, {String category = 'result'}) =>
    AppNotification.fromJson(notificationJson(data: data, category: category));

void main() {
  testWidgets('the bell shows the unread count and opens the inbox', (
    tester,
  ) async {
    await pumpTonits(tester, refreshToken: 'stored');
    expect(
      find.descendant(
        of: find.byType(NotificationBell),
        matching: find.text('2'),
      ),
      findsOneWidget,
    );

    await tester.tap(find.byTooltip('Notifications'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'Notifications'), findsOneWidget);
    expect(find.text('Confirm the match result'), findsOneWidget);
    // As the inbox words each age, which depends on the time of day: just
    // after midnight a 3-hour-old item is yesterday's.
    for (final age in const [
      Duration(minutes: 5),
      Duration(hours: 3),
      Duration(days: 1),
    ]) {
      expect(
        find.text(Format.ago(testNow.subtract(age), en, now: testNow)),
        findsWidgets,
      );
    }
  });

  testWidgets('a result notification is marked read and opens its match', (
    tester,
  ) async {
    final api = FakeApi(
      routes: {
        '/v1/me/notifications/n1/read': (_) => jsonResponse({
          'id': 'n1',
          'readAt': testNow.toIso8601String(),
        }, 200),
      },
    );
    await openInbox(tester, api: api);

    await tester.tap(find.text('Confirm the match result'));
    await tester.pumpAndSettle();

    expect(
      api.requests.where((r) => r.url.path == '/v1/me/notifications/n1/read'),
      hasLength(1),
    );
    // The match room, at check-in in the default fake.
    expect(find.text('Check in to play'), findsOneWidget);
  });

  testWidgets('a payment notification opens Payments', (tester) async {
    final api = FakeApi(
      routes: {
        '/v1/me/notifications/n2/read': (_) => jsonResponse({
          'id': 'n2',
          'readAt': testNow.toIso8601String(),
        }, 200),
        '/v1/me/payments': (_) => jsonResponse(pageJson([]), 200),
      },
    );
    await openInbox(tester, api: api);

    await tester.tap(find.text('Payment received'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'Payments'), findsOneWidget);
    expect(
      api.requests.where((r) => r.url.path == '/v1/me/notifications/n2/read'),
      hasLength(1),
    );
  });

  testWidgets('mark all read clears the badge and the dots', (tester) async {
    var unread = 2;
    final api = FakeApi(
      routes: {
        '/v1/me/notifications/unread-count': (_) =>
            jsonResponse({'unreadCount': unread}, 200),
        '/v1/me/notifications/read-all': (_) {
          unread = 0;
          return jsonResponse({'updatedCount': 2, 'unreadCount': 0}, 200);
        },
      },
    );
    await openInbox(tester, api: api);
    expect(unreadMarks, findsNWidgets(2));

    await tester.tap(find.text('Mark all read'));
    await tester.pumpAndSettle();

    expect(find.text('Mark all read'), findsNothing);
    expect(unreadMarks, findsNothing);
  });

  testWidgets('the unread tab asks for unread items only', (tester) async {
    final api = await openInbox(tester);
    await tester.tap(find.text('Unread'));
    await tester.pumpAndSettle();

    final lastList = api.requests.lastWhere(
      (r) => r.url.path == '/v1/me/notifications',
    );
    expect(lastList.url.queryParameters['unreadOnly'], 'true');
    expect(find.text('Tournament draw is ready'), findsNothing);
  });

  testWidgets('an empty inbox says so', (tester) async {
    await openInbox(
      tester,
      api: FakeApi(
        routes: {
          '/v1/me/notifications': (_) => jsonResponse(pageJson([]), 200),
          '/v1/me/notifications/unread-count': (_) =>
              jsonResponse({'unreadCount': 0}, 200),
        },
      ),
    );
    expect(find.text('No notifications yet'), findsOneWidget);
    expect(find.text('Mark all read'), findsNothing);
  });

  group('where an item leads', () {
    test('match and result events open the match room', () {
      expect(
        NotificationTarget.of(item({'kind': 'match.ready', 'matchId': 'm9'})),
        isA<OpenMatch>().having((t) => t.matchId, 'matchId', 'm9'),
      );
      // The removal names the match that removed the entry.
      expect(
        NotificationTarget.of(
          item({
            'kind': 'competition.entry_removed',
            'competitionId': 'c1',
            'matchId': 'm9',
          }),
        ),
        isA<OpenMatch>(),
      );
    });

    test('competition events open the competition', () {
      expect(
        NotificationTarget.of(
          item({'kind': 'competition.check_in', 'competitionId': 'c7'}),
        ),
        isA<OpenCompetition>().having((t) => t.competitionId, 'id', 'c7'),
      );
    });

    test('unknown kinds fall back to the category and ids', () {
      expect(
        NotificationTarget.of(
          item({'kind': 'match.something_new', 'matchId': 'm3'}),
        ),
        isA<OpenMatch>(),
      );
      expect(NotificationTarget.of(item({'matchId': 'm3'})), isA<OpenMatch>());
      expect(
        NotificationTarget.of(
          item({
            'kind': 'player.strike_recorded',
            'strikeId': 's1',
          }, category: 'account'),
        ),
        isA<ShowDetails>(),
      );
    });
  });
}
