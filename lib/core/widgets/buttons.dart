import 'package:flutter/material.dart';

import '../theme.dart';

// Button styles replace the theme's font unless it is named again.
const _label = TextStyle(
  fontFamily: 'Geist',
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

/// The screen's one main action: a full-width solid indigo button.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.busy = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return FilledButton(
      // Stays enabled-looking while busy so the button doesn't flash grey.
      onPressed: busy ? () {} : onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        backgroundColor: palette.primary,
        foregroundColor: palette.onPrimary,
        disabledBackgroundColor: palette.primary.withValues(alpha: 0.45),
        disabledForegroundColor: palette.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TonitsRadius.control),
        ),
        textStyle: _label,
      ),
      child: busy
          ? Semantics(
              label: '$label, working',
              child: SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  color: palette.onPrimary,
                ),
              ),
            )
          : Text(label),
    );
  }
}

/// A secondary action: card fill with a hairline border.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.destructive = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  /// Red text, for actions such as signing out.
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final style = OutlinedButton.styleFrom(
      minimumSize: const Size.fromHeight(52),
      backgroundColor: palette.card,
      foregroundColor: destructive ? palette.destructive : palette.foreground,
      side: BorderSide(color: palette.input),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TonitsRadius.control),
      ),
      textStyle: _label,
    );
    return icon == null
        ? OutlinedButton(onPressed: onPressed, style: style, child: Text(label))
        : OutlinedButton.icon(
            onPressed: onPressed,
            style: style,
            icon: Icon(icon, size: 20),
            label: Text(label),
          );
  }
}
