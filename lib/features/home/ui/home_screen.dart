import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/application/auth_providers.dart';
import '../../competitions/application/competitions_providers.dart';
import '../../matches/application/matches_providers.dart';
import '../../notifications/application/notifications_providers.dart';
import '../../players/application/players_providers.dart';
import 'widgets/home_header.dart';
import 'widgets/home_hero_card.dart';
import 'widgets/open_now_section.dart';
import 'widgets/player_card.dart';
import 'widgets/recent_matches_section.dart';

/// Tab 1: the player's overview. A greeting and headline, then one volt
/// card for what to do next (their match, or finding a competition), their
/// rating, the competitions open now when they have no match, and their
/// recent results.
///
/// The rating card shows a new player's numbers at zero. Other sections
/// without data leave the page rather than showing empty boxes.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(currentPlayerProvider);
    if (player == null) return const SizedBox.shrink();

    return HeroScaffold(
      onRefresh: () async {
        // Reloads only while it's on the page.
        ref.invalidate(openCompetitionsProvider);
        await Future.wait([
          ref.refresh(myProfileProvider.future),
          ref.refresh(myRecentMatchesProvider.future),
          ref.refresh(nextMatchProvider.future),
          ref.refresh(unreadCountProvider.future),
        ]);
      },
      hero: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HomeHeader(name: player.displayName),
          const SizedBox(height: TonitsSpace.lg),
          const HomeHeroCard(),
          const PlayerCard(),
        ],
      ),
      children: const [OpenNowSection(), RecentMatchesSection()],
    );
  }
}
