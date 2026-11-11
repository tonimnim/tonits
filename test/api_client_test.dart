import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:tonits/core/api/api_client.dart';

import 'support/fakes.dart';

void main() {
  test('parses the error body, request id and Retry-After', () async {
    final api = ApiClient(
      baseUrl: 'http://api.test',
      httpClient: MockClient(
        (_) async => errorResponse(
          429,
          'rate_limited',
          headers: {'retry-after': '30', 'x-request-id': 'req-1'},
        ),
      ),
    );

    final error = await api
        .post('/v1/auth/login', body: {})
        .then<Object?>((_) => null, onError: (Object e) => e);

    expect(error, isA<ApiException>());
    final e = error as ApiException;
    expect(e.status, 429);
    expect(e.code, 'rate_limited');
    expect(e.message, 'Server says rate_limited');
    expect(e.requestId, 'req-1');
    expect(e.retryAfter, const Duration(seconds: 30));
  });

  test(
    'sends a request id and the bearer token on authenticated calls',
    () async {
      late http.BaseRequest seen;
      final api = ApiClient(
        baseUrl: 'http://api.test',
        httpClient: MockClient((request) async {
          seen = request;
          return jsonResponse({'ok': true}, 200);
        }),
      )..accessToken = 'token-1';

      await api.get('/v1/me', auth: true);

      expect(seen.headers['Authorization'], 'Bearer token-1');
      expect(seen.headers['X-Request-ID'], matches(RegExp(r'^[0-9a-f-]{36}$')));
    },
  );

  test('refreshes once for concurrent 401s and retries each request', () async {
    var refreshes = 0;
    final refreshGate = Completer<void>();
    late ApiClient api;
    api =
        ApiClient(
            baseUrl: 'http://api.test',
            httpClient: MockClient((request) async {
              return request.headers['Authorization'] == 'Bearer fresh'
                  ? jsonResponse({'ok': true}, 200)
                  : errorResponse(401, 'invalid_token');
            }),
          )
          ..accessToken = 'stale'
          ..onUnauthorized = () async {
            refreshes++;
            await refreshGate.future;
            api.accessToken = 'fresh';
            return 'fresh';
          };

    final calls = [
      api.get('/v1/me', auth: true),
      api.get('/v1/me', auth: true),
    ];
    await Future<void>.delayed(Duration.zero);
    refreshGate.complete();
    final results = await Future.wait(calls);

    expect(refreshes, 1);
    expect(results, everyElement(equals({'ok': true})));
  });

  group('keeping the session alive', () {
    test(
      'renews a token about to expire before the request goes out',
      () async {
        var now = DateTime.utc(2026, 11, 12, 12);
        final seen = <String?>[];
        var refreshes = 0;
        late ApiClient api;
        api =
            ApiClient(
                baseUrl: 'http://api.test',
                clock: () => now,
                httpClient: MockClient((request) async {
                  seen.add(request.headers['Authorization']);
                  return jsonResponse({'ok': true}, 200);
                }),
              )
              ..useAccessToken('first', expiresIn: const Duration(minutes: 15))
              ..onUnauthorized = () async {
                refreshes++;
                api.useAccessToken(
                  'second',
                  expiresIn: const Duration(minutes: 15),
                );
                return 'second';
              };

        await api.get('/v1/me', auth: true);
        now = now.add(const Duration(minutes: 14, seconds: 30));
        await api.get('/v1/me', auth: true);

        expect(refreshes, 1);
        expect(seen, ['Bearer first', 'Bearer second']);
      },
    );

    test(
      'a failed early renewal still sends the request with the token it has',
      () async {
        var now = DateTime.utc(2026, 11, 12, 12);
        String? seen;
        final api =
            ApiClient(
                baseUrl: 'http://api.test',
                clock: () => now,
                httpClient: MockClient((request) async {
                  seen = request.headers['Authorization'];
                  return jsonResponse({'ok': true}, 200);
                }),
              )
              ..useAccessToken('first', expiresIn: const Duration(minutes: 15))
              ..onUnauthorized = () async => throw NetworkException('offline');
        now = now.add(const Duration(minutes: 14, seconds: 30));

        expect(await api.get('/v1/me', auth: true), {'ok': true});
        expect(seen, 'Bearer first');
      },
    );

    test('a request out while another renewed the session retries without a second refresh', () async {
      var refreshes = 0;
      final firstOut = Completer<void>();
      final release = Completer<void>();
      late ApiClient api;
      api =
          ApiClient(
              baseUrl: 'http://api.test',
              httpClient: MockClient((request) async {
                final token = request.headers['Authorization'];
                if (request.url.path == '/v1/slow' && token == 'Bearer stale') {
                  firstOut.complete();
                  await release.future;
                }
                return token == 'Bearer fresh'
                    ? jsonResponse({'ok': true}, 200)
                    : errorResponse(401, 'invalid_access_token');
              }),
            )
            ..accessToken = 'stale'
            ..onUnauthorized = () async {
              refreshes++;
              api.accessToken = 'fresh';
              return 'fresh';
            };

      final slow = api.get('/v1/slow', auth: true);
      await firstOut.future;
      // Renews the session while the slow request is still out.
      await api.get('/v1/me', auth: true);
      release.complete();

      expect(await slow, {'ok': true});
      expect(refreshes, 1);
    });

    test('a public read answers signed out once the session is over', () async {
      final seen = <String?>[];
      var refreshes = 0;
      late ApiClient api;
      api =
          ApiClient(
              baseUrl: 'http://api.test',
              httpClient: MockClient((request) async {
                final token = request.headers['Authorization'];
                seen.add(token);
                return token == null
                    ? jsonResponse({'data': <Object>[]}, 200)
                    : errorResponse(401, 'invalid_session');
              }),
            )
            ..accessToken = 'revoked'
            ..onUnauthorized = () async {
              refreshes++;
              api.accessToken = null;
              return null;
            };

      expect(await api.get('/v1/competitions', optionalAuth: true), {
        'data': <Object>[],
      });
      expect(refreshes, 1);
      expect(seen, ['Bearer revoked', null]);
    });

    test(
      'a public read renews an expired token and keeps the player\'s view',
      () async {
        final seen = <String?>[];
        late ApiClient api;
        api =
            ApiClient(
                baseUrl: 'http://api.test',
                httpClient: MockClient((request) async {
                  final token = request.headers['Authorization'];
                  seen.add(token);
                  return token == 'Bearer fresh'
                      ? jsonResponse({'reminderSet': true}, 200)
                      : errorResponse(401, 'invalid_access_token');
                }),
              )
              ..accessToken = 'expired'
              ..onUnauthorized = () async {
                api.accessToken = 'fresh';
                return 'fresh';
              };

        expect(await api.get('/v1/competitions/c-1', optionalAuth: true), {
          'reminderSet': true,
        });
        expect(seen, ['Bearer expired', 'Bearer fresh']);
      },
    );

    test(
      'a public read signed out sends no token and never refreshes',
      () async {
        String? seen = 'unset';
        var refreshes = 0;
        final api =
            ApiClient(
                baseUrl: 'http://api.test',
                httpClient: MockClient((request) async {
                  seen = request.headers['Authorization'];
                  return jsonResponse({'data': <Object>[]}, 200);
                }),
              )
              ..onUnauthorized = () async {
                refreshes++;
                return null;
              };

        await api.get('/v1/competitions', optionalAuth: true);

        expect(seen, isNull);
        expect(refreshes, 0);
      },
    );

    test('a public read still answers when the refresh itself fails', () async {
      final seen = <String?>[];
      final api =
          ApiClient(
              baseUrl: 'http://api.test',
              httpClient: MockClient((request) async {
                final token = request.headers['Authorization'];
                seen.add(token);
                return token == null
                    ? jsonResponse({'data': <Object>[]}, 200)
                    : errorResponse(401, 'invalid_access_token');
              }),
            )
            ..accessToken = 'expired'
            ..onUnauthorized = () async => throw NetworkException('offline');

      expect(await api.get('/v1/competitions', optionalAuth: true), {
        'data': <Object>[],
      });
      expect(seen, ['Bearer expired', null]);
      // A request that needs the session fails with the refresh's error.
      expect(api.get('/v1/me', auth: true), throwsA(isA<NetworkException>()));
    });

    test('the timeout covers the whole exchange, not each half', () async {
      final api = ApiClient(
        baseUrl: 'http://api.test',
        timeout: const Duration(milliseconds: 100),
        httpClient: MockClient.streaming((request, body) async {
          // Headers after 60 ms, then a body that takes another 60 ms: each
          // half is under the timeout, the whole is over it.
          await Future<void>.delayed(const Duration(milliseconds: 60));
          return http.StreamedResponse(
            Stream.fromFuture(
              Future.delayed(
                const Duration(milliseconds: 60),
                () => '{}'.codeUnits,
              ),
            ),
            200,
          );
        }),
      );

      expect(api.get('/v1/games'), throwsA(isA<NetworkException>()));
    });

    test('a required session still fails once it is over', () async {
      final api =
          ApiClient(
              baseUrl: 'http://api.test',
              httpClient: MockClient(
                (_) async => errorResponse(401, 'invalid_session'),
              ),
            )
            ..accessToken = 'revoked'
            ..onUnauthorized = () async => null;

      expect(
        api.get('/v1/me', auth: true),
        throwsA(isA<ApiException>().having((e) => e.status, 'status', 401)),
      );
    });
  });

  test('wraps transport failures in NetworkException', () async {
    final api = ApiClient(
      baseUrl: 'http://api.test',
      httpClient: MockClient(
        (_) async => throw http.ClientException('offline'),
      ),
    );

    expect(api.get('/v1/games'), throwsA(isA<NetworkException>()));
  });

  test('newUuid produces version 4 UUIDs', () {
    expect(
      newUuid(),
      matches(
        RegExp(
          r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
        ),
      ),
    );
  });
}
