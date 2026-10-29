import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/errors.dart';
import '../../../core/providers.dart';
import '../../notifications/application/notifications_providers.dart';
import '../data/auth_repository.dart';
import '../data/models.dart';
import '../data/token_store.dart';
import 'auth_providers.dart';

enum AuthStatus {
  /// Checking for a stored session at launch.
  restoring,

  /// A stored session exists but the API could not be reached to resume it.
  unreachable,
  signedOut,
  signedIn,
}

enum IdentityMethod { google, apple }

@immutable
class AuthState {
  const AuthState({required this.status, this.player});

  const AuthState.restoring() : this(status: AuthStatus.restoring);

  final AuthStatus status;
  final Player? player;

  /// Signed in, but the Konami ID, phone and country are still to come.
  bool get needsOnboarding =>
      status == AuthStatus.signedIn && player?.onboardingCompleted == false;
}

/// Owns the session: resumes it at launch, signs in and out, and rotates the
/// refresh token whenever the API answers `401`.
class AuthController extends Notifier<AuthState> {
  late ApiClient _api;
  late AuthRepository _repository;
  late TokenStore _tokens;

  @override
  AuthState build() {
    _api = ref.watch(apiClientProvider);
    _repository = ref.watch(authRepositoryProvider);
    _tokens = ref.watch(tokenStoreProvider);
    _api.onUnauthorized = _rotate;
    return const AuthState.restoring();
  }

  /// Resumes the stored session, if any.
  Future<void> restore() async {
    state = const AuthState.restoring();
    final String? refreshToken;
    try {
      refreshToken = await _tokens.readRefreshToken();
    } catch (e, stack) {
      // Storage that can't be read, such as after a backup restored onto
      // another phone: start again from sign-in.
      report(e, stack);
      await _end();
      return;
    }
    if (refreshToken == null) {
      state = const AuthState(status: AuthStatus.signedOut);
      return;
    }
    try {
      await _adopt(await _repository.refresh(refreshToken));
    } on ApiException catch (e) {
      if (e.status == 401) {
        await _end();
      } else {
        state = const AuthState(status: AuthStatus.unreachable);
      }
    } on NetworkException {
      state = const AuthState(status: AuthStatus.unreachable);
    } catch (e, stack) {
      // Never leave the app on the splash screen.
      report(e, stack);
      state = const AuthState(status: AuthStatus.unreachable);
    }
  }

  /// Signs in (or up) with Google or Apple. Returns false when the player
  /// closed the account picker.
  Future<bool> signInWith(IdentityMethod method) async {
    final provider = ref.read(switch (method) {
      IdentityMethod.google => googleIdentityProvider,
      IdentityMethod.apple => appleIdentityProvider,
    });
    final token = await provider.obtain();
    if (token == null) return false;
    final deviceName = ref.read(deviceNameProvider);
    Future<AuthSession> send() => switch (method) {
      IdentityMethod.google => _repository.signInWithGoogle(
        token,
        deviceName: deviceName,
      ),
      IdentityMethod.apple => _repository.signInWithApple(
        token,
        deviceName: deviceName,
      ),
    };
    AuthSession session;
    try {
      session = await send();
    } on ApiException catch (e) {
      // Two first sign-ins raced; the second attempt finds the account.
      if (e.code != 'sign_in_conflict') rethrow;
      session = await send();
    }
    await _adopt(session);
    return true;
  }

  /// Adds the Konami ID, phone and country after a first sign-in; the
  /// router then lets the player in.
  Future<void> completeOnboarding({
    String? username,
    required String konamiId,
    required String phoneNumber,
    required String countryCode,
  }) async {
    replacePlayer(
      await _repository.completeOnboarding(
        username: username,
        konamiId: konamiId,
        phoneNumber: phoneNumber,
        countryCode: countryCode,
      ),
    );
  }

  /// Takes the player as the API returned it after a change to the account.
  void replacePlayer(Player player) {
    if (state.status != AuthStatus.signedIn) return;
    state = AuthState(status: AuthStatus.signedIn, player: player);
  }

  Future<void> signOut() async {
    // While the session can still say so: no more pushes to this device.
    await ref.read(pushServiceProvider).unregister();
    try {
      await _repository.logout();
    } on Exception {
      // The local session ends regardless; the server one expires on its own.
    }
    for (final provider in [googleIdentityProvider, appleIdentityProvider]) {
      try {
        await ref.read(provider).signOut();
      } on Exception {
        // Forgetting the picked account is a convenience, not a must.
      }
    }
    await _end();
  }

  Future<void> _adopt(AuthSession session) async {
    await _tokens.writeRefreshToken(session.refreshToken);
    _api.accessToken = session.accessToken;
    state = AuthState(status: AuthStatus.signedIn, player: session.player);
  }

  Future<void> _end() async {
    try {
      await _tokens.clear();
    } catch (e, stack) {
      // Signed out on this phone even if the stored tokens won't clear.
      report(e, stack);
    } finally {
      _api.accessToken = null;
      state = const AuthState(status: AuthStatus.signedOut);
    }
  }

  /// The API client's `401` hook. Network errors propagate to the caller.
  Future<String?> _rotate() async {
    final refreshToken = await _tokens.readRefreshToken();
    if (refreshToken == null) {
      await _end();
      return null;
    }
    try {
      final session = await _repository.refresh(refreshToken);
      await _adopt(session);
      return session.accessToken;
    } on ApiException catch (e) {
      if (e.status != 401) rethrow;
      await _end();
      return null;
    }
  }
}
