import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:tonits/core/api/api_client.dart';
import 'package:tonits/core/providers.dart';
import 'package:tonits/features/auth/application/auth_controller.dart';
import 'package:tonits/features/auth/application/auth_providers.dart';

import 'support/fakes.dart';

typedef Handler = Future<http.Response> Function(http.Request request);

/// The auth controller in its own provider container, with a fake API and
/// fake account pickers.
class Auth {
  Auth(
    Handler handler,
    MemoryTokenStore store, {
    FakeIdentity? google,
    FakeIdentity? apple,
  }) : google = google ?? FakeIdentity('google-token'),
       apple = apple ?? FakeIdentity('apple-token', nonce: 'raw-nonce') {
    container = ProviderContainer(
      overrides: [
        apiClientProvider.overrideWithValue(
          ApiClient(
            baseUrl: 'http://api.test',
            httpClient: MockClient(handler),
          ),
        ),
        tokenStoreProvider.overrideWithValue(store),
        googleIdentityProvider.overrideWithValue(this.google),
        appleIdentityProvider.overrideWithValue(this.apple),
      ],
    );
    addTearDown(container.dispose);
  }

  late final ProviderContainer container;
  final FakeIdentity google;
  final FakeIdentity apple;

  AuthController get notifier =>
      container.read(authControllerProvider.notifier);
  AuthState get state => container.read(authControllerProvider);
}

void main() {
  test('restore without a stored token signs out', () async {
    final auth = Auth(
      (_) async => fail('no request expected'),
      MemoryTokenStore(),
    );

    await auth.notifier.restore();

    expect(auth.state.status, AuthStatus.signedOut);
  });

  test('restore rotates the stored refresh token', () async {
    final store = MemoryTokenStore('refresh-0');
    final auth = Auth((request) async {
      expect(request.url.path, '/v1/auth/refresh');
      expect(jsonDecode(request.body), {'refreshToken': 'refresh-0'});
      return jsonResponse(sessionJson(), 200);
    }, store);

    await auth.notifier.restore();

    expect(auth.state.status, AuthStatus.signedIn);
    expect(auth.state.player!.username, 'striker.9');
    expect(store.token, 'refresh-1');
  });

  test('restore clears a rejected refresh token', () async {
    final store = MemoryTokenStore('revoked');
    final auth = Auth(
      (_) async => errorResponse(401, 'invalid_refresh_token'),
      store,
    );

    await auth.notifier.restore();

    expect(auth.state.status, AuthStatus.signedOut);
    expect(store.token, isNull);
  });

  test('restore keeps the token when the API is unreachable', () async {
    final store = MemoryTokenStore('refresh-0');
    final auth = Auth(
      (_) async => throw http.ClientException('offline'),
      store,
    );

    await auth.notifier.restore();

    expect(auth.state.status, AuthStatus.unreachable);
    expect(store.token, 'refresh-0');
  });

  test(
    'Google sends its ID token, and a new player needs onboarding',
    () async {
      final store = MemoryTokenStore();
      final auth = Auth((request) async {
        expect(request.url.path, '/v1/auth/google');
        final body = jsonDecode(request.body) as Map<String, dynamic>;
        expect(body['idToken'], 'google-token');
        expect(body.containsKey('nonce'), isFalse);
        return jsonResponse(sessionJson(onboarded: false), 201);
      }, store);

      expect(await auth.notifier.signInWith(IdentityMethod.google), isTrue);

      expect(auth.state.status, AuthStatus.signedIn);
      expect(auth.state.needsOnboarding, isTrue);
      expect(auth.state.player!.username, newPlayerHandle);
      expect(store.token, 'refresh-1');
    },
  );

  test('Apple sends the raw nonce with its identity token', () async {
    final auth = Auth((request) async {
      expect(request.url.path, '/v1/auth/apple');
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      expect(body['identityToken'], 'apple-token');
      expect(body['nonce'], 'raw-nonce');
      return jsonResponse(sessionJson(), 200);
    }, MemoryTokenStore());

    await auth.notifier.signInWith(IdentityMethod.apple);

    expect(auth.state.needsOnboarding, isFalse);
  });

  test('closing the account picker sends nothing', () async {
    final auth = Auth(
      (_) async => fail('no request expected'),
      MemoryTokenStore(),
      google: FakeIdentity(null),
    );

    expect(await auth.notifier.signInWith(IdentityMethod.google), isFalse);
    expect(auth.state.status, AuthStatus.restoring);
  });

  test('a raced first sign-in is tried once more', () async {
    var calls = 0;
    final auth = Auth(
      (_) async => ++calls == 1
          ? errorResponse(409, 'sign_in_conflict')
          : jsonResponse(sessionJson(), 200),
      MemoryTokenStore(),
    );

    await auth.notifier.signInWith(IdentityMethod.google);

    expect(calls, 2);
    expect(auth.state.status, AuthStatus.signedIn);
  });

  test('onboarding sends a changed username and lets the player in', () async {
    final sent = <Map<String, dynamic>>[];
    final auth = Auth((request) async {
      if (request.url.path == '/v1/auth/google') {
        return jsonResponse(sessionJson(onboarded: false), 201);
      }
      expect(request.url.path, '/v1/me/onboarding');
      expect(request.headers['Authorization'], 'Bearer access-1');
      sent.add(jsonDecode(request.body) as Map<String, dynamic>);
      return jsonResponse(playerJson(), 200);
    }, MemoryTokenStore());
    await auth.notifier.signInWith(IdentityMethod.google);

    await auth.notifier.completeOnboarding(
      username: 'striker.9',
      konamiId: 'ABCD-1234-EFGH',
      phoneNumber: '+254712345678',
      countryCode: 'KE',
    );

    expect(sent.single, {
      'username': 'striker.9',
      'konamiId': 'ABCD-1234-EFGH',
      'phoneNumber': '+254712345678',
      'countryCode': 'KE',
    });
    expect(auth.state.needsOnboarding, isFalse);
  });

  test('signing out ends the session and forgets the picked account', () async {
    final store = MemoryTokenStore('refresh-0');
    final auth = Auth(
      (request) async => request.url.path == '/v1/auth/logout'
          ? http.Response('', 204)
          : jsonResponse(sessionJson(), 200),
      store,
    );
    await auth.notifier.restore();

    await auth.notifier.signOut();

    expect(auth.state.status, AuthStatus.signedOut);
    expect(store.token, isNull);
    expect(auth.google.signOuts, 1);
  });
}
