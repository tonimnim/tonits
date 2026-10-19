import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/l10n.dart';

import '../../auth/application/auth_providers.dart';
import '../../auth/data/models.dart';
import '../../players/application/players_providers.dart';
import '../data/account_repository.dart';
import 'account_providers.dart';
import 'photo.dart';

/// Edits the signed-in player's account and keeps the session's copy of the
/// player current, so every screen shows the change at once.
class AccountService {
  AccountService(this._ref);

  final Ref _ref;

  AccountRepository get _repository => _ref.read(accountRepositoryProvider);

  Future<void> updateDisplayName(String name) async =>
      _adopt(await _repository.updateDisplayName(name));

  Future<void> updateCountry(String countryCode) async {
    _adopt(await _repository.updateCountry(countryCode));
  }

  Future<Duration?> requestEmailCode(String email) =>
      _repository.requestEmailCode(email);

  Future<void> verifyEmail(String code) async =>
      _adopt(await _repository.verifyEmail(code));

  Future<void> savePhone(String phoneNumber) async =>
      _adopt(await _repository.savePhone(phoneNumber));

  Future<void> removePhone() async {
    await _repository.removePhone();
    _adopt(await _repository.currentPlayer());
  }

  /// Changes the handle and keeps the consents as they are.
  Future<void> updateProfile({required String handle}) async {
    final player = _ref.read(currentPlayerProvider);
    if (player == null) throw StateError('Signed out');
    final current =
        player.profile ?? ProfileSettings(handle: player.username ?? '');
    _adopt(await _repository.updateProfile(current.copyWith(handle: handle)));
  }

  /// Uploads [bytes] as the profile photo and makes it the one shown.
  /// Throws [PhotoProblem] with a sentence for the player.
  Future<void> changePhoto(Uint8List bytes) async {
    final l = _ref.read(l10nProvider);
    final mediaType = photoTypeOf(bytes);
    if (mediaType == null) throw PhotoProblem(l.profilePhotoWrongType);
    if (bytes.length > maxPhotoBytes) {
      throw PhotoProblem(l.profilePhotoTooLarge);
    }
    final intent = await _repository.createAvatarUpload(
      mediaType: mediaType,
      byteSize: bytes.length,
      sha256: sha256.convert(bytes).toString(),
    );
    if (!await _repository.uploadAvatar(intent, bytes)) {
      throw PhotoProblem(l.profilePhotoUploadFailed);
    }
    final bool ready;
    try {
      ready = await _repository.completeAvatarUpload(intent.id);
    } on ApiException catch (e) {
      throw switch (e.code) {
        'avatar_verification_failed' => PhotoProblem(l.profilePhotoUnusable),
        'avatar_upload_expired' ||
        'avatar_upload_incomplete' => PhotoProblem(l.profilePhotoUploadFailed),
        _ => e,
      };
    }
    if (!ready) throw PhotoProblem(l.profilePhotoUnusable);
    await _repository.selectAvatar(intent.id);
    _ref.invalidate(myAvatarProvider);
  }

  /// Signs another device out of the account.
  Future<void> signOutDevice(String sessionId) async {
    await _repository.revokeSession(sessionId);
    _ref.invalidate(mySessionsProvider);
  }

  Future<void> requestDeletion() async {
    await _repository.requestDeletion();
    _ref.invalidate(deletionRequestProvider);
  }

  Future<void> cancelDeletion() async {
    await _repository.cancelDeletion();
    _ref.invalidate(deletionRequestProvider);
  }

  /// Deletes the account for good, then signs this device out too: the
  /// server has already ended every session.
  Future<void> deleteAccount(String requestId) async {
    await _repository.executeDeletion(requestId);
    await _ref.read(authControllerProvider.notifier).signOut();
  }

  void _adopt(Player player) {
    _ref.read(authControllerProvider.notifier).replacePlayer(player);
    _ref.invalidate(myProfileProvider);
  }
}
