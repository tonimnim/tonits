import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/error_text.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../application/competitions_providers.dart';
import 'widgets/competition_card.dart';

/// Tab 2: discover competitions, filtered by where they are in their life.
class CompetitionsScreen extends ConsumerStatefulWidget {
  const CompetitionsScreen({super.key});

  @override
  ConsumerState<CompetitionsScreen> createState() => _CompetitionsScreenState();
}

class _CompetitionsScreenState extends ConsumerState<CompetitionsScreen> {
  var _filter = CompetitionFilter.open;

  @override
  Widget build(BuildContext context) {
    final provider = competitionsProvider(_filter);
    return Scaffold(
      appBar: AppBar(title: const Text('Competitions')),
      body: PagedListView(
        value: ref.watch(provider),
        onRefresh: () => ref.refresh(provider.future),
        onLoadMore: () => ref.read(provider.notifier).loadMore(),
        errorText: describeError,
        header: Padding(
          padding: const EdgeInsets.only(bottom: TonitsSpace.md),
          child: SegmentedTabs(
            options: {for (final f in CompetitionFilter.values) f: f.label},
            selected: _filter,
            onChanged: (f) => setState(() => _filter = f),
          ),
        ),
        itemBuilder: (context, competition) =>
            CompetitionCard(competition: competition),
        empty: EmptyState(
          icon: Icons.emoji_events_outlined,
          title: switch (_filter) {
            CompetitionFilter.open => 'Nothing open right now',
            CompetitionFilter.upcoming => 'Nothing announced yet',
            CompetitionFilter.live => 'Nothing live right now',
            CompetitionFilter.finished => 'No finished competitions',
          },
          message: _filter == CompetitionFilter.open
              ? 'New competitions open for registration regularly.'
              : null,
        ),
      ),
    );
  }
}
