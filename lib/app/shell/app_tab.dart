import 'package:flutter/material.dart';

import '../../core/routes.dart';

/// The bottom navigation tabs, in order. The router builds one branch per
/// tab from this list, so the bar and the routes can't drift apart.
enum AppTab {
  home('Home', Routes.home, Icons.home_outlined, Icons.home_rounded),
  competitions(
    'Compete',
    Routes.competitions,
    Icons.emoji_events_outlined,
    Icons.emoji_events,
  ),
  matches(
    'Matches',
    Routes.matches,
    Icons.sports_esports_outlined,
    Icons.sports_esports,
  ),
  rankings(
    'Rankings',
    Routes.rankings,
    Icons.leaderboard_outlined,
    Icons.leaderboard,
  ),
  profile('Profile', Routes.profile, Icons.person_outline, Icons.person);

  const AppTab(this.label, this.path, this.icon, this.selectedIcon);

  final String label;
  final String path;
  final IconData icon;
  final IconData selectedIcon;
}
