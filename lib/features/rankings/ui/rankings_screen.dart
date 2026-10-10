import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/error_text.dart';
import '../../../core/countries.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/application/auth_controller.dart';
import '../application/rankings_providers.dart';
import 'widgets/ranking_row.dart';

enum _Scope { country, global }

/// Tab 4: the player's country ladder and the global one.
class RankingsScreen extends ConsumerStatefulWidget {
  const RankingsScreen({super.key});

  @override
  ConsumerState<RankingsScreen> createState() => _RankingsScreenState();
}

class _RankingsScreenState extends ConsumerState<RankingsScreen> {
  var _scope = _Scope.country;

  @override
  Widget build(BuildContext context) {
    final player = ref.watch(currentPlayerProvider);
    if (player == null) return const SizedBox.shrink();
    final country = Country.byCode(player.countryCode);
    final provider = rankingsProvider(
      _scope == _Scope.global ? null : player.countryCode,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Rankings')),
      body: PagedListView(
        value: ref.watch(provider),
        onRefresh: () => ref.refresh(provider.future),
        onLoadMore: () => ref.read(provider.notifier).loadMore(),
        errorText: describeError,
        separator: const SizedBox(height: TonitsSpace.sm),
        header: Padding(
          padding: const EdgeInsets.only(bottom: TonitsSpace.md),
          child: SegmentedTabs(
            options: {
              _Scope.country: country?.name ?? player.countryCode,
              _Scope.global: 'Global',
            },
            selected: _scope,
            onChanged: (scope) => setState(() => _scope = scope),
          ),
        ),
        itemBuilder: (context, row) =>
            RankingRow(player: row, isMe: row.playerId == player.id),
        empty: const EmptyState(
          icon: Icons.leaderboard_outlined,
          title: 'No rankings yet',
          message: 'Players are ranked once they finish rated matches.',
        ),
      ),
    );
  }
}
