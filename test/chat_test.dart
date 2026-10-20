import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tonits/app/shell/tonits_navigation_bar.dart';

import 'support/fakes.dart';
import 'support/harness.dart';
import 'support/match_room_helpers.dart';

/// A match chat on the fake API: numbers messages, pins a shared code,
/// records an accepted time, and answers reads after a seq.
class _FakeChat {
  _FakeChat({
    this.open = true,
    List<Map<String, dynamic>>? messages,
    this.failNextSend = false,
  }) : messages = messages ?? [];

  bool open;
  bool failNextSend;
  final List<Map<String, dynamic>> messages;
  String? roomCode;
  String? agreedStartAt;
  final sent = <Map<String, dynamic>>[];
  final reads = <int>[];
  final reports = <Map<String, dynamic>>[];

  int get lastSeq => messages.isEmpty ? 0 : messages.last['seq'] as int;

  Map<String, http.Response Function(http.Request)> get routes => {
    '/v1/matches/m1': (_) => jsonResponse({
      'data': {
        ...matchRoomJson(),
        'chat': {
          'open': open,
          'lastSeq': lastSeq,
          'unread': messages.where((m) => m['mine'] != true).length,
          'roomCode': roomCode,
          'agreedStartAt': agreedStartAt,
        },
      },
    }, 200),
    '/v1/matches/m1/chat': (request) {
      final after = int.tryParse(request.url.queryParameters['after'] ?? '');
      return jsonResponse({
        'data': {
          'matchId': 'm1',
          'open': open,
          'roomCode': roomCode == null
              ? null
              : {
                  'code': roomCode,
                  'setBy': 'home',
                  'setAt': testNow.toIso8601String(),
                },
          'agreedStartAt': agreedStartAt,
          'playBy': testNow.add(const Duration(days: 1)).toIso8601String(),
          'lastSeq': lastSeq,
          'readSeq': 0,
          'opponentReadSeq': lastSeq,
          'messages': [
            for (final m in messages)
              if (after == null || (m['seq'] as int) > after) m,
          ],
          'hasMore': false,
        },
      }, 200);
    },
    '/v1/matches/m1/chat/messages': (request) {
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      sent.add(body);
      if (failNextSend) {
        failNextSend = false;
        throw http.ClientException('offline');
      }
      final existing = messages.where(
        (m) => m['clientMessageId'] == body['clientMessageId'],
      );
      if (existing.isNotEmpty) {
        return jsonResponse({'data': existing.first}, 200);
      }
      final message = chatMessageJson(
        lastSeq + 1,
        mine: true,
        kind: body['kind'] as String,
        text: body['text'] as String?,
        quickReply: body['quickReply'] as String?,
        roomCode: body['roomCode'] as String?,
        proposedStartAt: body['proposedStartAt'] as String?,
        replyToSeq: body['replyToSeq'] as int?,
        accepted: body['accepted'] as bool?,
      )..['clientMessageId'] = body['clientMessageId'];
      messages.add(message);
      if (body['kind'] == 'room_code') roomCode = body['roomCode'] as String;
      if (body['kind'] == 'time_answer' && body['accepted'] == true) {
        agreedStartAt =
            messages.firstWhere(
                  (m) => m['seq'] == body['replyToSeq'],
                )['proposedStartAt']
                as String;
      }
      return jsonResponse({'data': message}, 201);
    },
    '/v1/matches/m1/chat/read': (request) {
      reads.add((jsonDecode(request.body) as Map)['seq'] as int);
      return http.Response('', 204);
    },
    '/v1/matches/m1/chat/reports': (request) {
      reports.add(jsonDecode(request.body) as Map<String, dynamic>);
      return jsonResponse({'data': <String, dynamic>{}}, 201);
    },
  };
}

Map<String, dynamic> chatMessageJson(
  int seq, {
  bool mine = false,
  String kind = 'text',
  String? text,
  String? quickReply,
  String? roomCode,
  String? proposedStartAt,
  int? replyToSeq,
  bool? accepted,
  bool contactHidden = false,
}) => {
  'seq': seq,
  'senderId': mine ? myPlayerId : 'p-amina',
  'sender': mine ? 'home' : 'away',
  'mine': mine,
  'kind': kind,
  'text': text,
  'quickReply': quickReply,
  'roomCode': roomCode,
  'proposedStartAt': proposedStartAt,
  'replyToSeq': replyToSeq,
  'accepted': accepted,
  'contactHidden': contactHidden,
  'sentAt': testNow.subtract(Duration(minutes: 30 - seq)).toIso8601String(),
};

/// Opens m1's room, then its chat from the room's chat button.
Future<void> _openChat(WidgetTester tester, _FakeChat chat) async {
  await openRoom(tester, room: matchRoomJson(), routes: chat.routes);
  await tester.tap(find.byTooltip('Chat'));
  await tester.pumpAndSettle();
}

