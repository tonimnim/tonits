import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

/// Runs before every test file. A tap that misses its widget fails the test
/// instead of silently doing nothing.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  WidgetController.hitTestWarningShouldBeFatal = true;
  await testMain();
}
