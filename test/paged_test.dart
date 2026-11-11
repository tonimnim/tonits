import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/core/api/cursor_page.dart';
import 'package:tonits/core/api/paged.dart';

/// Pages answered by hand: each fetch waits for the test to complete it.
class _Pages extends PagedNotifier<String> {
  static final asked = <(String?, Completer<CursorPage<String>>)>[];

  @override
  Future<CursorPage<String>> fetchPage(String? cursor) {
    final answer = Completer<CursorPage<String>>();
    asked.add((cursor, answer));
    return answer.future;
  }
}

final _provider = AsyncNotifierProvider<_Pages, Paged<String>>(_Pages.new);

CursorPage<String> _page(List<String> items, {String? next}) =>
    CursorPage(items: items, nextCursor: next, hasMore: next != null);

void main() {
  setUp(_Pages.asked.clear);

  Future<ProviderContainer> loaded() async {
    final container = ProviderContainer(retry: (_, _) => null);
    addTearDown(container.dispose);
    container.listen(_provider, (_, _) {});
    _Pages.asked.single.$2.complete(_page(['a1'], next: 'c2'));
    await container.read(_provider.future);
    return container;
  }

  test('a page asked for before a refresh is dropped', () async {
    final container = await loaded();
    final more = container.read(_provider.notifier).loadMore();

    final refreshed = container.refresh(_provider.future);
    _Pages.asked.last.$2.complete(_page(['b1']));
    await refreshed;
    // The old list's page 2 arrives last.
    _Pages.asked[1].$2.complete(_page(['a2']));
    await more;

    expect(container.read(_provider).value!.items, ['b1']);
  });

  test('a page lands on the list as it is now', () async {
    final container = await loaded();
    final notifier = container.read(_provider.notifier);
    final more = notifier.loadMore();

    // Changed meanwhile, as marking an item read does.
    notifier.state = AsyncData(
      notifier.state.value!.withItems(['a1 (read)']),
    );
    _Pages.asked.last.$2.complete(_page(['a2']));
    await more;

    expect(container.read(_provider).value!.items, ['a1 (read)', 'a2']);
  });
}
