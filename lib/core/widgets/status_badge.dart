import 'package:flutter/material.dart';

import '../theme.dart';

enum StatusTone { good, info, warn, bad, muted }

/// The dashboard's status chip: a tinted, mono label.
class StatusBadge extends StatelessWidget {
  const StatusBadge(this.label, {super.key, required this.tone});

  final String label;
  final StatusTone tone;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final (text, fill) = switch (tone) {
      StatusTone.good => p.good,
      StatusTone.info => p.info,
      StatusTone.warn => p.warn,
      StatusTone.bad => (p.destructive, p.destructive.withValues(alpha: 0.15)),
      StatusTone.muted => (p.mutedForeground, p.muted),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: text.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        maxLines: 1,
        style: monoFont.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: text,
        ),
      ),
    );
  }
}
