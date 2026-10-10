import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/countries.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/application/auth_controller.dart';
import '../../../players/application/players_providers.dart';
import '../../../rankings/ui/widgets/ranking_row.dart';

String _countryName(String code) => Country.byCode(code)?.name ?? code;

/// The player's slice of their country's ladder (who to chase and who's
/// close behind), or its top three before they're ranked.
class RankNeighbourhoodSection extends ConsumerWidget {
  const RankNeighbourhoodSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(currentPlayerProvider);
    final slice = ref.watch(myRankNeighbourhoodProvider).value;
    if (player == null || slice == null || slice.rows.isEmpty) {
      return const SizedBox.shrink();
    }
    final rows = slice.rows;
    final country = _countryName(player.countryCode);

    return Padding(
      padding: const EdgeInsets.only(top: TonitsSpace.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(
            title: slice.ranked ? '$country ladder' : 'Top in $country',
            actionLabel: 'See all',
            onAction: () => context.go(Routes.rankings),
          ),
          const SizedBox(height: TonitsSpace.sm),
          for (final (i, row) in rows.indexed) ...[
            if (i > 0) const SizedBox(height: 6),
            RankingRow(player: row, isMe: row.playerId == player.id),
          ],
        ],
      ),
    );
  }
}
