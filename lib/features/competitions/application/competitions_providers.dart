import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/cursor_page.dart';
import '../../../core/api/paged.dart';
import '../../../core/providers.dart';
import '../../players/application/players_providers.dart';
import '../data/competition.dart';
import '../data/eligibility.dart';
import '../data/competitions_repository.dart';

final competitionsRepositoryProvider = Provider<CompetitionsRepository>(
  (ref) => CompetitionsRepository(ref.watch(apiClientProvider)),
);

/// Competitions taking entries, the ones closing soonest first, for Home.
final closingSoonProvider = FutureProvider.autoDispose<List<Competition>>((
  ref,
) async {
  final page = await ref
      .watch(competitionsRepositoryProvider)
      .list(status: CompetitionStatus.registrationOpen, limit: 10);
  final far = DateTime.utc(9999);
  // Leave out any the API still lists as open after their deadline.
  return page.items.where((c) => !c.registrationEnded).toList()..sort(
    (a, b) => (a.registrationClosesAt ?? far).compareTo(
      b.registrationClosesAt ?? far,
    ),
  );
});

/// The filters on the Competitions tab.
enum CompetitionFilter {
  open('Open', CompetitionStatus.registrationOpen),
  upcoming('Upcoming', CompetitionStatus.published),
  live('Live', CompetitionStatus.running),
  finished('Finished', CompetitionStatus.completed);

  const CompetitionFilter(this.label, this.status);

  final String label;
  final CompetitionStatus status;
}

final competitionsProvider = AsyncNotifierProvider.autoDispose
    .family<CompetitionsNotifier, Paged<Competition>, CompetitionFilter>(
      CompetitionsNotifier.new,
    );

class CompetitionsNotifier extends PagedNotifier<Competition> {
  CompetitionsNotifier(this.filter);

  final CompetitionFilter filter;

  @override
  Future<CursorPage<Competition>> fetchPage(String? cursor) => ref
      .read(competitionsRepositoryProvider)
      .list(status: filter.status, cursor: cursor);
}

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
