import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tonits/features/chat/application/chat_providers.dart';
import 'package:tonits/features/matches/application/matches_providers.dart';
import 'package:tonits/features/notifications/application/push_messaging.dart';

import 'support/fakes.dart';
import 'support/harness.dart';
import 'support/match_room_helpers.dart';

/// A registration token as FCM hands them out: long, opaque.
final _token = 'fcm:${'A1b2C3d4' * 8}';

/// The push-token and read routes, recording what was registered.
Map<String, http.Response Function(http.Request)> _pushRoutes() => {
  '/v1/me/push-tokens': (request) => jsonResponse({
    'id': 'inst-1',
    'deviceId': 'device-1',
    'platform': 'android',
    'appVersion': '',
    'lastSeenAt': testNow.toIso8601String(),
    'createdAt': testNow.toIso8601String(),
    'updatedAt': testNow.toIso8601String(),
  }, 200),
  '/v1/me/push-tokens/inst-1': (_) => http.Response('', 204),
  '/v1/me/notifications/n1/read': (_) =>
      jsonResponse({'readAt': testNow.toIso8601String()}, 200),
};

Iterable<http.Request> _registrations(FakeApi api) =>
    api.requests.where((r) => r.url.path == '/v1/me/push-tokens');

Map<String, dynamic> _chat() => {
  'data': {
    'matchId': 'm1',
    'open': true,
    'roomCode': null,
    'agreedStartAt': null,
    'playBy': testNow.add(const Duration(days: 1)).toIso8601String(),
    'lastSeq': 1,
    'readSeq': 0,
    'opponentReadSeq': 0,
    'messages': [
      {
        'seq': 1,
        'senderId': 'p-amina',
        'sender': 'away',
        'mine': false,
        'kind': 'text',
        'text': 'you there?',
        'quickReply': null,
        'roomCode': null,
        'proposedStartAt': null,
        'replyToSeq': null,
        'accepted': null,
        'contactHidden': false,
        'sentAt': testNow.toIso8601String(),
      },
    ],
    'hasMore': false,
  },
};

final _overrides = [
  chatPollIntervalProvider.overrideWithValue(const Duration(hours: 1)),
  matchRoomPollIntervalsProvider.overrideWithValue((
    fast: const Duration(hours: 1),
    slow: const Duration(hours: 1),
  )),
];

void main() {
  testWidgets('a signed-in launch registers this device for pushes', (
    tester,
  ) async {
    final store = MemoryPushStore();
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      push: FakePushMessaging(currentToken: _token),
      pushStore: store,
      api: FakeApi(routes: _pushRoutes()),
    );

    final registered = _registrations(api).single;
    expect(jsonDecode(registered.body), {
      'deviceId': 'device-1',
      'platform': 'android',
      'token': _token,
    });
    expect(registered.headers['Authorization'], 'Bearer access-1');
    expect(store.installation, 'inst-1');
  });

  testWidgets('without permission nothing is registered', (tester) async {
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      push: FakePushMessaging(currentToken: _token, allowed: false),
      api: FakeApi(routes: _pushRoutes()),
    );
    expect(_registrations(api), isEmpty);
  });

  testWidgets('a new token from Firebase is registered again', (tester) async {
    final push = FakePushMessaging(currentToken: _token);
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      push: push,
      api: FakeApi(routes: _pushRoutes()),
    );

    push.refreshToken('${_token}Z');
    await tester.pumpAndSettle();

    expect(_registrations(api), hasLength(2));
    expect(
      (jsonDecode(_registrations(api).last.body) as Map)['token'],
      '${_token}Z',
    );
  });

  testWidgets('signing out removes this device while the session still can', (
    tester,
  ) async {
    final store = MemoryPushStore();
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      push: FakePushMessaging(currentToken: _token),
      pushStore: store,
      api: FakeApi(routes: _pushRoutes()),
    );
    await openProfileFromHome(tester);
    await tapText(tester, 'Sign out');
    await tester.tap(find.widgetWithText(TextButton, 'Sign out'));
    await tester.pumpAndSettle();

    final paths = [for (final r in api.requests) '${r.method} ${r.url.path}'];
    final removed = paths.indexOf('DELETE /v1/me/push-tokens/inst-1');
    expect(removed, isNot(-1));
    expect(removed, lessThan(paths.indexOf('POST /v1/auth/logout')));
    expect(store.installation, isNull);
  });

  testWidgets('tapping a chat push marks it read and opens the chat', (
    tester,
  ) async {
    final push = FakePushMessaging();
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      push: push,
      overrides: _overrides,
      api: FakeApi(
        routes: {
          ..._pushRoutes(),
          '/v1/matches/m1/chat': (_) => jsonResponse(_chat(), 200),
        },
      ),
    );

    push.tap(
      const PushMessage(
        title: 'New match message',
        data: {
          'kind': 'match.chat_message',
          'matchId': 'm1',
          'notificationId': 'n1',
        },
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('you there?'), findsOneWidget);
    expect(
      api.requests.where((r) => r.url.path == '/v1/me/notifications/n1/read'),
      hasLength(1),
    );
  });

  testWidgets('a push that launched the app opens once the session is back', (
    tester,
  ) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      overrides: _overrides,
      push: FakePushMessaging(
        launch: const PushMessage(
          data: {
            'kind': 'result.report_received',
            'matchId': 'm1',
            'notificationId': 'n1',
          },
        ),
      ),
      api: FakeApi(routes: _pushRoutes()),
    );

    expect(find.text('Check in to play'), findsOneWidget);
  });

  testWidgets('a push while the app is open refreshes the badge and offers '
      'to open it', (tester) async {
    final push = FakePushMessaging();
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      push: push,
      overrides: _overrides,
      api: FakeApi(routes: _pushRoutes()),
    );
    int badgeReads() => api.requests
        .where((r) => r.url.path == '/v1/me/notifications/unread-count')
        .length;
    final before = badgeReads();

    push.arrive(
      const PushMessage(
        title: 'Confirm the match result',
        data: {
          'kind': 'result.report_received',
          'matchId': 'm1',
          'notificationId': 'n1',
        },
      ),
    );
    await tester.pumpAndSettle();

    expect(badgeReads(), greaterThan(before));
    expect(find.text('Confirm the match result'), findsOneWidget);
    await tester.tap(find.widgetWithText(SnackBarAction, 'Open'));
    await tester.pumpAndSettle();
    expect(find.text('Check in to play'), findsOneWidget);
  });

  testWidgets('a chat push for the chat on screen just reads the message', (
    tester,
  ) async {
    final push = FakePushMessaging();
    final api = await pumpTonits(
      tester,
      refreshToken: 'stored',
      push: push,
      overrides: _overrides,
      api: FakeApi(
        routes: {
          ..._pushRoutes(),
          '/v1/matches/m1/chat': (_) => jsonResponse(_chat(), 200),
        },
      ),
    );
    push.tap(
      const PushMessage(data: {'kind': 'match.chat_message', 'matchId': 'm1'}),
    );
    await tester.pumpAndSettle();
    int chatReads() =>
        api.requests.where((r) => r.url.path == '/v1/matches/m1/chat').length;
    final before = chatReads();

    push.arrive(
      const PushMessage(
        title: 'New match message',
        data: {'kind': 'match.chat_message', 'matchId': 'm1'},
      ),
    );
    await tester.pumpAndSettle();

    expect(chatReads(), greaterThan(before));
    expect(find.byType(SnackBar), findsNothing);
  });
}
