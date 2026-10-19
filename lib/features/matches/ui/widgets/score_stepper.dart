import 'package:flutter/material.dart';

import '../../../../core/theme.dart';

/// One side's goals: a name and a number with minus and plus buttons.
class ScoreStepper extends StatelessWidget {
  const ScoreStepper({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.caption,
    this.max = 99,
  });

  final String label;
  final String? caption;
  final int value;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                if (caption != null)
                  Text(
                    caption!,
                    style: TextStyle(fontSize: 13, color: p.mutedForeground),
                  ),
              ],
            ),
          ),
          _StepButton(
            icon: Icons.remove,
            tooltip: 'One less for $label',
            onPressed: value > 0 ? () => onChanged(value - 1) : null,
          ),
          SizedBox(
            width: 52,
            child: Semantics(
              label: '$label: $value',
              excludeSemantics: true,
              child: Text(
                '$value',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
            ),
          ),
          _StepButton(
            icon: Icons.add,
            tooltip: 'One more for $label',
            onPressed: value < max ? () => onChanged(value + 1) : null,
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      style: IconButton.styleFrom(
        fixedSize: const Size(44, 44),
        foregroundColor: p.foreground,
        disabledForegroundColor: p.mutedForeground.withValues(alpha: 0.5),
        side: BorderSide(color: p.input),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TonitsRadius.control),
        ),
      ),
    );
  }
}
