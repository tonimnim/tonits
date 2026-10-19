import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/error_text.dart';
import '../../../core/l10n.dart';
import '../../../core/routes.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../application/matches_providers.dart';
import '../data/matches_repository.dart';
import 'widgets/match_card.dart';

/// Tab 3: the player's active matches and their history.
class MatchesScreen extends ConsumerStatefulWidget {
  const MatchesScreen({super.key});

  @override
  ConsumerState<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends ConsumerState<MatchesScreen> {
  var _kind = MatchListKind.active;

  @override
  Widget build(BuildContext context) {
    final provider = myMatchesProvider(_kind);
    final active = _kind == MatchListKind.active;
    final l = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l.tabMatches)),
      body: PagedListView(
        value: ref.watch(provider),
        onRefresh: () => ref.refresh(provider.future),
        onLoadMore: () => ref.read(provider.notifier).loadMore(),
        errorText: (e) => describeError(e, l),
        header: Padding(
          padding: const EdgeInsets.only(bottom: TonitsSpace.md),
          child: SegmentedTabs(
            options: {
              MatchListKind.active: l.matchListActive,
              MatchListKind.history: l.matchListHistory,
            },
            selected: _kind,
            onChanged: (kind) => setState(() => _kind = kind),
          ),
        ),
        itemBuilder: (context, match) => MatchCard(match: match),
        empty: EmptyState(
          icon: Icons.sports_esports_outlined,
          title: active ? l.matchNoActiveTitle : l.matchNoHistoryTitle,
          message: active ? l.matchNoActiveMessage : l.matchNoHistoryMessage,
          actionLabel: active ? l.matchBrowseCompetitions : null,
          onAction: active ? () => context.go(Routes.competitions) : null,
        ),
      ),
    );
  }
}
