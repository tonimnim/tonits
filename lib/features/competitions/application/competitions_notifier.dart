import '../../../core/api/cursor_page.dart';
import '../../../core/api/paged.dart';
import '../data/competition.dart';
import 'competitions_providers.dart';
import 'competition_filter.dart';

class CompetitionsNotifier extends PagedNotifier<Competition> {
  CompetitionsNotifier(this.filter);

  final CompetitionFilter filter;

  @override
  Future<CursorPage<Competition>> fetchPage(String? cursor) => ref
      .read(competitionsRepositoryProvider)
      .list(status: filter.status, cursor: cursor);
}
