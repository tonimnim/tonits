import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:tonits/core/api/api_client.dart';

import 'fakes.dart';

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
