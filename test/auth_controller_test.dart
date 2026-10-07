import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:tonits/core/api/api_client.dart';
import 'package:tonits/features/auth/auth_controller.dart';
import 'package:tonits/features/auth/auth_repository.dart';

import 'fakes.dart';

typedef Handler = Future<http.Response> Function(http.Request request);

AuthController controller(Handler handler, MemoryTokenStore store) {
  final api = ApiClient(
    baseUrl: 'http://api.test',
    httpClient: MockClient(handler),
  );
  return AuthController(
    api: api,
    repository: AuthRepository(api),
    tokenStore: store,
  );
}

void main() {
  test('restore without a stored token signs out', () async {
    final auth = controller(
      (_) async => fail('no request expected'),
      MemoryTokenStore(),
    );

    await auth.restore();

    expect(auth.status, AuthStatus.signedOut);
  });

  test('restore rotates the stored refresh token', () async {
    final store = MemoryTokenStore('refresh-0');
    final auth = controller((request) async {
      expect(request.url.path, '/v1/auth/refresh');
      expect(jsonDecode(request.body), {'refreshToken': 'refresh-0'});
      return jsonResponse(sessionJson(refresh: 'refresh-1'), 200);
    }, store);

    await auth.restore();

    expect(auth.status, AuthStatus.signedIn);
    expect(auth.player!.username, 'striker.9');
    expect(store.token, 'refresh-1');
  });

  test('restore clears a rejected refresh token', () async {
    final store = MemoryTokenStore('revoked');
    final auth = controller(
      (_) async => errorResponse(401, 'invalid_refresh_token'),
      store,
    );

    await auth.restore();

    expect(auth.status, AuthStatus.signedOut);
    expect(store.token, isNull);
  });

  test('restore keeps the token when the API is unreachable', () async {
    final store = MemoryTokenStore('refresh-0');
    final auth = controller(
      (_) async => throw http.ClientException('offline'),
      store,
    );

    await auth.restore();

    expect(auth.status, AuthStatus.unreachable);
    expect(store.token, 'refresh-0');
  });

  test(
    'register saves the chosen country after creating the account',
    () async {
      final requests = <String>[];
      final auth = controller((request) async {
        requests.add('${request.method} ${request.url.path}');
        if (request.url.path == '/v1/auth/register') {
          expect(
            jsonDecode(request.body),
            containsPair('username', 'striker.9'),
          );
          return jsonResponse(sessionJson(), 201);
        }
        expect(request.headers['Authorization'], 'Bearer access-1');
        expect(jsonDecode(request.body), {'countryCode': 'IN'});
        return jsonResponse(playerJson(countryCode: 'IN'), 200);
      }, MemoryTokenStore());

      await auth.register(
        username: 'striker.9',
        konamiId: 'ABCD-1234-EFGH',
        password: 'correct horse',
        countryCode: 'IN',
      );

      expect(requests, ['POST /v1/auth/register', 'PATCH /v1/me']);
      expect(auth.status, AuthStatus.signedIn);
      expect(auth.player!.countryCode, 'IN');
      expect(auth.pendingCountryCode, isNull);
    },
  );

  test(
    'register stays signed in and remembers the country if saving it fails',
    () async {
      final auth = controller((request) async {
        if (request.url.path == '/v1/auth/register') {
          return jsonResponse(sessionJson(), 201);
        }
        return errorResponse(503, 'database_unavailable');
      }, MemoryTokenStore());

      await auth.register(
        username: 'striker.9',
        konamiId: 'ABCD-1234-EFGH',
        password: 'correct horse',
        countryCode: 'US',
      );

      expect(auth.status, AuthStatus.signedIn);
      expect(auth.pendingCountryCode, 'US');
    },
  );

  test('a 401 mid-session rotates the token and retries', () async {
    final store = MemoryTokenStore();
    var meCalls = 0;
    final auth = controller((request) async {
      switch (request.url.path) {
        case '/v1/auth/login':
          return jsonResponse(sessionJson(access: 'old', refresh: 'r1'), 200);
        case '/v1/auth/refresh':
          return jsonResponse(sessionJson(access: 'new', refresh: 'r2'), 200);
        default:
          meCalls++;
          return request.headers['Authorization'] == 'Bearer new'
              ? jsonResponse(playerJson(), 200)
              : errorResponse(401, 'invalid_token');
      }
    }, store);

    await auth.signIn(konamiId: 'ABCD-1234-EFGH', password: 'correct horse');
    final player = await auth.repository.currentPlayer();

    expect(player.username, 'striker.9');
    expect(meCalls, 2);
    expect(store.token, 'r2');
  });

  test('sign out ends the local session even if the API call fails', () async {
    final store = MemoryTokenStore();
    final auth = controller((request) async {
      if (request.url.path == '/v1/auth/login') {
        return jsonResponse(sessionJson(), 200);
      }
      throw http.ClientException('offline');
    }, store);
    await auth.signIn(konamiId: 'ABCD-1234-EFGH', password: 'correct horse');

    await auth.signOut();

    expect(auth.status, AuthStatus.signedOut);
    expect(store.token, isNull);
  });
}
