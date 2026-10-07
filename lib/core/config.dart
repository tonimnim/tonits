/// Build-time configuration, set with `--dart-define`.
///
/// `flutter run --dart-define=API_URL=http://192.168.1.20:8090`
///
/// - Android emulator: `http://10.0.2.2:8090` (the default)
/// - iOS simulator: `http://127.0.0.1:8090`
/// - physical device: `http://<backend-computer-lan-ip>:8090`
/// - production: an `https://` origin
abstract final class AppConfig {
  static const apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://10.0.2.2:8090',
  );
}
