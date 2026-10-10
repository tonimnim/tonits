import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../players/application/players_providers.dart';
import '../../../players/ui/widgets/match_result_row.dart';

/// The player's last five results with scores.
class RecentMatchesSection extends ConsumerWidget {
  const RecentMatchesSection({super.key});

  static const _shown = 5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recent = ref.watch(myRecentMatchesProvider).value;
    if (recent == null || recent.isEmpty) return const SizedBox.shrink();
    final rows = recent.take(_shown).toList();

    return Padding(
      padding: const EdgeInsets.only(top: TonitsSpace.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(
            title: 'Recent matches',
            actionLabel: 'See all',
            onAction: () => context.go(Routes.matches),
          ),
          const SizedBox(height: TonitsSpace.sm),
          Card(
            child: Column(
              children: [
                for (final (i, match) in rows.indexed) ...[
                  if (i > 0) const Divider(indent: TonitsSpace.md),
                  MatchResultRow(match: match),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
