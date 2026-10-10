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

  @override
  Future<Paged<T>> build() async => Paged.first(await fetchPage(null));

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.loadingMore) return;
    state = AsyncData(
      current.copyWith(loadingMore: true, loadMoreError: () => null),
    );
    try {
      final page = await fetchPage(current.nextCursor);
      if (!ref.mounted) return;
      state = AsyncData(current.append(page));
    } catch (error) {
      if (!ref.mounted) return;
      state = AsyncData(
        current.copyWith(loadingMore: false, loadMoreError: () => error),
      );
    }
  }
}
