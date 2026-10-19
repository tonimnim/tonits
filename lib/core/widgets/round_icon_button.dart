import 'package:flutter/material.dart';

import '../theme.dart';

/// A circular icon button on a soft fill, for headers and inline actions
/// such as copying a value. Flat: no shadow in any state.
class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.size = 40,
    this.background,
    this.foreground,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final double size;
  final Color? background;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Icon(icon, size: size * 0.45),
      style: IconButton.styleFrom(
        fixedSize: Size.square(size),
        minimumSize: Size.square(size),
        padding: EdgeInsets.zero,
        backgroundColor: background ?? p.muted,
        foregroundColor: foreground ?? p.foreground,
        disabledBackgroundColor: (background ?? p.muted).withValues(alpha: 0.5),
        disabledForegroundColor: p.mutedForeground.withValues(alpha: 0.5),
        elevation: 0,
        shape: const CircleBorder(),
      ),
    );
  }
}
