import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Brand palette. The app is dark: ink background, panel surfaces, paper
/// text, acid as the one loud accent.
abstract final class TonitsColors {
  static const ink = Color(0xFF11120F);
  static const panel = Color(0xFF1B1D19);
  static const paper = Color(0xFFF4F1E8);
  static const acid = Color(0xFFC7F135);

  /// Large or bold text only on ink (4.9:1).
  static const blue = Color(0xFF5677FF);
  static const orange = Color(0xFFFF7448);
  static const green = Color(0xFF4CCB74);
  static const muted = Color(0xFF92958D);

  /// Disabled and decorative only; never for readable text.
  static const subtleInk = Color(0xFF5D6058);

  /// Paper at 15%, for dividers and 1px borders on ink.
  static const line = Color(0x26F4F1E8);
}

abstract final class TonitsSpace {
  static const xs = 4.0, sm = 8.0, md = 16.0, lg = 22.0, xl = 32.0, xxl = 56.0;
}

abstract final class TonitsRadius {
  static const sm = 8.0, md = 13.0, lg = 18.0;
}

/// The brand's hard, blurless offset shadows.
const tonitsHardShadow = [
  BoxShadow(color: TonitsColors.ink, offset: Offset(5, 5)),
];
const tonitsCardShadow = [
  BoxShadow(color: TonitsColors.acid, offset: Offset(11, 11)),
];

/// [brandFonts] loads Geist through google_fonts; tests turn it off because
/// they can't fetch fonts.
ThemeData buildTheme({bool brandFonts = true}) {
  final base = ThemeData(brightness: Brightness.dark, useMaterial3: true);
  final sans = brandFonts
      ? GoogleFonts.geistTextTheme(base.textTheme)
      : base.textTheme;
  final text = sans.apply(
    bodyColor: TonitsColors.paper,
    displayColor: TonitsColors.paper,
  );
  TextStyle mono(TextStyle style) =>
      brandFonts ? GoogleFonts.geistMono(textStyle: style) : style;

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(TonitsRadius.sm),
    borderSide: const BorderSide(color: TonitsColors.line),
  );

  return base.copyWith(
    scaffoldBackgroundColor: TonitsColors.ink,
    colorScheme: const ColorScheme.dark(
      primary: TonitsColors.acid,
      onPrimary: TonitsColors.ink,
      secondary: TonitsColors.blue,
      onSecondary: TonitsColors.ink,
      tertiary: TonitsColors.orange,
      error: TonitsColors.orange,
      onError: TonitsColors.ink,
      surface: TonitsColors.panel,
      onSurface: TonitsColors.paper,
      onSurfaceVariant: TonitsColors.muted,
      outline: TonitsColors.line,
    ),
    textTheme: text.copyWith(
      // Display: weight 900, about -7% tracking, line height 0.85.
      displayLarge: text.displayLarge?.copyWith(
        fontWeight: FontWeight.w900,
        letterSpacing: -4,
        height: 0.85,
      ),
      displaySmall: text.displaySmall?.copyWith(
        fontWeight: FontWeight.w900,
        letterSpacing: -2.5,
        height: 0.85,
      ),
      headlineMedium: text.headlineMedium?.copyWith(
        fontWeight: FontWeight.w900,
        letterSpacing: -1,
      ),
      bodyLarge: text.bodyLarge?.copyWith(height: 1.5),
      bodyMedium: text.bodyMedium?.copyWith(height: 1.5),
      // Labels and eyebrows: mono 700, uppercase, about +10% tracking.
      labelSmall: mono(
        const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.1,
          color: TonitsColors.muted,
        ),
      ),
    ),
    dividerColor: TonitsColors.line,
    appBarTheme: const AppBarTheme(
      backgroundColor: TonitsColors.ink,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      color: TonitsColors.panel,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TonitsRadius.md),
        side: const BorderSide(color: TonitsColors.line),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: TonitsColors.panel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(TonitsRadius.lg),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: TonitsColors.panel,
      border: border,
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: const BorderSide(color: TonitsColors.acid, width: 2),
      ),
      errorBorder: border.copyWith(
        borderSide: const BorderSide(color: TonitsColors.orange),
      ),
      labelStyle: const TextStyle(color: TonitsColors.muted),
      helperStyle: const TextStyle(color: TonitsColors.muted),
    ),
    // Buttons: weight 800, uppercase (set in the label), about +4% tracking.
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: TonitsColors.acid,
        foregroundColor: TonitsColors.ink,
        disabledBackgroundColor: TonitsColors.subtleInk,
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TonitsRadius.sm),
        ),
        textStyle: text.labelLarge?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
          fontSize: 15,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: TonitsColors.paper,
        minimumSize: const Size.fromHeight(48),
        side: const BorderSide(color: TonitsColors.line),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TonitsRadius.sm),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: TonitsColors.acid),
    ),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: TonitsColors.panel,
      indicatorColor: TonitsColors.acid,
    ),
  );
}
