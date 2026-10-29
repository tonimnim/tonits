import 'package:flutter/foundation.dart';

/// Sends every uncaught error, from the framework or from async code,
/// through [report]: the one place crash reporting plugs in.
void catchUncaughtErrors() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    report(details.exception, details.stack ?? StackTrace.empty);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    report(error, stack);
    return true;
  };
}

/// An error nothing handled. Logged for now; a crash reporter (Crashlytics
/// or Sentry) records it here once one is set up.
void report(Object error, StackTrace stack) {
  debugPrint('Uncaught: $error\n$stack');
}
