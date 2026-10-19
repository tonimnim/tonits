import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/error_text.dart';
import '../../../core/countries.dart';
import '../../../core/l10n.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/application/auth_providers.dart';
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
    final l = context.l10n;
    final countryCode = _scope == _Scope.global ? null : player.countryCode;
    final provider = rankingsProvider(countryCode);
    final ladder = ref.watch(provider);
    final myPlace = ref.watch(myPlaceProvider(countryCode)).value;
    // Pinned while the player's own row isn't among those loaded.
    final pinMe =
        myPlace != null &&
        !(ladder.value?.items.any((r) => r.playerId == player.id) ?? true);

    return Scaffold(
      appBar: AppBar(title: Text(l.tabRankings)),
      body: PagedListView(
        value: ladder,
        onRefresh: () async {
          ref.invalidate(myPlaceProvider(countryCode));
          ref.invalidate(provider);
          await ref.read(provider.future);
        },
        onLoadMore: () => ref.read(provider.notifier).loadMore(),
        errorText: (e) => describeError(e, l),
        separator: const Divider(height: 1),
        header: Padding(
          padding: const EdgeInsets.only(bottom: TonitsSpace.md),
          child: SegmentedTabs(
            options: {
              _Scope.country: country?.name ?? player.countryCode,
              _Scope.global: l.rankingsGlobal,
            },
            selected: _scope,
            onChanged: (scope) => setState(() => _scope = scope),
          ),
        ),
        itemBuilder: (context, row) =>
            RankingRow(player: row, isMe: row.playerId == player.id),
        empty: EmptyState(
          icon: Icons.leaderboard_outlined,
          title: l.rankingsEmptyTitle,
          message: l.rankingsEmptyMessage,
        ),
      ),
      bottomNavigationBar: pinMe
          ? _PinnedPlace(child: RankingRow(player: myPlace, isMe: true))
          : null,
    );
  }
}

/// The player's own row, pinned under the ladder when they're further down
/// than the rows loaded so far.
class _PinnedPlace extends StatelessWidget {
  const _PinnedPlace({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: p.background,
        border: Border(top: BorderSide(color: p.border)),
      ),
      // Only as tall as the row: the bottom slot would let it fill the
      // screen.
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              TonitsSpace.md,
              10,
              TonitsSpace.md,
              10,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
