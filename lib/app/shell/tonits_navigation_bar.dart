import 'package:flutter/material.dart';

import '../../core/theme.dart';
import 'app_tab.dart';

/// The bottom bar: card surface, a hairline on top, and a lavender pill
/// behind the selected tab's icon.
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
          indicatorColor: p.soft,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          iconTheme: WidgetStateProperty.resolveWith(
            (states) => IconThemeData(
              size: 24,
              color: states.contains(WidgetState.selected)
                  ? p.onSoft
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
                  ? p.foreground
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
                label: tab.label,
              ),
          ],
        ),
      ),
    );
  }
}
