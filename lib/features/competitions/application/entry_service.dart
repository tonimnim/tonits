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

  /// An entry changes the competition's numbers, the player's decision and
  /// what Home shows.
  void refreshAfterEntry(String competitionId) {
    _ref
      ..invalidate(eligibilityProvider(competitionId))
      ..invalidate(competitionProvider(competitionId))
      ..invalidate(competitionsProvider)
      ..invalidate(nextMatchProvider);
  }
}
