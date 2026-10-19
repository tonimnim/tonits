import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/error_text.dart';
import '../../../core/l10n.dart';
import '../../../core/routes.dart';
import '../../../core/widgets/widgets.dart';
import '../application/competitions_providers.dart';
import 'widgets/entry_row.dart';

/// Every competition the player has entered, newest first, each opening
/// its competition.
class MyEntriesScreen extends ConsumerWidget {
  const MyEntriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l.entriesTitle)),
      body: PagedListView(
        value: ref.watch(myEntriesProvider),
        onRefresh: () => ref.refresh(myEntriesProvider.future),
        onLoadMore: () => ref.read(myEntriesProvider.notifier).loadMore(),
        errorText: (e) => describeError(e, l),
        separator: const Divider(height: 1),
        itemBuilder: (context, entry) => EntryRow(
          entry: entry,
          onTap: () => context.go(Routes.competition(entry.competitionId)),
        ),
        empty: EmptyState(
          icon: Icons.confirmation_number_outlined,
          title: l.entriesEmpty,
          message: l.entriesEmptyMessage,
          actionLabel: l.entriesFind,
          onAction: () => context.go(Routes.competitions),
        ),
      ),
    );
  }
}
