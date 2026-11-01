import 'package:flutter/material.dart';

import '../../core/l10n.dart';
import '../../core/theme.dart';
import 'app_tab.dart';

/// The bottom bar: a floating, fully rounded bar inset from the screen's
/// edges. The selected tab grows into a filled pill with its icon and name;
/// the others are icons alone, with their names as tooltips and for screen
/// readers.
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
        padding: const EdgeInsets.symmetric(horizontal: TonitsSpace.md),
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
                    : p.primary.withValues(alpha: 0.12),
                blurRadius: 24,
                spreadRadius: -6,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final tab in AppTab.values)
                // The selected pill may give up width on a narrow phone:
                // its name shortens rather than the bar overflowing.
                tab == selected
                    ? Flexible(
                        child: _Tab(
                          tab: tab,
                          selected: true,
                          onTap: () => onSelected(tab),
                        ),
                      )
                    : _Tab(
                        tab: tab,
                        selected: false,
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

  static const _duration = Duration(milliseconds: 260);

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final dark = Theme.of(context).brightness == Brightness.dark;
    // Electric blue with white on the light bar; volt yellow with navy on
    // the navy one, where blue wouldn't stand out.
    final (fill, ink) = dark ? (p.soft, p.onSoft) : (p.primary, p.onPrimary);
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
          customBorder: const StadiumBorder(),
          child: AnimatedContainer(
            duration: _duration,
            curve: Curves.easeOutCubic,
            height: 44,
            padding: EdgeInsets.symmetric(horizontal: selected ? 16 : 12),
            decoration: ShapeDecoration(
              color: selected ? fill : Colors.transparent,
              shape: const StadiumBorder(),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  selected ? tab.selectedIcon : tab.icon,
                  size: 22,
                  color: selected ? ink : p.mutedForeground,
                ),
                Flexible(
                  child: AnimatedSize(
                    duration: _duration,
                    curve: Curves.easeOutCubic,
                    child: selected
                        ? Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: ink,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
