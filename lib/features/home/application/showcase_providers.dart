import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/application/auth_providers.dart';
import '../../competitions/application/competitions_providers.dart';
import '../../competitions/data/competition.dart';
import '../../rankings/application/rankings_providers.dart';
import '../../rankings/data/ranked_player.dart';

// What Home's rotating cards show. Each is null when there's nothing to
// show, or it couldn't be read: a card that fails leaves the row quietly.

/// The top three of the player's country, and their own place on it (null
/// while unranked).
typedef CountryTop = ({List<RankedPlayer> top, RankedPlayer? me});

final countryTopProvider = FutureProvider.autoDispose<CountryTop?>((ref) async {
  // Only the country: an edit to the account (a new name, a phone) must not
  // read the rankings again.
  final country = ref.watch(
    currentPlayerProvider.select((p) => p?.countryCode),
  );
  if (country == null) return null;
  try {
    final page = await ref
        .watch(rankingsRepositoryProvider)
        .list(countryCode: country, limit: 3);
    if (page.items.isEmpty) return null;
    final me = await ref
        .watch(myPlaceProvider(country).future)
        .catchError((Object _) => null);
    return (top: page.items.take(3).toList(), me: me);
  } on Object {
    return null;
  }
});

/// The latest finished competition and who won it.
typedef Champion = ({Competition competition, CompetitionWinner winner});

/// One read: completed competitions come newest first, each with its
/// winner. None when the latest ended with first place shared (a round
/// robin can), or before the API names winners.
final recentChampionProvider = FutureProvider.autoDispose<Champion?>((
  ref,
) async {
  try {
    final page = await ref
        .watch(competitionsRepositoryProvider)
        .list(status: CompetitionStatus.completed, limit: 1);
    final latest = page.items.firstOrNull;
    final winner = latest?.winner;
    if (latest == null || winner == null) return null;
    return (competition: latest, winner: winner);
  } on Object {
    return null;
  }
});

/// The next competition still to open that the player could enter.
final comingUpProvider = FutureProvider.autoDispose<Competition?>((ref) async {
  // Signed in and the country, nothing more of the account.
  final (signedIn, country) = ref.watch(
    currentPlayerProvider.select((p) => (p != null, p?.countryCode)),
  );
  try {
    final page = await ref
        .watch(competitionsRepositoryProvider)
        .list(status: CompetitionStatus.published, limit: 10, auth: signedIn);
    final now = DateTime.now();
    final upcoming =
        page.items
            .where(
              (c) =>
                  c.registrationOpensAt != null &&
                  c.registrationOpensAt!.isAfter(now) &&
                  !c.closedToCountry(country),
            )
            .toList()
          ..sort(
            (a, b) => a.registrationOpensAt!.compareTo(b.registrationOpensAt!),
          );
    return upcoming.firstOrNull;
  } on Object {
    return null;
  }
});

/// Reminders the player set or took back from Home, by competition, over
/// what the last read said; and the ones being sent. Kept here rather than
/// in a card, which the rotating row throws away once it turns past it.
/// Starts over for each player.
typedef ReminderChoices = ({Map<String, bool> set, Set<String> sending});

class ReminderChoicesNotifier extends Notifier<ReminderChoices> {
  @override
  ReminderChoices build() {
    ref.watch(currentPlayerProvider.select((p) => p?.id));
    return (set: const {}, sending: const {});
  }

  /// Turns the reminder for [competition] to [on]. Shown at once; put back
  /// and rethrown when the API refuses.
  Future<void> choose(Competition competition, {required bool on}) async {
    final id = competition.id;
    if (state.sending.contains(id)) return;
    final before = state.set[id];
    state = (set: {...state.set, id: on}, sending: {...state.sending, id});
    try {
      await ref.read(competitionsRepositoryProvider).setReminder(id, on: on);
    } catch (_) {
      if (ref.mounted) {
        state = (
          set: {...state.set}
            ..update(id, (_) => before ?? !on, ifAbsent: () => before ?? !on),
          sending: state.sending,
        );
      }
      rethrow;
    } finally {
      if (ref.mounted) {
        state = (set: state.set, sending: {...state.sending}..remove(id));
      }
    }
  }
}

final reminderChoicesProvider =
    NotifierProvider<ReminderChoicesNotifier, ReminderChoices>(
      ReminderChoicesNotifier.new,
    );
