import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/paged.dart';
import '../../../core/providers.dart';
import '../../auth/application/auth_providers.dart';
import '../../players/application/players_providers.dart';
import '../data/competition.dart';
import '../data/competitions_repository.dart';
import '../data/draw.dart';
import '../data/eligibility.dart';
import '../data/registration.dart';
import 'competition_filter.dart';
import 'competitions_notifier.dart';
import 'entry_service.dart';
import 'my_entries_notifier.dart';

final competitionsRepositoryProvider = Provider<CompetitionsRepository>(
  (ref) => CompetitionsRepository(ref.watch(apiClientProvider)),
);

final competitionsProvider = AsyncNotifierProvider.autoDispose
    .family<CompetitionsNotifier, Paged<Competition>, CompetitionFilter>(
      CompetitionsNotifier.new,
    );

/// Competitions the player can still enter, closing soonest first: Home's
/// way to a next match when they have none. Ones they're already in leave
/// the list, and entering one reloads it through [myEntriesProvider].
final openCompetitionsProvider = FutureProvider.autoDispose<List<Competition>>((
  ref,
) async {
  final country = ref.watch(currentPlayerProvider)?.countryCode;
  final repository = ref.watch(competitionsRepositoryProvider);
  // Without their entries, the list still shows; nothing is left out.
  final entries = ref
      .watch(myEntriesProvider.future)
      .then((page) => page.items, onError: (_) => const <Registration>[]);
  final page = await repository.list(
    status: CompetitionStatus.registrationOpen,
    limit: 10,
  );
  final entered = {
    for (final entry in await entries)
      if (entry.status != EntryStatus.withdrawn) entry.competitionId,
  };
  final far = DateTime.utc(9999);
  return page.items
      // The API can still list one as open after its deadline.
      .where(
        (c) =>
            !c.registrationEnded &&
            !c.isFull &&
            !c.closedToCountry(country) &&
            !entered.contains(c.id),
      )
      .toList()
    ..sort(
      (a, b) => (a.registrationClosesAt ?? far).compareTo(
        b.registrationClosesAt ?? far,
      ),
    );
});

/// One competition's detail.
final competitionProvider = FutureProvider.autoDispose
    .family<Competition, String>(
      (ref, id) => ref.watch(competitionsRepositoryProvider).get(id),
    );

/// The server's entry decision for the signed-in player, made with their
/// eFootball account.
final eligibilityProvider = FutureProvider.autoDispose
    .family<Eligibility, String>((ref, id) async {
      // Take every dependency before the first await: the ref can't be used
      // after one if nothing is listening any more.
      final repository = ref.watch(competitionsRepositoryProvider);
      final gameAccountId = await ref.watch(myGameAccountIdProvider.future);
      return repository.eligibility(id, gameAccountId: gameAccountId);
    });

/// The draw, once it's made.
final bracketProvider = FutureProvider.autoDispose.family<Bracket, String>(
  (ref, id) => ref.watch(competitionsRepositoryProvider).bracket(id),
);

/// Group tables and final placings.
final standingsProvider = FutureProvider.autoDispose.family<Standings, String>(
  (ref, id) => ref.watch(competitionsRepositoryProvider).standings(id),
);

/// The signed-in player's entry in a competition, which is how the draw
/// marks their matches and row. Null when they aren't in it.
final myEntryIdProvider = FutureProvider.autoDispose.family<String?, String>((
  ref,
  competitionId,
) async {
  if (ref.watch(currentPlayerProvider) == null) return null;
  final eligibility = await ref.watch(
    eligibilityProvider(competitionId).future,
  );
  return eligibility.entryId;
});

/// Every competition the player has entered, for Profile's My entries.
final myEntriesProvider =
    AsyncNotifierProvider.autoDispose<MyEntriesNotifier, Paged<Registration>>(
      MyEntriesNotifier.new,
    );

final entryServiceProvider = Provider<EntryService>(EntryService.new);
