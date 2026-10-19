import 'package:flutter/material.dart';

import '../../core/l10n.dart';
import '../../core/theme.dart';
import 'app_tab.dart';

/// The bottom bar: card surface with a hairline on top. The selected tab is
/// shown by colour alone, a solid indigo icon and label, with no pill or
/// shade behind it.
class TonitsNavigationBar extends StatelessWidget {
  const TonitsNavigationBar({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final AppTab selected;
  final ValueChanged<AppTab> onSelected;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: p.card,
        border: Border(top: BorderSide(color: p.border)),
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          height: 64,
          elevation: 0,
          backgroundColor: p.card,
          surfaceTintColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          // No splash or hover wash behind the icons either.
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          iconTheme: WidgetStateProperty.resolveWith(
            (states) => IconThemeData(
              size: 24,
              color: states.contains(WidgetState.selected)
                  ? p.primary
                  : p.mutedForeground,
            ),
          ),
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
              fontFamily: 'Geist',
              fontSize: 12,
              fontWeight: states.contains(WidgetState.selected)
                  ? FontWeight.w600
                  : FontWeight.w500,
              color: states.contains(WidgetState.selected)
                  ? p.primary
                  : p.mutedForeground,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: selected.index,
          onDestinationSelected: (i) => onSelected(AppTab.values[i]),
          destinations: [
            for (final tab in AppTab.values)
              NavigationDestination(
                icon: Icon(tab.icon),
                selectedIcon: Icon(tab.selectedIcon),
                label: tab.label(context.l10n),
              ),
          ],
        ),
      ),
    );
  }
}
