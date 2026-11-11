import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/core/api/api_client.dart';
import 'package:tonits/core/api/poll_backoff.dart';

ApiException _status(int status, {Duration? retryAfter}) => ApiException(
  status: status,
  code: 'code',
  message: '',
  retryAfter: retryAfter,
);

void main() {
  const every = Duration(seconds: 4);

  test('reads on the interval while reads succeed', () {
    expect(PollBackoff().next(every), every);
  });

  test('waits longer after each failure, up to a minute', () {
    final backoff = PollBackoff();
    final waits = [
      for (var i = 0; i < 6; i++)
        (backoff..failed(NetworkException('x'))).next(every),
    ];
    expect(waits.map((d) => d.inSeconds), [8, 16, 32, 60, 60, 60]);

    backoff.succeeded();
    expect(backoff.next(every), every);
  });

  test('a rate limit waits at least as long as asked', () {
    final backoff = PollBackoff()
      ..failed(_status(429, retryAfter: const Duration(seconds: 30)));
    expect(backoff.next(every), const Duration(seconds: 30));
  });

  test('an answer that will not change stops reading', () {
    final backoff = PollBackoff()..failed(_status(404));
    expect(backoff.stopped, isTrue);
    backoff.succeeded();
    expect(backoff.stopped, isFalse);
  });
}
