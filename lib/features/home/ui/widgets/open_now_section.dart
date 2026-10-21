import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../competitions/application/competitions_providers.dart';
import '../../../competitions/ui/widgets/competition_row.dart';
import '../../../matches/application/matches_providers.dart';

/// Competitions the player can enter, closing soonest first, in Up next's
/// place while they have no match coming: the way to their next one.
class OpenNowSection extends ConsumerWidget {
  const OpenNowSection({super.key});

  static const _shown = 3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only once it's known there's no match, so the two never swap.
    final next = ref.watch(nextMatchProvider);
    if (!next.hasValue || next.value != null) return const SizedBox.shrink();
    final open = ref.watch(openCompetitionsProvider).value;
    if (open == null) return const SizedBox.shrink();
    final l = context.l10n;

    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(
            title: l.homeOpenNow,
            actionLabel: l.homeSeeAll,
            onAction: () => context.go(Routes.competitions),
          ),
          const SizedBox(height: TonitsSpace.sm),
          if (open.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Text(
                l.homeNothingOpen,
                style: TextStyle(color: context.palette.mutedForeground),
              ),
            )
          else
            // On the page with hairlines, like the rows around it.
            for (final (i, competition) in open.take(_shown).indexed) ...[
              if (i > 0) const Divider(height: 1),
              CompetitionRow(
                competition: competition,
                onTap: () => context.go(Routes.competition(competition.id)),
              ),
            ],
        ],
      ),
    );
  }
}
