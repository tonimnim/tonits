import 'package:flutter/material.dart';

import '../theme.dart';

/// A row of choices that scrolls sideways, such as a bracket's rounds. The
/// selected one starts in view.
class ChoiceChips<T> extends StatefulWidget {
  const ChoiceChips({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  final Map<T, String> options;
  final T selected;
  final ValueChanged<T> onChanged;

  @override
  State<ChoiceChips<T>> createState() => _ChoiceChipsState<T>();
}

class _ChoiceChipsState<T> extends State<ChoiceChips<T>> {
  final _selectedKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selected = _selectedKey.currentContext;
      if (selected != null && selected.mounted) {
        Scrollable.ensureVisible(selected, alignment: 0.5);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final dark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final (i, MapEntry(key: value, value: label))
              in widget.options.entries.indexed) ...[
            if (i > 0) const SizedBox(width: 8),
            Semantics(
              key: value == widget.selected ? _selectedKey : null,
              selected: value == widget.selected,
              button: true,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => widget.onChanged(value),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: value == widget.selected
                        ? p.primary
                        : dark
                        ? p.card
                        : p.muted,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: value == widget.selected
                          ? p.onPrimary
                          : p.subtleForeground,
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
