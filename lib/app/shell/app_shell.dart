import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_tab.dart';
import 'tonits_navigation_bar.dart';

/// The signed-in frame: the current tab above the bottom bar. Each tab keeps
/// its own navigation stack and scroll position.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: TonitsNavigationBar(
        selected: AppTab.values[shell.currentIndex],
        onSelected: (tab) => shell.goBranch(
          tab.index,
          // Tapping the current tab again returns to its first screen.
          initialLocation: tab.index == shell.currentIndex,
        ),
      ),
    );
  }
}
