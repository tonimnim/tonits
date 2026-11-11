import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cursor_page.dart';

/// Items loaded so far from a cursor-paginated collection.
class Paged<T> {
  const Paged({
    required this.items,
    required this.nextCursor,
    required this.hasMore,
    this.loadingMore = false,
    this.loadMoreError,
  });

  factory Paged.first(CursorPage<T> page) => Paged(
    items: page.items,
    nextCursor: page.nextCursor,
    hasMore: page.hasMore,
  );

  final List<T> items;
  final String? nextCursor;
  final bool hasMore;
  final bool loadingMore;

  /// Why the last "load more" failed; the items already shown stay.
  final Object? loadMoreError;

  Paged<T> append(CursorPage<T> page) => Paged(
    items: [...items, ...page.items],
    nextCursor: page.nextCursor,
    hasMore: page.hasMore,
  );

  /// The same page with its items changed, such as one marked read.
  Paged<T> withItems(List<T> items) => Paged(
    items: items,
    nextCursor: nextCursor,
    hasMore: hasMore,
    loadingMore: loadingMore,
    loadMoreError: loadMoreError,
  );

  Paged<T> copyWith({bool? loadingMore, Object? Function()? loadMoreError}) =>
      Paged(
        items: items,
        nextCursor: nextCursor,
        hasMore: hasMore,
        loadingMore: loadingMore ?? this.loadingMore,
        loadMoreError: loadMoreError == null
            ? this.loadMoreError
            : loadMoreError(),
      );
}

/// Loads the first page on build and appends further pages on [loadMore].
/// Subclasses only say how to fetch one page.
abstract class PagedNotifier<T> extends AsyncNotifier<Paged<T>> {
  Future<CursorPage<T>> fetchPage(String? cursor);

  /// Bumped on every (re)build. Riverpod keeps this notifier across a
  /// refresh, so `ref.mounted` alone can't tell a page asked for before it.
  int _generation = 0;

  @override
  Future<Paged<T>> build() async {
    _generation++;
    return Paged.first(await fetchPage(null));
  }

  Future<void> loadMore() async {
    final current = state.value;
    // Not while refreshing: the next page would continue the old list.
    if (current == null ||
        state.isLoading ||
        !current.hasMore ||
        current.loadingMore) {
      return;
    }
    final generation = _generation;
    state = AsyncData(
      current.copyWith(loadingMore: true, loadMoreError: () => null),
    );
    try {
      final page = await fetchPage(current.nextCursor);
      final latest = _sameList(generation);
      // Onto the list as it is now, keeping changes made meanwhile (an item
      // marked read).
      if (latest != null) state = AsyncData(latest.append(page));
    } catch (error) {
      final latest = _sameList(generation);
      if (latest != null) {
        state = AsyncData(
          latest.copyWith(loadingMore: false, loadMoreError: () => error),
        );
      }
    }
  }

  /// The list now, or null when it was refreshed or disposed since
  /// [generation]: a page from before then belongs to an older list.
  Paged<T>? _sameList(int generation) {
    if (!ref.mounted || generation != _generation) return null;
    return state.value;
  }
}
