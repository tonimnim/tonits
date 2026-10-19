import 'package:flutter/material.dart';

import '../theme.dart';
import 'panel.dart';

/// One fact as a small tile: an icon in a soft circle, a quiet label and a
/// bold value, such as "Entry · Ksh 100". Lay three in a row.
class FactTile extends StatelessWidget {
  const FactTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.mono = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool mono;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    const valueStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w700);
    return Semantics(
      button: onTap != null,
      label: '$label: $value',
      excludeSemantics: true,
      child: Panel(
        radius: TonitsRadius.tile,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        onTap: onTap,
        child: Column(
          children: [
            IconDot(icon: icon),
            const SizedBox(height: 12),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: p.mutedForeground),
            ),
            const SizedBox(height: 2),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                maxLines: 1,
                style: mono
                    ? monoFont
                          .merge(valueStyle)
                          .copyWith(fontWeight: FontWeight.w600)
                    : valueStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A row of [FactTile]s (or anything) sharing the height of the tallest.
class FactRow extends StatelessWidget {
  const FactRow({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (i, child) in children.indexed) ...[
            if (i > 0) const SizedBox(width: 10),
            Expanded(child: child),
          ],
        ],
      ),
    );
  }
}

/// An icon in a soft circle.
class IconDot extends StatelessWidget {
  const IconDot({super.key, required this.icon, this.size = 36});

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: p.soft, shape: BoxShape.circle),
      child: Icon(icon, size: size / 2, color: p.onSoft),
    );
  }
}
