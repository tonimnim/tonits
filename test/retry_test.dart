import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/core/api/api_client.dart';
import 'package:tonits/core/api/retry.dart';

ApiException _status(int status, {Duration? retryAfter}) => ApiException(
  status: status,
  code: 'code',
  message: '',
  retryAfter: retryAfter,
);

void main() {
  test('answers that will not change show at once', () {
    for (final status in [400, 401, 403, 404, 409, 422]) {
      expect(retryApiLoad(0, _status(status)), isNull, reason: '$status');
    }
    expect(retryApiLoad(0, StateError('bug')), isNull);
  });

  test('a dropped connection or a server error gets two quick retries', () {
    for (final error in [NetworkException('offline'), _status(503)]) {
      expect(retryApiLoad(0, error), const Duration(seconds: 1));
      expect(retryApiLoad(1, error), const Duration(seconds: 2));
      expect(retryApiLoad(2, error), isNull);
    }
    expect(retryApiLoad(0, _status(408)), const Duration(seconds: 1));
  });

  test('a rate limit waits as asked, unless that is long', () {
    expect(
      retryApiLoad(0, _status(429, retryAfter: const Duration(seconds: 3))),
      const Duration(seconds: 3),
    );
    expect(
      retryApiLoad(0, _status(429, retryAfter: const Duration(minutes: 1))),
      isNull,
    );
    expect(retryApiLoad(0, _status(429)), const Duration(seconds: 1));
  });
}
