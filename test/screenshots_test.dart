// Renders app screens to PNG files at phone size with the real fonts, for
// design review without an emulator. Skipped unless asked for:
//
//   flutter test test/screenshots_test.dart --dart-define=SCREENSHOTS=build/screenshots
@Tags(['screenshots'])
library;

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/app/shell/tonits_navigation_bar.dart';
import 'package:tonits/features/payments/application/checkout_controller.dart';

import 'support/fakes.dart';
import 'support/harness.dart';

const _outDir = String.fromEnvironment('SCREENSHOTS');
const _key = Key('screenshot');

Future<void> _loadFonts() async {
  Future<void> load(String family, List<String> files) async {
    final loader = FontLoader(family);
    for (final file in files) {
      loader.addFont(rootBundle.load(file));
    }
    await loader.load();
  }

  const fonts = 'assets/fonts';
  const weights = ['Regular', 'Medium', 'SemiBold', 'Bold', 'Black'];
  await load('Geist', [for (final w in weights) '$fonts/Geist-$w.ttf']);
  await load('GeistMono', [for (final w in weights) '$fonts/GeistMono-$w.ttf']);
  await load('Alexandria', ['$fonts/Alexandria-Variable.ttf']);
  // Material Icons ships with the SDK rather than the app's assets.
  final sdk =
      Platform.environment['FLUTTER_ROOT'] ??
      File(Platform.resolvedExecutable).parent.parent.parent.parent.parent.path;
  final icons = File(
    '$sdk/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
  );
  if (icons.existsSync()) {
    final loader = FontLoader('MaterialIcons')
      ..addFont(Future.value(ByteData.sublistView(icons.readAsBytesSync())));
    await loader.load();
  }
}

/// [settle] waits for animations to finish; screens with a spinner never
/// settle, so they are captured after a short pump instead.
Future<void> _shoot(
  WidgetTester tester,
  String name, {
  bool settle = true,
}) async {
  if (settle) {
    await tester.pumpAndSettle();
  } else {
    await tester.pump(const Duration(milliseconds: 300));
  }
  final boundary = tester.renderObject<RenderRepaintBoundary>(find.byKey(_key));
  final image = await tester.runAsync(() => boundary.toImage(pixelRatio: 2));
  final bytes = await tester.runAsync(
    () => image!.toByteData(format: ui.ImageByteFormat.png),
  );
  File('$_outDir/$name.png')
    ..createSync(recursive: true)
    ..writeAsBytesSync(bytes!.buffer.asUint8List());
}

Future<void> _pump(
  WidgetTester tester, {
  required Brightness brightness,
  String? refreshToken,
  double height = 844,
  FakeApi? api,
}) async {
  await tester.runAsync(_loadFonts);
  await pumpTonits(
    tester,
    api: api,
    // Long enough that a waiting payment stays waiting for the shot.
    overrides: [
      paymentPollIntervalProvider.overrideWithValue(const Duration(hours: 1)),
    ],
    brightness: brightness,
    refreshToken: refreshToken,
    size: Size(390, height),
    wrap: (app) => RepaintBoundary(key: _key, child: app),
  );
}

