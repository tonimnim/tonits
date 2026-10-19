import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../matches/application/matches_providers.dart';
import '../../players/application/players_providers.dart';
import 'competitions_providers.dart';

/// Enters and leaves free competitions, and refreshes everything an entry
/// changes. Paid entry goes through the M-Pesa checkout instead.
class EntryService {
  EntryService(this._ref);

  final Ref _ref;

  /// Throws [ApiException] with `competition_ineligible` (show its message)
  /// or `payment_required` (the competition is paid).
  Future<void> enterFree(String competitionId) async {
    final gameAccountId = await _ref.read(myGameAccountIdProvider.future);
    if (gameAccountId == null) {
      throw StateError('No eFootball account to enter with');
    }
    try {
      await _ref
          .read(competitionsRepositoryProvider)
          .register(
            competitionId,
            gameAccountId: gameAccountId,
            idempotencyKey: newUuid(),
          );
    } finally {
      refreshAfterEntry(competitionId);
    }
  }

  Future<void> withdraw(String competitionId) async {
    try {
      await _ref.read(competitionsRepositoryProvider).withdraw(competitionId);
    } finally {
      refreshAfterEntry(competitionId);
    }
  }

  /// One key per paid competition's withdrawal request, kept only to retry
  /// it after a dropped connection, so it's never asked for twice.
  final _withdrawalKeys = <String, String>{};

  /// Asks to leave a paid competition; staff review the refund. Throws
  /// [ApiException] with `withdrawal_closed` once registration has closed,
  /// or `refund_request_exists`.
  Future<void> requestWithdrawal(String competitionId) async {
    final key = _withdrawalKeys[competitionId] ??= newUuid();
    try {
      await _ref
          .read(competitionsRepositoryProvider)
          .requestWithdrawal(competitionId, idempotencyKey: key);
      _withdrawalKeys.remove(competitionId);
    } on ApiException {
      // The server answered: a new attempt is a new request.
      _withdrawalKeys.remove(competitionId);
      rethrow;
    } finally {
      refreshAfterEntry(competitionId);
    }
  }

  /// An entry changes the competition's numbers, the player's decision and
  /// what Home shows.
  void refreshAfterEntry(String competitionId) {
    _ref
      ..invalidate(eligibilityProvider(competitionId))
      ..invalidate(competitionProvider(competitionId))
      ..invalidate(competitionsProvider)
      ..invalidate(myEntriesProvider)
      ..invalidate(nextMatchProvider);
  }
}
