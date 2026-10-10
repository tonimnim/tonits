import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../competitions/application/competitions_providers.dart';
import '../../../competitions/ui/widgets/competition_tile.dart';
import 'section_message_card.dart';

/// Competitions taking entries, closing soonest first, in a row the player
/// can swipe through.
class CompeteSection extends ConsumerWidget {
  const CompeteSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final open = ref.watch(closingSoonProvider);
    return Padding(
      padding: const EdgeInsets.only(top: TonitsSpace.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(
            title: 'Closing soon',
            actionLabel: 'See all',
            onAction: () => context.go(Routes.competitions),
          ),
          const SizedBox(height: TonitsSpace.sm),
          switch (open) {
            AsyncData(value: final list) when list.isEmpty =>
              SectionMessageCard.empty(
                icon: Icons.emoji_events_outlined,
                title: 'Nothing open right now',
                message: 'New competitions open for registration regularly.',
              ),
            AsyncData(value: final list) => SizedBox(
              // Grows with the player's text size so tiles never clip.
              height: MediaQuery.textScalerOf(context).scale(16) / 16 * 128,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                itemCount: list.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (context, i) =>
                    CompetitionTile(competition: list[i], width: 220),
              ),
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