Map<String, dynamic> _lastSent(_FakeChat chat) => chat.sent.last;

void main() {
  testWidgets("the room's chat button shows the unread count and opens the "
      'chat, which marks it read', (tester) async {
    final chat = _FakeChat(
      messages: [
        chatMessageJson(1, text: 'yo, free at 6?'),
        chatMessageJson(2, kind: 'quick_reply', quickReply: 'ready_now'),
      ],
    );
    await openRoom(tester, room: matchRoomJson(), routes: chat.routes);
    expect(find.bySemanticsLabel('2 unread messages'), findsOneWidget);

    await tester.tap(find.byTooltip('Chat'));
    await tester.pumpAndSettle();

    // The opponent and the match, as a chat app's header.
    expect(find.text('Amina Otieno'), findsWidgets);
    expect(find.textContaining('Round of 32 ·'), findsOneWidget);
    expect(find.text('yo, free at 6?'), findsOneWidget);
    expect(find.text('Ready now'), findsWidgets);
    expect(
      find.text("Ozone only reads this chat if there's a dispute or a report."),
      findsOneWidget,
    );
    expect(chat.reads, [2]);
  });

  testWidgets('a message is sent with its own id and shows at once', (
    tester,
  ) async {
    final chat = _FakeChat();
    await _openChat(tester, chat);
    expect(
      find.text('Say hi to Amina Otieno and sort out when to play.'),
      findsOneWidget,
    );

    await tester.enterText(find.byType(TextField), '  see you at 6  ');
    await tester.pump();
    await tester.tap(find.byTooltip('Send'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'room in 5');
    await tester.pump();
    await tester.tap(find.byTooltip('Send'));
    await tester.pumpAndSettle();

    expect(chat.sent.first['kind'], 'text');
    expect(chat.sent.first['text'], 'see you at 6');
    expect(chat.sent.first.keys.toSet(), {'clientMessageId', 'kind', 'text'});
    expect(
      chat.sent.first['clientMessageId'],
      isNot(chat.sent.last['clientMessageId']),
    );
    expect(find.text('see you at 6'), findsOneWidget);
    expect(find.text('room in 5'), findsOneWidget);
    // The opponent has read both: two ticks on each.
    expect(
      find.byWidgetPredicate(
        (w) => w is Icon && w.icon == Icons.done_all_rounded,
      ),
      findsNWidgets(2),
    );
  });

  testWidgets('a message lost to the connection is retried with the same id', (
    tester,
  ) async {
    final chat = _FakeChat(failNextSend: true);
    await _openChat(tester, chat);

    await tester.enterText(find.byType(TextField), 'ready?');
    await tester.pump();
    await tester.tap(find.byTooltip('Send'));
    await tester.pumpAndSettle();
    expect(find.text('Not sent. Tap to retry.'), findsOneWidget);

    await tester.tap(find.text('Not sent. Tap to retry.'));
    await tester.pumpAndSettle();

    expect(chat.sent, hasLength(2));
    expect(chat.sent[0]['clientMessageId'], chat.sent[1]['clientMessageId']);
    expect(find.text('Not sent. Tap to retry.'), findsNothing);
    expect(chat.messages, hasLength(1));
  });

  testWidgets('the room code is dropped from the game plan and pinned', (
    tester,
  ) async {
    final chat = _FakeChat();
    await _openChat(tester, chat);

    await tester.tap(find.widgetWithText(ActionChip, 'Ready now'));
    await tester.pumpAndSettle();
    expect(_lastSent(chat)['kind'], 'quick_reply');
    expect(_lastSent(chat)['quickReply'], 'ready_now');

    // The plan says the code isn't shared, with the button to drop it.
    expect(find.text('Not shared yet'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Drop code'));
    await tester.pumpAndSettle();
    expect(find.text('Drop the room code'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'ab12/!');
    await tester.tap(find.widgetWithText(FilledButton, 'Pin code'));
    await tester.pumpAndSettle();
    expect(
      find.text('Letters, numbers, spaces or dashes only.'),
      findsOneWidget,
    );
    await tester.enterText(find.byType(TextFormField), ' 4821 3390 ');
    await tester.tap(find.widgetWithText(FilledButton, 'Pin code'));
    await tester.pumpAndSettle();

    expect(_lastSent(chat), {
      'clientMessageId': _lastSent(chat)['clientMessageId'],
      'kind': 'room_code',
      'roomCode': '4821 3390',
    });
    // On the plan and in the conversation, each with Copy.
    expect(find.text('4821 3390'), findsNWidgets(2));
    expect(find.text('Copy'), findsNWidgets(2));
    expect(find.text('Not shared yet'), findsNothing);
  });

  testWidgets("the opponent's suggested time can be accepted, and the plan "
      'shows it with the deadlines note', (tester) async {
    final kickOff = testNow.add(const Duration(hours: 2));
    final chat = _FakeChat(
      messages: [
        chatMessageJson(
          1,
          kind: 'time_proposal',
          proposedStartAt: kickOff.toIso8601String(),
        ),
      ],
    );
    await _openChat(tester, chat);
    expect(find.text('Play at'), findsOneWidget);
    expect(find.text('Amina Otieno wants'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Accept'));
    await tester.pumpAndSettle();

    expect(_lastSent(chat)['kind'], 'time_answer');
    expect(_lastSent(chat)['replyToSeq'], 1);
    expect(_lastSent(chat)['accepted'], isTrue);
    expect(find.textContaining('Kick-off set ·'), findsOneWidget);
    expect(find.text('Kick-off set'), findsOneWidget);
    expect(find.text('Deadlines still apply'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Accept'), findsNothing);
  });

  testWidgets('suggesting a time sends it rounded to the minute', (
    tester,
  ) async {
    final chat = _FakeChat();
    await _openChat(tester, chat);

    expect(find.text('Not set yet'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Suggest time'));
    await tester.pumpAndSettle();
    expect(find.text('When do you want to play?'), findsOneWidget);
    await tester.tap(find.text('In 30 min'));
    await tester.pumpAndSettle();

    expect(_lastSent(chat)['kind'], 'time_proposal');
    final at = DateTime.parse(_lastSent(chat)['proposedStartAt'] as String);
    expect(at.isUtc, isTrue);
    expect(at.second, 0);
    expect(at.isAfter(testNow.add(const Duration(minutes: 29))), isTrue);
    expect(find.text('You suggested'), findsOneWidget);
    expect(find.text('Waiting for Amina Otieno'), findsWidgets);
  });

  testWidgets("the opponent's message can be reported with a long press", (
    tester,
  ) async {
    final chat = _FakeChat(
      messages: [chatMessageJson(1, text: 'pay me first')],
    );
    await _openChat(tester, chat);

    await tester.longPress(find.text('pay me first'));
    await tester.pumpAndSettle();
    expect(find.text('Report this message'), findsOneWidget);
    await tester.tap(find.text('Cheating'));
    await tester.pumpAndSettle();

    expect(chat.reports, [
      {'seq': 1, 'reason': 'cheating'},
    ]);
    expect(find.text("Reported. We'll check it."), findsOneWidget);
  });

  testWidgets('a closed chat is read-only', (tester) async {
    final chat = _FakeChat(
      open: false,
      messages: [
        chatMessageJson(1, kind: 'quick_reply', quickReply: 'good_game'),
      ],
    );
    await _openChat(tester, chat);

    expect(find.text('GG'), findsOneWidget);
    expect(
      find.text('The match is over, so this chat is closed.'),
      findsOneWidget,
    );
    expect(find.byType(TextField), findsNothing);
    expect(find.widgetWithText(FilledButton, 'Drop code'), findsNothing);
  });

  testWidgets('hidden contact details are said so under the message', (
    tester,
  ) async {
    final chat = _FakeChat(
      messages: [
        chatMessageJson(1, text: 'call me on [hidden]', contactHidden: true),
      ],
    );
    await _openChat(tester, chat);
    expect(find.text('Numbers and links are hidden.'), findsOneWidget);
  });

  testWidgets('a chat notification opens the chat', (tester) async {
    final chat = _FakeChat(messages: [chatMessageJson(1, text: 'ready?')]);
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          ...chat.routes,
          '/v1/me/notifications': (_) => jsonResponse(
            pageJson([
              notificationJson(
                category: 'match',
                title: 'New match message',
                body: 'amina sent you a message.',
                data: const {'kind': 'match.chat_message', 'matchId': 'm1'},
                actionUrl: '/matches/m1/chat',
              ),
            ]),
            200,
          ),
        },
      ),
    );
    await tester.tap(find.byTooltip('Notifications'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('New match message'));
    await tester.pumpAndSettle();

    expect(find.text('ready?'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets("a match card shows the chat's unread count", (tester) async {
    await pumpTonits(
      tester,
      refreshToken: 'stored',
      api: FakeApi(
        routes: {
          '/v1/me/matches': (_) => jsonResponse(
            pageJson([
              {
                ...matchJson(),
                'chat': {'open': true, 'lastSeq': 3, 'unread': 3},
              },
            ]),
            200,
          ),
        },
      ),
    );
    await tester.tap(
      find.descendant(
        of: find.byType(TonitsNavigationBar),
        matching: find.text('Matches'),
      ),
    );
    await tester.pumpAndSettle();
    // Read out with the rest of the card.
    expect(find.bySemanticsLabel(RegExp('3 unread messages')), findsOneWidget);
  });
}
