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

Future<void> _shoot(WidgetTester tester, String name) async {
  await tester.pumpAndSettle();
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

    testWidgets('signed out ($suffix)', skip: skip, (tester) async {
      await _pump(tester, brightness: brightness, height: 1000);
      await _shoot(tester, 'sign-in-$suffix');
      await tester.tap(find.text('Create an account'));
      await _shoot(tester, 'register-$suffix');
      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Forgot password?'));
      await _shoot(tester, 'forgot-password-$suffix');
    });

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
