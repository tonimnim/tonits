import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/application/auth_providers.dart';
import '../../auth/data/models.dart';
import '../../players/application/players_providers.dart';
import '../data/account_repository.dart';
import 'account_providers.dart';

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

  void _adopt(Player player) {
    _ref.read(authControllerProvider.notifier).replacePlayer(player);
    _ref.invalidate(myProfileProvider);
  }
}
