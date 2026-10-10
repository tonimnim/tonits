import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/cursor_page.dart';
import '../../../core/api/paged.dart';
import '../../../core/providers.dart';
import '../data/match_summary.dart';
import '../data/matches_repository.dart';

final matchesRepositoryProvider = Provider<MatchesRepository>(
  (ref) => MatchesRepository(ref.watch(apiClientProvider)),
);

/// The player's soonest active match, if any, for Home.
final nextMatchProvider = FutureProvider.autoDispose<MatchSummary?>((
  ref,
) async {
  final page = await ref
      .watch(matchesRepositoryProvider)
      .mine(kind: MatchListKind.active, limit: 1);
  return page.items.firstOrNull;
});

final myMatchesProvider = AsyncNotifierProvider.autoDispose
    .family<MyMatchesNotifier, Paged<MatchSummary>, MatchListKind>(
      MyMatchesNotifier.new,
    );

class MyMatchesNotifier extends PagedNotifier<MatchSummary> {
  MyMatchesNotifier(this.kind);

  final MatchListKind kind;

  @override
  Future<CursorPage<MatchSummary>> fetchPage(String? cursor) =>
      ref.read(matchesRepositoryProvider).mine(kind: kind, cursor: cursor);
}
