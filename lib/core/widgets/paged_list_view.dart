import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/paged.dart';
import '../theme.dart';
import 'states.dart';

/// A pull-to-refresh list over a [PagedNotifier]'s state. It loads the next
/// page near the end and covers loading, empty and error states.
class PagedListView<T> extends StatelessWidget {
  const PagedListView({
    super.key,
    required this.value,
    required this.itemBuilder,
    required this.onRefresh,
    required this.onLoadMore,
    required this.empty,
    required this.errorText,
    this.header,
    this.separator = const SizedBox(height: TonitsSpace.md),
  });

  final AsyncValue<Paged<T>> value;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;

  /// Shown when the first page has no items.
  final Widget empty;

  /// Turns a load error into a sentence for the player.
  final String Function(Object error) errorText;

  /// Scrolls with the list, above the items (for filters).
  final Widget? header;
  final Widget separator;

  @override
  Widget build(BuildContext context) {
    final slivers = <Widget>[
      if (header != null) SliverToBoxAdapter(child: header),
      ...switch (value) {
        AsyncData(:final value) when value.items.isEmpty => [
          SliverToBoxAdapter(child: empty),
        ],
        AsyncData(:final value) => [
          SliverList.separated(
            itemCount: value.items.length,
            itemBuilder: (context, i) => itemBuilder(context, value.items[i]),
            separatorBuilder: (_, _) => separator,
          ),
          SliverToBoxAdapter(child: _Footer(value, onLoadMore, errorText)),
        ],
        AsyncError(:final error) => [
          SliverToBoxAdapter(
            child: ErrorState(message: errorText(error), onRetry: onRefresh),
          ),
        ],
        _ => [const SliverToBoxAdapter(child: LoadingState(height: 240))],
      },
    ];

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: NotificationListener<ScrollNotification>(
        onNotification: (n) {
          if (n.metrics.extentAfter < 400) onLoadMore();
          return false;
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                TonitsSpace.lg,
                TonitsSpace.md,
                TonitsSpace.lg,
                TonitsSpace.xl,
              ),
              sliver: SliverMainAxisGroup(slivers: slivers),
            ),
          ],
        ),
      ),
    );
  }
}

class _Footer<T> extends StatelessWidget {
  const _Footer(this.page, this.onLoadMore, this.errorText);

  final Paged<T> page;
  final VoidCallback onLoadMore;
  final String Function(Object error) errorText;

  @override
  Widget build(BuildContext context) {
    if (page.loadingMore) return const LoadingState(height: 72);
    if (page.loadMoreError != null) {
      return Padding(
        padding: const EdgeInsets.only(top: TonitsSpace.md),
        child: Center(
          child: TextButton(
            onPressed: onLoadMore,
            child: const Text("Couldn't load more. Try again"),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
