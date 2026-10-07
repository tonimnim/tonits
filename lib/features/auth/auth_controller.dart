import 'package:flutter/foundation.dart';

import '../../core/api/api_client.dart';
import 'auth_repository.dart';
import 'models.dart';
import 'token_store.dart';

enum AuthStatus {
  /// Checking for a stored session at launch.
  restoring,

  /// A stored session exists but the API could not be reached to resume it.
  unreachable,
  signedOut,
  signedIn,
}

/// Owns the session: resumes it at launch, signs in and out, and rotates the
/// refresh token whenever the API answers `401`.
class AuthController extends ChangeNotifier {
  AuthController({
    required this._api,
    required this._repository,
    required TokenStore tokenStore,
    this.deviceName,
  }) : _tokens = tokenStore {
    _api.onUnauthorized = _rotate;
  }

  final ApiClient _api;
  final AuthRepository _repository;
  final TokenStore _tokens;
  final String? deviceName;

  AuthStatus _status = AuthStatus.restoring;
  AuthStatus get status => _status;

  Player? _player;
  Player? get player => _player;

  AuthRepository get repository => _repository;

  /// Resumes the stored session, if any.
  Future<void> restore() async {
    _set(AuthStatus.restoring);
    final refreshToken = await _tokens.readRefreshToken();
    if (refreshToken == null) return _set(AuthStatus.signedOut);
    try {
      await _adopt(await _repository.refresh(refreshToken));
    } on ApiException catch (e) {
      if (e.status == 401) {
        await _end();
      } else {
        _set(AuthStatus.unreachable);
      }
    } on NetworkException {
      _set(AuthStatus.unreachable);
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
        deviceName: deviceName,
      ),
    );
  }

  /// The country picked at registration, when saving it failed. Retry with
  /// [savePendingCountry].
  String? _pendingCountryCode;
  String? get pendingCountryCode => _pendingCountryCode;

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
      deviceName: deviceName,
    );
    await _adopt(session);
    if (session.player.countryCode == countryCode) return;
    _pendingCountryCode = countryCode;
    await savePendingCountry();
  }

  /// Returns whether the country is saved.
  Future<bool> savePendingCountry() async {
    final code = _pendingCountryCode;
    if (code == null) return true;
    try {
      _player = await _repository.updateCountry(code);
      _pendingCountryCode = null;
      return true;
    } on Exception {
      return false;
    } finally {
      notifyListeners();
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
    _player = session.player;
    _set(AuthStatus.signedIn);
  }

  Future<void> _end() async {
    await _tokens.clear();
    _api.accessToken = null;
    _player = null;
    _pendingCountryCode = null;
    _set(AuthStatus.signedOut);
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

  void _set(AuthStatus status) {
    _status = status;
    notifyListeners();
  }
}
