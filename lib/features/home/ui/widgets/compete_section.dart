import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../competitions/application/competitions_providers.dart';
import '../../../competitions/ui/widgets/competition_row.dart';
import 'section_message_card.dart';

/// The competitions taking entries that close soonest.
class CompeteSection extends ConsumerWidget {
  const CompeteSection({super.key});

  static const _shown = 3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final open = ref.watch(closingSoonProvider);
    final l = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(
            title: l.homeClosingSoon,
            actionLabel: l.homeSeeAll,
            onAction: () => context.go(Routes.competitions),
          ),
          const SizedBox(height: TonitsSpace.sm),
          switch (open) {
            AsyncData(value: final list) when list.isEmpty =>
              SectionMessageCard.empty(
                icon: Icons.emoji_events_outlined,
                title: l.homeNothingOpenTitle,
                message: l.homeNothingOpenMessage,
              ),
            // On the page with hairlines, like the sections above.
            AsyncData(value: final list) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final (i, c) in list.take(_shown).indexed) ...[
                  if (i > 0) const Divider(height: 1),
                  CompetitionRow(
                    competition: c,
                    onTap: () => context.go(Routes.competition(c.id)),
                  ),
                ],
              ],
            ),
            AsyncError(:final error) => SectionMessageCard.error(
              error: error,
              onRetry: () => ref.invalidate(closingSoonProvider),
            ),
            _ => const SectionMessageCard.loading(),
          },
        ],
      ),
    );
  }
}
