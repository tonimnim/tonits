import 'package:flutter/material.dart';

import '../theme.dart';

// Button styles replace the theme's font unless it is named again.
const _label = TextStyle(
  fontFamily: 'Geist',
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

/// The screen's one main action: a full-width near-black pill (white in the
/// dark theme), so indigo stays the single accent.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.busy = false,
    this.pill = true,
    this.destructive = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool busy;

  /// Fully rounded ends (the default); false for a 16px corner.
  final bool pill;

  /// Red, for an action that can't be undone, such as deleting the account.
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final fill = destructive ? palette.destructive : palette.foreground;
    final ink = destructive ? Colors.white : palette.background;
    return FilledButton(
      // Stays enabled-looking while busy so the button doesn't flash grey.
      onPressed: busy ? () {} : onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(54),
        backgroundColor: fill,
        foregroundColor: ink,
        disabledBackgroundColor: fill.withValues(alpha: 0.3),
        disabledForegroundColor: ink,
        // Flat: no elevation, shadow or tint, in any state.
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: pill
            ? const StadiumBorder()
            : TonitsShape.rounded(TonitsRadius.control),
        textStyle: _label,
      ),
      child: busy
          ? Semantics(
              label: '$label, working',
              child: SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(strokeWidth: 2.2, color: ink),
              ),
            )
          : Text(label),
    );
  }
}

/// A secondary action: a hairline outline on a transparent background.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.destructive = false,
    this.pill = true,
    this.background,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  /// A fill behind the outline, such as the card colour on a tinted hero.
  final Color? background;

  /// Red text, for actions such as signing out.
  final bool destructive;

  /// Fully rounded ends (the default); false for a 16px corner.
  final bool pill;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final style = OutlinedButton.styleFrom(
      minimumSize: const Size.fromHeight(54),
      // A plain outline on the page, flat in every state.
      backgroundColor: background ?? Colors.transparent,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      foregroundColor: destructive ? palette.destructive : palette.foreground,
      side: BorderSide(color: palette.input),
      shape: pill
          ? const StadiumBorder()
          : TonitsShape.rounded(TonitsRadius.control),
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
