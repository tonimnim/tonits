import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:tonits/core/api/api_client.dart';
import 'package:tonits/core/providers.dart';
import 'package:tonits/features/auth/application/auth_controller.dart';
import 'package:tonits/features/auth/data/auth_repository.dart';
import 'package:tonits/features/auth/data/models.dart';

import 'support/fakes.dart';

typedef Handler = Future<http.Response> Function(http.Request request);

/// The auth controller in its own provider container, with a fake API.
class Auth {
  Auth(Handler handler, MemoryTokenStore store)
    : container = ProviderContainer(
        overrides: [
          apiClientProvider.overrideWithValue(
            ApiClient(
              baseUrl: 'http://api.test',
              httpClient: MockClient(handler),
            ),
          ),
          tokenStoreProvider.overrideWithValue(store),
        ],
      ) {
    addTearDown(container.dispose);
  }

  final ProviderContainer container;

  AuthController get _notifier =>
      container.read(authControllerProvider.notifier);
  AuthState get _state => container.read(authControllerProvider);

  AuthStatus get status => _state.status;
  Player? get player => _state.player;
  String? get pendingCountryCode => _state.pendingCountryCode;
  AuthRepository get repository => container.read(authRepositoryProvider);

  Future<void> restore() => _notifier.restore();
  Future<void> signOut() => _notifier.signOut();
  String? get pendingRecoveryCode => _state.pendingRecoveryCode;
  bool get recoveryCodeReplacesOld => _state.recoveryCodeReplacesOld;
  void acknowledgeRecoveryCode() => _notifier.acknowledgeRecoveryCode();
  Future<void> resetWithRecoveryCode({
    required String konamiId,
    required String recoveryCode,
    required String newPassword,
  }) => _notifier.resetWithRecoveryCode(
    konamiId: konamiId,
    recoveryCode: recoveryCode,
    newPassword: newPassword,
  );
  Future<String> createRecoveryCode(String password) =>
      _notifier.createRecoveryCode(password: password);
  Future<void> signIn({required String konamiId, required String password}) =>
      _notifier.signIn(konamiId: konamiId, password: password);
  Future<void> register({
    required String username,
    required String konamiId,
    required String password,
    required String countryCode,
  }) => _notifier.register(
    username: username,
    konamiId: konamiId,
    password: password,
    countryCode: countryCode,
  );
}

Auth controller(Handler handler, MemoryTokenStore store) =>
    Auth(handler, store);

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

  test('registering holds the first recovery code until it is saved', () async {
    final auth = controller((request) async {
      if (request.url.path == '/v1/auth/register') {
        return jsonResponse(sessionJson(recoveryCode: firstRecoveryCode), 201);
      }
      return jsonResponse(playerJson(countryCode: 'IN'), 200);
    }, MemoryTokenStore());

    await auth.register(
      username: 'striker.9',
      konamiId: 'ABCD-1234-EFGH',
      password: 'correct horse',
      countryCode: 'IN',
    );

    expect(auth.status, AuthStatus.signedIn);
    expect(auth.pendingRecoveryCode, firstRecoveryCode);
    expect(auth.recoveryCodeReplacesOld, isFalse);
    // Saving the country afterwards keeps the code pending.
    expect(auth.player!.countryCode, 'IN');

    auth.acknowledgeRecoveryCode();
    expect(auth.pendingRecoveryCode, isNull);
    expect(auth.status, AuthStatus.signedIn);
  });

  test(
    'a recovery-code reset signs in and holds the replacement code',
    () async {
      final store = MemoryTokenStore();
      final auth = controller((request) async {
        expect(request.url.path, '/v1/auth/password-reset/recovery-code');
        final body = jsonDecode(request.body) as Map<String, dynamic>;
        expect(body['konamiId'], 'ABCD-1234-EFGH');
        expect(body['recoveryCode'], firstRecoveryCode);
        expect(body['newPassword'], 'brand new pass');
        return jsonResponse(
          sessionJson(refresh: 'r9', recoveryCode: nextRecoveryCode),
          200,
        );
      }, store);

      await auth.resetWithRecoveryCode(
        konamiId: 'ABCD-1234-EFGH',
        recoveryCode: firstRecoveryCode,
        newPassword: 'brand new pass',
      );

      expect(auth.status, AuthStatus.signedIn);
      expect(store.token, 'r9');
      expect(auth.pendingRecoveryCode, nextRecoveryCode);
      expect(auth.recoveryCodeReplacesOld, isTrue);
    },
  );

  test('a wrong recovery code stays signed out with the API error', () async {
    final auth = controller(
      (_) async => errorResponse(401, 'invalid_recovery_code'),
      MemoryTokenStore(),
    );

    await expectLater(
      auth.resetWithRecoveryCode(
        konamiId: 'ABCD-1234-EFGH',
        recoveryCode: firstRecoveryCode,
        newPassword: 'brand new pass',
      ),
      throwsA(
        isA<ApiException>().having(
          (e) => e.code,
          'code',
          'invalid_recovery_code',
        ),
      ),
    );
    expect(auth.status, isNot(AuthStatus.signedIn));
  });

  test('a new code from the account marks the player as having one', () async {
    final auth = controller((request) async {
      if (request.url.path == '/v1/auth/login') {
        return jsonResponse(sessionJson(recoveryCodeSet: false), 200);
      }
      expect(request.url.path, '/v1/me/recovery-code');
      expect(jsonDecode(request.body), {'password': 'correct horse'});
      return jsonResponse({
        'recoveryCode': nextRecoveryCode,
        'createdAt': '2026-10-18T09:00:00Z',
      }, 200);
    }, MemoryTokenStore());
    await auth.signIn(konamiId: 'ABCD-1234-EFGH', password: 'correct horse');
    expect(auth.player!.canRecoverAccount, isFalse);

    final code = await auth.createRecoveryCode('correct horse');

    expect(code, nextRecoveryCode);
    expect(auth.player!.recoveryCodeSet, isTrue);
    expect(auth.player!.canRecoverAccount, isTrue);
    // Shown by the caller, not held as pending.
    expect(auth.pendingRecoveryCode, isNull);
  });

  test('the country goes with registration, in one call', () async {
    final requests = <String>[];
    final auth = controller((request) async {
      requests.add('${request.method} ${request.url.path}');
      expect(jsonDecode(request.body), containsPair('countryCode', 'US'));
      return jsonResponse({
        ...sessionJson(recoveryCode: firstRecoveryCode),
        'player': playerJson(countryCode: 'US'),
      }, 201);
    }, MemoryTokenStore());

    await auth.register(
      username: 'striker.9',
      konamiId: 'ABCD-1234-EFGH',
      password: 'correct horse',
      countryCode: 'US',
    );

    expect(requests, ['POST /v1/auth/register']);
    expect(auth.player!.countryCode, 'US');
    expect(auth.pendingCountryCode, isNull);
  });
}
