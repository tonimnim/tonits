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
  const AuthState({
    required this.status,
    this.player,
    this.pendingCountryCode,
    this.pendingRecoveryCode,
    this.recoveryCodeReplacesOld = false,
  });

  const AuthState.restoring() : this(status: AuthStatus.restoring);

  final AuthStatus status;
  final Player? player;

  /// The country picked at registration, when saving it failed.
  final String? pendingCountryCode;

  /// A recovery code the player hasn't confirmed saving yet. While set, the
  /// router keeps them on the screen that shows it. Held in memory only.
  final String? pendingRecoveryCode;

  /// Whether [pendingRecoveryCode] replaces a code that was just spent (a
  /// reset), rather than being the player's first.
  final bool recoveryCodeReplacesOld;

  AuthState copyWith({
    Player? player,
    String? Function()? pendingCountryCode,
    String? Function()? pendingRecoveryCode,
  }) => AuthState(
    status: status,
    player: player ?? this.player,
    pendingCountryCode: pendingCountryCode == null
        ? this.pendingCountryCode
        : pendingCountryCode(),
    pendingRecoveryCode: pendingRecoveryCode == null
        ? this.pendingRecoveryCode
        : pendingRecoveryCode(),
    recoveryCodeReplacesOld: recoveryCodeReplacesOld,
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

  /// The country is sent with registration, which records it as chosen
  /// (the API accepts `countryCode` from the backend change of 2026-10-18;
  /// earlier APIs reject the field). If the account somehow comes back with
  /// another country, it is saved with `PATCH /v1/me` right after; the
  /// player is signed in either way.
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
      countryCode: countryCode,
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

  /// Resets a forgotten password with the recovery code and signs in. The
  /// new code that replaces the spent one must then be shown.
  Future<void> resetWithRecoveryCode({
    required String konamiId,
    required String recoveryCode,
    required String newPassword,
  }) async {
    await _adopt(
      await _repository.resetWithRecoveryCode(
        konamiId: konamiId,
        recoveryCode: recoveryCode,
        newPassword: newPassword,
        deviceName: ref.read(deviceNameProvider),
      ),
      replacesRecoveryCode: true,
    );
  }

  /// The player has saved the code they were shown.
  void acknowledgeRecoveryCode() {
    state = state.copyWith(pendingRecoveryCode: () => null);
  }

  /// Issues a new recovery code (the old one stops working) and returns it
  /// for the caller to show.
  Future<String> createRecoveryCode({required String password}) async {
    final issued = await _repository.newRecoveryCode(password);
    final player = state.player;
    if (player != null) {
      state = state.copyWith(player: player.withRecoveryCode(issued.createdAt));
    }
    return issued.code;
  }

  Future<void> signOut() async {
    try {
      await _repository.logout();
    } on Exception {
      // The local session ends regardless; the server one expires on its own.
    }
    await _end();
  }

  Future<void> _adopt(
    AuthSession session, {
    bool replacesRecoveryCode = false,
  }) async {
    await _tokens.writeRefreshToken(session.refreshToken);
    _api.accessToken = session.accessToken;
    final newCode = session.recoveryCode;
    state = AuthState(
      status: AuthStatus.signedIn,
      player: session.player,
      pendingCountryCode: state.pendingCountryCode,
      pendingRecoveryCode: newCode ?? state.pendingRecoveryCode,
      recoveryCodeReplacesOld: newCode == null
          ? state.recoveryCodeReplacesOld
          : replacesRecoveryCode,
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
