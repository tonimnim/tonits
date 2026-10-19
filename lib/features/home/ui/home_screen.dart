import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/application/auth_providers.dart';
import '../../matches/application/matches_providers.dart';
import '../../notifications/application/notifications_providers.dart';
import '../../players/application/players_providers.dart';
import 'widgets/home_header.dart';
import 'widgets/player_card.dart';
import 'widgets/recent_matches_section.dart';
import 'widgets/up_next_card.dart';

/// Tab 1: the player's overview. Their rating and form first, then their
/// next match and recent results.
///
/// Sections without data (a new player's stats, no upcoming match) leave
/// the page rather than showing empty boxes.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(currentPlayerProvider);
    if (player == null) return const SizedBox.shrink();

    return HeroScaffold(
      onRefresh: () async {
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
          const PlayerCard(),
        ],
      ),
      children: const [UpNextCard(), RecentMatchesSection()],
    );
  }
}
