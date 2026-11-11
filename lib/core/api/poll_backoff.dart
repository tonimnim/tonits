import 'dart:math';

import 'api_client.dart';

/// How long a screen that reads on a timer waits before its next read.
///
/// After a failure it waits longer each time (up to [maxWait]), and at least
/// as long as a `429`'s `Retry-After` asks, so a phone offline or an API
/// under strain isn't hammered every few seconds. An answer that won't
/// change on its own (a 403, a 404) stops the timer: the next read comes
/// when the screen is shown again or refreshed.
class PollBackoff {
  int _failures = 0;
  Duration? _asked;
  bool _stopped = false;

  static const maxWait = Duration(minutes: 1);

  /// True after an answer that reading again won't change.
  bool get stopped => _stopped;

  void succeeded() {
    _failures = 0;
    _asked = null;
    _stopped = false;
  }

  void failed(Object error) {
    if (error is ApiException &&
        error.status >= 400 &&
        error.status < 500 &&
        error.status != 408 &&
        error.status != 429) {
      _stopped = true;
      return;
    }
    _failures++;
    _asked = error is ApiException ? error.retryAfter : null;
  }

  /// The wait before the next read, for a screen that reads every
  /// [interval] while all is well.
  Duration next(Duration interval) {
    if (_failures == 0) return interval;
    final grown = interval * (1 << min(_failures, 4));
    final wait = grown > maxWait ? maxWait : grown;
    final asked = _asked;
    return asked != null && asked > wait ? asked : wait;
  }
}
