import 'package:flutter/material.dart';

import '../theme.dart';

/// A small rounded label with an optional icon, such as a countdown or
/// "Full time". Takes its colours from [color] on a light tint of it.
class Pill extends StatelessWidget {
  const Pill(this.label, {super.key, this.icon, this.color, this.filled});

  final String label;
  final IconData? icon;

  /// The text and icon colour; the fill is a tint of it.
  final Color? color;

  /// Overrides the tinted fill.
  final Color? filled;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final color = this.color ?? p.subtleForeground;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: filled ?? color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 15, color: color),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: color,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
