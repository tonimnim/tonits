import 'package:flutter/material.dart';

import '../theme.dart';

/// A short row of two to four choices, such as "Open · Live · Finished":
/// pill chips, the selected one filled near-black (volt at night), the
/// rest grey. Scrolls sideways if the names don't fit.
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
    final dark = Theme.of(context).brightness == Brightness.dark;
    final (fill, ink) = dark
        ? (p.soft, p.onSoft)
        : (p.foreground, p.background);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final (i, MapEntry(key: value, value: label))
              in options.entries.indexed) ...[
            if (i > 0) const SizedBox(width: 8),
            Semantics(
              selected: value == selected,
              button: true,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onChanged(value),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: value == selected
                        ? fill
                        : dark
                        ? p.card
                        : p.muted,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: value == selected ? ink : p.subtleForeground,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
