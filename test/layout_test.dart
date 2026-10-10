import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/app/shell/tonits_navigation_bar.dart';

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
      expect(find.text('Konami ID'), findsOneWidget);
    });
  }
}
