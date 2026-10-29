import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/core/config.dart';

void main() {
  test('a release build refuses a plain http API', () {
    // The default API is the emulator's plain-http one.
    expect(() => AppConfig.checkForRelease(release: true), throwsStateError);
    AppConfig.checkForRelease(url: 'https://api.ozone.test', release: true);
    // Development builds keep talking to the local backend.
    AppConfig.checkForRelease();
  });
}