Future<void> _openTab(WidgetTester tester, String label) async {
  await tester.tap(
    find.descendant(
      of: find.byType(TonitsNavigationBar),
      matching: find.text(label),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  final skip = _outDir.isEmpty;

  for (final brightness in Brightness.values) {
    final suffix = brightness.name;

    testWidgets('welcome ($suffix)', skip: skip, (tester) async {
      await _pump(tester, brightness: brightness);
      await _shoot(tester, 'welcome-$suffix');
    });

    testWidgets('onboarding ($suffix)', skip: skip, (tester) async {
      await _pump(
        tester,
        brightness: brightness,
        refreshToken: 'stored',
        api: FakeApi(
          routes: {
            '/v1/auth/refresh': (_) =>
                jsonResponse(sessionJson(onboarded: false), 200),
          },
        ),
      );
      for (final (name, value) in [
        ('username', null),
        ('konami-id', 'ABCD-1234-EFGH'),
        ('country', null),
        ('phone', '(512) 555-0134'),
      ]) {
        if (value != null) {
          await tester.enterText(find.byType(TextFormField), value);
        }
        await _shoot(tester, 'onboarding-$name-$suffix');
        if (name == 'phone') break;
        await tester.tap(find.text('Continue'));
        await tester.pumpAndSettle();
      }
    });

    testWidgets('entry ($suffix)', skip: skip, (tester) async {
      await _pump(tester, brightness: brightness, refreshToken: 'stored');
      await _openTab(tester, 'Compete');
      await tester.tap(find.text('Nairobi Weekend Cup'));
      await _shoot(tester, 'competition-free-$suffix');
      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Mombasa Masters'));
      await _shoot(tester, 'competition-paid-$suffix');
      await tester.tap(find.text('Pay Ksh 100 with M-Pesa'));
      await _shoot(tester, 'checkout-form-$suffix');
      await tester.enterText(
        find.widgetWithText(TextFormField, '0712 345 678'),
        '0712345678',
      );
      await tester.tap(find.text('Send payment request'));
      await tester.pump();
      await tester.pump();
      await _shoot(tester, 'checkout-waiting-$suffix', settle: false);
      // Leaving the checkout stops its polling.
      await tester.pageBack();
      await tester.pump(const Duration(milliseconds: 500));
    });

    testWidgets('entry outside Kenya ($suffix)', skip: skip, (tester) async {
      await _pump(
        tester,
        brightness: brightness,
        refreshToken: 'stored',
        api: FakeApi(
          routes: {
            '/v1/auth/refresh': (_) => jsonResponse({
              ...sessionJson(),
              'player': playerJson(countryCode: 'IN'),
            }, 200),
            '/v1/competitions/c2/eligibility': (_) => jsonResponse(
              eligibilityJson(
                status: 'ineligible',
                action: 'none',
                fee: 10000,
                issues: [
                  issueJson(
                    'country_not_allowed',
                    'Paid entry uses M-Pesa, which is only available to '
                        'players in Kenya.',
                  ),
                ],
              ),
              200,
            ),
          },
        ),
      );
      await _openTab(tester, 'Compete');
      await _shoot(tester, 'competitions-india-$suffix');
      await tester.tap(find.text('Mombasa Masters'));
      await _shoot(tester, 'competition-paid-india-$suffix');
    });

    // Each outcome the server can settle a payment with.
    for (final (name, status, registration, message) in [
      ('registered', 'succeeded', 'registered', null),
      ('declined', 'failed', 'not_registered', 'Request cancelled by user'),
      ('review', 'review', 'pending', null),
      ('refund', 'succeeded', 'refund_pending', null),
    ]) {
      testWidgets('payment $name ($suffix)', skip: skip, (tester) async {
        await _pump(
          tester,
          brightness: brightness,
          refreshToken: 'stored',
          api: FakeApi(
            routes: {
              '/v1/payments/mpesa/stk-push': (_) => jsonResponse(
                paymentJson(
                  status: status,
                  registrationStatus: registration,
                  providerMessage: message,
                ),
                202,
              ),
            },
          ),
        );
        await _openTab(tester, 'Compete');
        await tester.tap(find.text('Mombasa Masters'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Pay Ksh 100 with M-Pesa'));
        await tester.pumpAndSettle();
        await tester.enterText(
          find.widgetWithText(TextFormField, '0712 345 678'),
          '0712345678',
        );
        await tester.tap(find.text('Send payment request'));
        await _shoot(tester, 'payment-$name-$suffix');
      });
    }

    testWidgets('profile ($suffix)', skip: skip, (tester) async {
      await _pump(
        tester,
        brightness: brightness,
        refreshToken: 'stored',
        height: 1560,
      );
      await _openTab(tester, 'Profile');
      await _shoot(tester, 'profile-$suffix');
    });

    testWidgets('profile, all set ($suffix)', skip: skip, (tester) async {
      final player = playerJson(
        displayName: 'Amina Otieno',
        email: 'amina@example.com',
        phoneNumber: '+254712345678',
      );
      await _pump(
        tester,
        brightness: brightness,
        refreshToken: 'stored',
        height: 1240,
        api: FakeApi(
          routes: {
            '/v1/auth/refresh': (_) =>
                jsonResponse(sessionJson(player: player), 200),
            '/v1/me': (_) => jsonResponse(player, 200),
          },
        ),
      );
      await _openTab(tester, 'Profile');
      await _shoot(tester, 'profile-complete-$suffix');

      // The edit screens, opened from their rows.
      Future<void> open(String row, String name) async {
        await tester.ensureVisible(find.text(row).last);
        await tester.pumpAndSettle();
        await tester.tap(find.text(row).last);
        await _shoot(tester, name);
        await tester.pageBack();
        await tester.pumpAndSettle();
      }

      await open('Display name', 'account-name-$suffix');
      await open('Email', 'account-email-$suffix');
      await open('+254712345678', 'account-phone-$suffix');
    });

    testWidgets('email code ($suffix)', skip: skip, (tester) async {
      await _pump(
        tester,
        brightness: brightness,
        refreshToken: 'stored',
        api: FakeApi(
          routes: {
            '/v1/me/email': (_) => jsonResponse({'expiresInSeconds': 600}, 202),
          },
        ),
      );
      await _openTab(tester, 'Profile');
      await tester.ensureVisible(find.text('Email'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Email'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.widgetWithText(TextFormField, 'you@example.com'),
        'amina@example.com',
      );
      await tester.tap(find.text('Send code'));
      await _shoot(tester, 'account-email-code-$suffix');
    });

    for (final (name, room) in [
      ('check-in', matchRoomJson(opponentCheckedIn: true)),
      ('play', matchRoomJson(lifecycle: 'report_required')),
      (
        'confirm',
        matchRoomJson(
          lifecycle: 'confirmation_required',
          submitted: submittedJson(1, 2),
        ),
      ),
      (
        'screenshot',
        matchRoomJson(
          lifecycle: 'screenshot_required',
          submitted: submittedJson(1, 2),
        ),
      ),
      (
        'won',
        matchRoomJson(
          lifecycle: 'completed',
          outcome: 'won',
          completionReason: 'played',
          submitted: submittedJson(3, 1, byMe: true),
          result: {
            'homeScore': 3,
            'awayScore': 1,
            'tiebreak': null,
            'origin': 'agreed_reports',
            'confirmedAt': '2026-10-14T19:00:00Z',
          },
        ),
      ),
    ]) {
      testWidgets('match room, $name ($suffix)', skip: skip, (tester) async {
        await _pump(
          tester,
          brightness: brightness,
          refreshToken: 'stored',
          height: name == 'won' ? 844 : 1240,
          api: FakeApi(
            routes: {
              '/v1/matches/m1': (_) => jsonResponse({'data': room}, 200),
            },
          ),
        );
        await _openTab(tester, 'Matches');
        await tester.tap(find.text('vs Amina Otieno'));
        await _shoot(tester, 'match-$name-$suffix');
        if (name == 'play') {
          await tester.tap(find.text('Report the score'));
          await tester.pumpAndSettle();
          for (var i = 0; i < 2; i++) {
            await tester.tap(
              find
                  .byWidgetPredicate(
                    (w) => w is Tooltip && w.message == 'One more for You',
                  )
                  .first,
            );
            await tester.pump();
          }
          await _shoot(tester, 'match-report-$suffix');
        }
      });
    }

    testWidgets('home, whole page ($suffix)', skip: skip, (tester) async {
      await _pump(
        tester,
        brightness: brightness,
        refreshToken: 'stored',
        height: 1960,
      );
      await _shoot(tester, 'home-full-$suffix');
    });

    testWidgets('home, new player ($suffix)', skip: skip, (tester) async {
      await _pump(
        tester,
        brightness: brightness,
        refreshToken: 'stored',
        api: FakeApi(
          routes: {
            '/v1/players/$myPlayerId': (_) => jsonResponse(
              profileJson(wins: 0, draws: 0, losses: 0, rated: false),
              200,
            ),
            '/v1/players/$myPlayerId/matches': (_) =>
                jsonResponse(pageJson([]), 200),
            '/v1/me/matches': (_) => jsonResponse(pageJson([]), 200),
          },
        ),
      );
      await _shoot(tester, 'home-new-player-$suffix');
    });

    testWidgets('tabs ($suffix)', skip: skip, (tester) async {
      await _pump(
        tester,
        brightness: brightness,
        refreshToken: 'stored',
        height: 1000,
      );
      await _shoot(tester, 'home-$suffix');
      for (final (label, name) in [
        ('Compete', 'competitions'),
        ('Matches', 'matches'),
        ('Rankings', 'rankings'),
        ('Profile', 'profile'),
      ]) {
        await _openTab(tester, label);
        await _shoot(tester, '$name-$suffix');
      }
    });
  }
}
