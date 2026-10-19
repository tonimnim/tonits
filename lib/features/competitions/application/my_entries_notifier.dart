import '../../../core/api/cursor_page.dart';
import '../../../core/api/paged.dart';
import '../data/registration.dart';
import 'competitions_providers.dart';

/// The signed-in player's entries, newest first.
class MyEntriesNotifier extends PagedNotifier<Registration> {
  @override
  Future<CursorPage<Registration>> fetchPage(String? cursor) =>
      ref.read(competitionsRepositoryProvider).myRegistrations(cursor: cursor);
}
