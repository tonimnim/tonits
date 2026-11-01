import 'package:flutter/material.dart';

import '../theme.dart';

enum StatusTone { good, info, warn, bad, muted }

extension StatusToneColors on StatusTone {
  /// The tone's text and fill colours.
  (Color, Color) colorsIn(TonitsPalette p) => switch (this) {
    StatusTone.good => p.good,
    StatusTone.info => p.info,
    StatusTone.warn => p.warn,
    StatusTone.bad => (p.destructive, p.destructive.withValues(alpha: 0.15)),
    StatusTone.muted => (p.mutedForeground, p.muted),
  };
}

/// A status chip: a short label on a soft tint of its tone.
class StatusBadge extends StatelessWidget {
  const StatusBadge(this.label, {super.key, required this.tone});

  final String label;
  final StatusTone tone;

  @override
  Widget build(BuildContext context) {
    final (text, fill) = tone.colorsIn(context.palette);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      // A soft tint, no edge: the tone says what it means.
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        maxLines: 1,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: text,
        ),
      ),
    );
  }
}
