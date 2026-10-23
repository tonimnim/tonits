import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/app/shell/tonits_navigation_bar.dart';
import 'package:tonits/features/chat/application/chat_providers.dart';

import 'support/draw_fixtures.dart';
import 'support/fakes.dart';
import 'support/harness.dart';

/// Every screen must fit a small phone, including with enlarged text. Any
/// overflow fails the test.
void main() {
  const small = Size(360, 740);

  for (final scale in [1.0, 1.3]) {
    testWidgets('signed-out screens fit at text scale $scale', (tester) async {
      await pumpTonits(tester, size: small, textScale: scale);
      expect(find.text('Your game, ranked.'), findsOneWidget);
    });

    testWidgets('onboarding fits at text scale $scale', (tester) async {
      await pumpTonits(
        tester,
        size: small,
        textScale: scale,
        refreshToken: 'stored',
        api: FakeApi(
          routes: {
            '/v1/auth/refresh': (_) =>
                jsonResponse(sessionJson(onboarded: false), 200),
          },
        ),
      );
      for (final (title, value) in [
        ('Pick your username', null),
        ('Link eFootball', 'ABCD-1234-EFGH'),
        ('Where do you play from?', null),
        ('Your phone number', null),
      ]) {
        expect(find.text(title), findsOneWidget);
        if (value != null) {
          await tester.enterText(find.byType(TextFormField), value);
        }
        if (title == 'Your phone number') break;
        await tester.tap(find.text('Continue'));
        await tester.pumpAndSettle();
      }
    });

    for (final (kind, draw) in [
      (
        'knockout',
        () =>
            (stages: [knockoutJson()], tables: const <Map<String, dynamic>>[]),
      ),
      (
        'round robin',
        () {
          final groups = roundRobinJson(bestOf: 3);
          return (stages: [groups.stage], tables: [groups.tables]);
        },
      ),
    ]) {
      testWidgets('a $kind draw fits at text scale $scale', (tester) async {
        final (:stages, :tables) = draw();
        await pumpTonits(
          tester,
          size: small,
          textScale: scale,
          refreshToken: 'stored',
          api: FakeApi(
            routes: drawRoutes(
              status: 'running',
              stages: stages,
              tables: tables,
            ),
          ),
        );
        await openCompetition(tester, 'Entry');
      });
    }

    testWidgets('My entries fits at text scale $scale', (tester) async {
      await pumpTonits(
        tester,
        size: small,
        textScale: scale,
        refreshToken: 'stored',
        api: FakeApi(
          routes: {
            '/v1/me/registrations': (_) => jsonResponse(
              pageJson([
                {
                  'id': 'r1',
                  'competitionId': 'c1',
                  'competitionName': 'The Very Long Nairobi Weekend Cup Final',
                  'status': 'withdrawal_pending',
                  'entryFeeMinor': 10000,
                  'currency': 'KES',
                  'startsAt': '2027-01-14T16:00:00Z',
                  'competitionStatus': 'registration_open',
                },
              ]),
              200,
            ),
          },
        ),
      );
      await openProfileFromHome(tester);
      await scrollPageTo(tester, find.text('My entries'));
      await tester.tap(find.text('My entries'));
      await tester.pumpAndSettle();
      expect(find.text('Refund pending'), findsOneWidget);
    });

    testWidgets('a match chat fits at text scale $scale', (tester) async {
      final at = testNow.add(const Duration(hours: 2)).toIso8601String();
      Map<String, dynamic> message(int seq, String kind, {bool mine = false}) =>
          {
            'seq': seq,
            'senderId': 'x',
            'sender': mine ? 'home' : 'away',
            'mine': mine,
            'kind': kind,
            'text': kind == 'text' ? 'A long message ' * 6 : null,
            'quickReply': kind == 'quick_reply' ? 'friend_request_sent' : null,
            'roomCode': kind == 'room_code' ? 'ABCD-1234-EFGH-5678' : null,
            'proposedStartAt': kind == 'time_proposal' ? at : null,
            'replyToSeq': null,
            'accepted': null,
            'contactHidden': false,
            'sentAt': testNow.toIso8601String(),
          };
      await pumpTonits(
        tester,
        size: small,
        textScale: scale,
        refreshToken: 'stored',
        overrides: [
          chatPollIntervalProvider.overrideWithValue(const Duration(hours: 1)),
        ],
        api: FakeApi(
          routes: {
            '/v1/matches/m1': (_) => jsonResponse({
              'data': {
                ...matchRoomJson(),
                'chat': {'open': true, 'lastSeq': 4, 'unread': 4},
              },
            }, 200),
            '/v1/matches/m1/chat': (_) => jsonResponse({
              'data': {
                'matchId': 'm1',
                'open': true,
                'roomCode': {
                  'code': 'ABCD-1234-EFGH-5678',
                  'setBy': 'away',
                  'setAt': at,
                },
                'agreedStartAt': at,
                'playBy': testNow
                    .add(const Duration(days: 1))
                    .toIso8601String(),
                'lastSeq': 4,
                'readSeq': 4,
                'opponentReadSeq': 4,
                'messages': [
                  message(1, 'text'),
                  message(2, 'quick_reply', mine: true),
                  message(3, 'room_code'),
                  message(4, 'time_proposal'),
                ],
                'hasMore': false,
              },
            }, 200),
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
      await tester.tap(find.text('vs Amina Otieno'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Chat'));
      await tester.pumpAndSettle();
      expect(find.text('Play at'), findsOneWidget);
    });

    testWidgets('notification settings fit at text scale $scale', (
      tester,
    ) async {
      await pumpTonits(
        tester,
        size: small,
        textScale: scale,
        refreshToken: 'stored',
        api: FakeApi(
          routes: {
            '/v1/me/notification-preferences': (_) => jsonResponse({
              'competitionPush': true,
              'matchPush': true,
              'resultPush': true,
              'competitionEmail': true,
              'matchEmail': true,
              'marketingEmail': false,
              'updatedAt': testNow.toIso8601String(),
            }, 200),
          },
        ),
      );
      await openProfileFromHome(tester);
      await scrollPageTo(tester, find.text('Notifications'));
      // Centred, clear of the bottom bar.
      await Scrollable.ensureVisible(
        tester.element(find.text('Notifications')),
        alignment: 0.5,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Notifications'));
      await tester.pumpAndSettle();
      expect(find.text('News and offers'), findsOneWidget);
    });

    testWidgets('every tab fits at text scale $scale', (tester) async {
      await pumpTonits(
        tester,
        size: small,
        textScale: scale,
        refreshToken: 'stored',
      );
      expect(find.text('1,542'), findsOneWidget);
      // Build the whole Home page, not just what's on screen.
      await scrollPageTo(tester, find.text('Recent matches'));

      for (final tab in ['Compete', 'Matches', 'Rankings', 'Home']) {
        await tester.tap(
          find.descendant(
            of: find.byType(TonitsNavigationBar),
            matching: find.text(tab),
          ),
        );
        await tester.pumpAndSettle();
      }
      // Profile, from Home's avatar: build the whole page too.
      await openProfileFromHome(tester);
      await scrollPageTo(tester, find.text('Sign out'));
    });

    testWidgets('entry screens fit at text scale $scale', (tester) async {
      await pumpTonits(
        tester,
        size: small,
        textScale: scale,
        refreshToken: 'stored',
      );
      await tester.tap(
        find.descendant(
          of: find.byType(TonitsNavigationBar),
          matching: find.text('Compete'),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Mombasa Masters'));
      await tester.pumpAndSettle();
      expect(find.text('Pay Ksh 100 with M-Pesa'), findsOneWidget);
      await tester.tap(find.text('Pay Ksh 100 with M-Pesa'));
      await tester.pumpAndSettle();
      expect(find.text('Send payment request'), findsOneWidget);
    });

    testWidgets('account screens fit at text scale $scale', (tester) async {
      await pumpTonits(
        tester,
        size: small,
        textScale: scale,
        refreshToken: 'stored',
      );
      await openProfileFromHome(tester);
      for (final (row, title) in [
        ('Display name', 'Display name'),
        ('Email', 'Email'),
        ('Phone', 'Phone number'),
      ]) {
        await scrollPageTo(tester, find.text(row));
        // Clear of the back button's bar, now that Profile is pushed.
        await Scrollable.ensureVisible(
          tester.element(find.text(row).last),
          alignment: 0.5,
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text(row).last);
        await tester.pumpAndSettle();
        expect(find.widgetWithText(AppBar, title), findsOneWidget);
        await tester.pageBack();
        await tester.pumpAndSettle();
      }
    });

    testWidgets('the match room fits at text scale $scale', (tester) async {
      final rooms = [
        matchRoomJson(opponentCheckedIn: true),
        matchRoomJson(lifecycle: 'report_required'),
        matchRoomJson(
          lifecycle: 'confirmation_required',
          submitted: submittedJson(
            1,
            1,
            penalties: {'type': 'penalties', 'homeScore': 4, 'awayScore': 5},
          ),
        ),
        matchRoomJson(lifecycle: 'screenshot_required'),
        matchRoomJson(lifecycle: 'report_required', bestOf: 5),
        matchRoomJson(
          lifecycle: 'screenshot_required',
          bestOf: 5,
          submitted: submittedJson(3, 2),
        ),
        matchRoomJson(
          lifecycle: 'forfeited',
          outcome: 'won',
          completionReason: 'response_timeout',
        ),
      ];
      for (final room in rooms) {
        // A fresh app for each room.
        await tester.pumpWidget(const SizedBox());
        await pumpTonits(
          tester,
          size: small,
          textScale: scale,
          refreshToken: 'stored',
          api: FakeApi(
            routes: {
              '/v1/matches/m1': (_) => jsonResponse({'data': room}, 200),
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
        await tester.tap(find.text('vs Amina Otieno'));
        await tester.pumpAndSettle();
        await scrollPageTo(tester, find.text('Match info'));
        if (room['lifecycle'] == 'report_required') {
          await tester.drag(
            find.byType(Scrollable).first,
            const Offset(0, 2000),
          );
          await tester.pumpAndSettle();
          await Scrollable.ensureVisible(
            tester.element(find.text('Report the score')),
            alignment: 0.5,
          );
          await tester.pumpAndSettle();
          await tester.tap(find.text('Report the score'));
          await tester.pumpAndSettle();
          await scrollPageTo(tester, find.text('Send score'));
        }
      }
    });

    testWidgets('the inbox fits at text scale $scale', (tester) async {
      await pumpTonits(
        tester,
        size: small,
        textScale: scale,
        refreshToken: 'stored',
      );
      await tester.tap(find.byTooltip('Notifications'));
      await tester.pumpAndSettle();
      expect(find.text('Mark all read'), findsOneWidget);
      await tester.tap(find.text('Payment received'));
      await tester.pumpAndSettle();
    });
  }
}
