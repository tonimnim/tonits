import 'package:flutter/foundation.dart';

/// Build-time configuration, set with `--dart-define`.
///
/// `flutter run --dart-define=API_URL=http://192.168.1.20:8090`
///
/// - Android emulator: `http://10.0.2.2:8090` (the default)
/// - iOS simulator: `http://127.0.0.1:8090`
/// - physical device: `http://<backend-computer-lan-ip>:8090`
/// - production: an `https://` origin, which release builds require
abstract final class AppConfig {
  static const apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://10.0.2.2:8090',
  );

  /// Where players write for help, `--dart-define=SUPPORT_EMAIL=…`. Profile
  /// leaves its Support row out while it's empty.
  static const supportEmail = String.fromEnvironment('SUPPORT_EMAIL');

  /// Stops a release build that would talk to a development server: both
  /// platforms block plain http in release, so every request would fail.
  static void checkForRelease({
    String url = apiUrl,
    bool release = kReleaseMode,
  }) {
    if (release && !url.startsWith('https://')) {
      throw StateError(
        'Release builds need --dart-define=API_URL=https://… (got $url). '
        'See docs/release.md.',
      );
    }
  }
}
