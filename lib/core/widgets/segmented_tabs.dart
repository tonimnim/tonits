import 'package:flutter/material.dart';

import '../theme.dart';

/// A compact two-to-four option switch, such as "Active · History".
class SegmentedTabs<T> extends StatelessWidget {
  const SegmentedTabs({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  final Map<T, String> options;
  final T selected;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    // The selected segment is the raised, lighter surface in both themes.
    final dark = Theme.of(context).brightness == Brightness.dark;
    final track = dark ? p.card : p.muted;
    final thumb = dark ? p.soft : p.card;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: track,
        borderRadius: BorderRadius.circular(TonitsRadius.control),
      ),
      child: Row(
        children: [
          for (final MapEntry(key: value, value: label) in options.entries)
            Expanded(
              child: Semantics(
                selected: value == selected,
                button: true,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onChanged(value),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: value == selected ? thumb : Colors.transparent,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: value == selected
                          ? [
                              BoxShadow(
                                color: p.foreground.withValues(alpha: 0.06),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: value == selected
                            ? p.foreground
                            : p.mutedForeground,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
