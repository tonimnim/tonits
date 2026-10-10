import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/providers.dart';
import '../data/auth_repository.dart';
import '../data/models.dart';
import '../data/token_store.dart';

final tokenStoreProvider = Provider<TokenStore>((ref) => SecureTokenStore());

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref.watch(apiClientProvider)),
);

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

/// The signed-in player, or null for a moment while signing out (before the
/// router leaves the signed-in screens).
final currentPlayerProvider = Provider<Player?>(
  (ref) => ref.watch(authControllerProvider).player,
);

enum AuthStatus {
  /// Checking for a stored session at launch.
  restoring,

  /// A stored session exists but the API could not be reached to resume it.
  unreachable,
  signedOut,
  signedIn,
}

@immutable
class AuthState {
  const AuthState({required this.status, this.player, this.pendingCountryCode});

  const AuthState.restoring() : this(status: AuthStatus.restoring);

  final AuthStatus status;
  final Player? player;

  /// The country picked at registration, when saving it failed.
  final String? pendingCountryCode;

  AuthState copyWith({
    Player? player,
    String? Function()? pendingCountryCode,
  }) => AuthState(
    status: status,
    player: player ?? this.player,
    pendingCountryCode: pendingCountryCode == null
        ? this.pendingCountryCode
        : pendingCountryCode(),
  );
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
    final refreshToken = await _tokens.readRefreshToken();
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
    }
  }

  Future<void> signIn({
    required String konamiId,
    required String password,
  }) async {
    await _adopt(
      await _repository.signIn(
        konamiId: konamiId,
        password: password,
        deviceName: ref.read(deviceNameProvider),
      ),
    );
  }

  /// Registration takes no country, so it is saved with `PATCH /v1/me` right
  /// after. The player is signed in even if that second call fails.
  Future<void> register({
    required String username,
    required String konamiId,
    required String password,
    required String countryCode,
  }) async {
    final session = await _repository.register(
      username: username,
      konamiId: konamiId,
      password: password,
      deviceName: ref.read(deviceNameProvider),
    );
    await _adopt(session);
    if (session.player.countryCode == countryCode) return;
    state = state.copyWith(pendingCountryCode: () => countryCode);
    await savePendingCountry();
  }

  /// Returns whether the country is saved.
  Future<bool> savePendingCountry() async {
    final code = state.pendingCountryCode;
    if (code == null) return true;
    try {
      final player = await _repository.updateCountry(code);
      state = state.copyWith(player: player, pendingCountryCode: () => null);
      return true;
    } on Exception {
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await _repository.logout();
    } on Exception {
      // The local session ends regardless; the server one expires on its own.
    }
    await _end();
  }

  Future<void> _adopt(AuthSession session) async {
    await _tokens.writeRefreshToken(session.refreshToken);
    _api.accessToken = session.accessToken;
    state = AuthState(
      status: AuthStatus.signedIn,
      player: session.player,
      pendingCountryCode: state.pendingCountryCode,
    );
  }

  Future<void> _end() async {
    await _tokens.clear();
    _api.accessToken = null;
    state = const AuthState(status: AuthStatus.signedOut);
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
