import 'package:flutter/material.dart';

import '../theme.dart';

/// One headline number on a card: the value, a short label, and an optional
/// detail line (such as "last 20 matches").
class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.value,
    required this.label,
    this.detail,
    this.valueColor,
  });

  final String value;
  final String label;
  final String? detail;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return MergeSemantics(
      child: Container(
        padding: const EdgeInsets.all(TonitsSpace.md),
        decoration: BoxDecoration(
          color: p.card,
          borderRadius: BorderRadius.circular(TonitsRadius.card),
          border: Border.all(color: p.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              maxLines: 1,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
                height: 1.1,
                color: valueColor ?? p.foreground,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(fontSize: 13, color: p.subtleForeground),
            ),
            if (detail != null)
              Text(
                detail!,
                style: TextStyle(fontSize: 11, color: p.mutedForeground),
              ),
          ],
        ),
      ),
    );
  }
}
