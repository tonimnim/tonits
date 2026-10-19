import 'package:flutter/material.dart';

import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';

/// One side's goals: who, and a big number between round minus and plus
/// buttons.
class ScoreStepper extends StatelessWidget {
  const ScoreStepper({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.avatarName,
    this.max = 99,
  });

  final String label;

  /// Whose initials to show beside the label.
  final String? avatarName;
  final int value;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          InitialsAvatar(name: avatarName ?? label),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          RoundIconButton(
            icon: Icons.remove,
            tooltip: 'One less for $label',
            size: 44,
            onPressed: value > 0 ? () => onChanged(value - 1) : null,
          ),
          SizedBox(
            width: 56,
            child: Semantics(
              label: '$label: $value',
              excludeSemantics: true,
              child: Text(
                '$value',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                  color: p.foreground,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
          ),
          RoundIconButton(
            icon: Icons.add,
            tooltip: 'One more for $label',
            size: 44,
            background: p.soft,
            foreground: p.onSoft,
            onPressed: value < max ? () => onChanged(value + 1) : null,
          ),
        ],
      ),
    );
  }
}
