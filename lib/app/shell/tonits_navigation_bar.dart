import 'package:flutter/material.dart';

import '../../core/l10n.dart';
import '../../core/theme.dart';
import 'app_tab.dart';

/// The bottom bar: a floating, fully rounded bar inset from the screen's
/// edges, with icons alone. The selected one sits in a filled circle,
/// near-black by day and volt at night. Each tab's name is its tooltip and
/// what a screen reader says.
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
    final dark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: 12),
      child: Padding(
        // Inset further than the page, so the icons sit closer together.
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: ShapeDecoration(
            color: p.card,
            shape: const StadiumBorder(),
            // The one shadow in the app: the bar floats over the page.
            shadows: [
              BoxShadow(
                color: dark
                    ? Colors.black.withValues(alpha: 0.45)
                    : Colors.black.withValues(alpha: 0.08),
                blurRadius: 24,
                spreadRadius: -6,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (final tab in AppTab.values)
                _Tab(
                  tab: tab,
                  selected: tab == selected,
                  onTap: () => onSelected(tab),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({required this.tab, required this.selected, required this.onTap});

  final AppTab tab;
  final bool selected;
  final VoidCallback onTap;

  static const _duration = Duration(milliseconds: 220);

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final dark = Theme.of(context).brightness == Brightness.dark;
    // Near-black on the white bar; volt on the charcoal one, where black
    // wouldn't show.
    final (fill, ink) = dark ? (p.soft, p.onSoft) : (p.foreground, p.card);
    final label = tab.label(context.l10n);

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: Tooltip(
        message: label,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: AnimatedContainer(
            duration: _duration,
            curve: Curves.easeOutCubic,
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: selected ? fill : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              selected ? tab.selectedIcon : tab.icon,
              size: 28,
              color: selected ? ink : p.mutedForeground,
            ),
          ),
        ),
      ),
    );
  }
}
