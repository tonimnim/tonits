import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme.dart';
import '../../auth/application/auth_controller.dart';
import '../../competitions/application/competitions_providers.dart';
import '../../matches/application/matches_providers.dart';
import '../../players/application/players_providers.dart';
import 'widgets/compete_section.dart';
import 'widgets/home_header.dart';
import 'widgets/player_card.dart';
import 'widgets/rank_neighbourhood_section.dart';
import 'widgets/recent_matches_section.dart';
import 'widgets/stats_overview.dart';
import 'widgets/up_next_card.dart';

/// Tab 1: the player's overview. Who they are on the ladder and how they're
/// playing first, then what's next and what to enter.
///
/// Sections without data (a new player's stats, no upcoming match) leave
/// the page rather than showing empty boxes.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(currentPlayerProvider);
    if (player == null) return const SizedBox.shrink();

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () => Future.wait([
            ref.refresh(myProfileProvider.future),
            ref.refresh(myRecentMatchesProvider.future),
            ref.refresh(myRankNeighbourhoodProvider.future),
            ref.refresh(nextMatchProvider.future),
            ref.refresh(closingSoonProvider.future),
          ]),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              TonitsSpace.lg,
              TonitsSpace.md,
              TonitsSpace.lg,
              TonitsSpace.xl,
            ),
            children: [
              HomeHeader(name: player.displayName),
              const SizedBox(height: TonitsSpace.lg),
              const PlayerCard(),
              const UpNextCard(),
              const StatsOverview(),
              const RankNeighbourhoodSection(),
              const RecentMatchesSection(),
              const CompeteSection(),
            ],
          ),
        ),
      ),
    );
  }
}
