import 'package:flutter/material.dart';

import '../../core/l10n.dart';
import '../../core/routes.dart';

/// The bottom navigation tabs, in order. The router builds one branch per
/// tab from this list, so the bar and the routes can't drift apart.
enum AppTab {
  home(Routes.home, Icons.home_outlined, Icons.home_rounded),
  competitions(
    Routes.competitions,
    Icons.emoji_events_outlined,
    Icons.emoji_events,
  ),
  matches(Routes.matches, Icons.sports_esports_outlined, Icons.sports_esports),
  rankings(Routes.rankings, Icons.leaderboard_outlined, Icons.leaderboard),
  profile(Routes.profile, Icons.person_outline, Icons.person);

  const AppTab(this.path, this.icon, this.selectedIcon);

  /// The tab's name in the app's language.
  String label(AppLocalizations l) => switch (this) {
    home => l.tabHome,
    competitions => l.tabCompete,
    matches => l.tabMatches,
    rankings => l.tabRankings,
    profile => l.tabProfile,
  };

  final String path;
  final IconData icon;
  final IconData selectedIcon;
}
