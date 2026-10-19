import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/app/shell/tonits_navigation_bar.dart';

import 'support/fakes.dart';
import 'support/harness.dart';

/// Every screen must fit a small phone, including with enlarged text. Any
/// overflow fails the test.
void main() {
  const small = Size(360, 740);

  for (final scale in [1.0, 1.3]) {
    testWidgets('signed-out screens fit at text scale $scale', (tester) async {
      await pumpTonits(tester, size: small, textScale: scale);
      expect(find.text('Welcome back'), findsOneWidget);

      await tester.tap(find.text('Create an account'));
      await tester.pumpAndSettle();
      expect(find.text('Create your account'), findsOneWidget);

      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Forgot password?'));
      await tester.pumpAndSettle();
      expect(find.text('Reset password'), findsOneWidget);
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
      await scrollPageTo(tester, find.text('Closing soon'));

      for (final tab in ['Compete', 'Matches', 'Rankings', 'Profile']) {
        await tester.tap(
          find.descendant(
            of: find.byType(TonitsNavigationBar),
            matching: find.text(tab),
          ),
        );
        await tester.pumpAndSettle();
      }
      // Build the whole Profile page too.
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
      await tester.tap(
        find.descendant(
          of: find.byType(TonitsNavigationBar),
          matching: find.text('Profile'),
        ),
      );
      await tester.pumpAndSettle();
      for (final (row, title) in [
        ('Display name', 'Display name'),
        ('Email', 'Email'),
        ('Phone', 'Phone number'),
        ('Password', 'Password'),
      ]) {
        await scrollPageTo(tester, find.text(row));
        await tester.ensureVisible(find.text(row).last);
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
  }
}
