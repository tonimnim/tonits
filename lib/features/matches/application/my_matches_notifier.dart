import '../../../core/api/cursor_page.dart';
import '../../../core/api/paged.dart';
import '../data/match_summary.dart';
import '../data/matches_repository.dart';
import 'matches_providers.dart';

class MyMatchesNotifier extends PagedNotifier<MatchSummary> {
  MyMatchesNotifier(this.kind);

  final MatchListKind kind;

  @override
  Future<CursorPage<MatchSummary>> fetchPage(String? cursor) =>
      ref.read(matchesRepositoryProvider).mine(kind: kind, cursor: cursor);
}
