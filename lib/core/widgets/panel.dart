import 'package:flutter/material.dart';

import '../theme.dart';

/// A generously rounded, flat card for a screen's main content, set apart
/// from the canvas by tone alone, with continuous corners.
class Panel extends StatelessWidget {
  const Panel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.radius = TonitsRadius.panel,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final shape = TonitsShape.rounded(radius);
    return Material(
      color: p.card,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
