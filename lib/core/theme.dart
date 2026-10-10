import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Tonits colours, taken from the staff dashboard's `theme.css`: a soft grey
/// canvas, white rounded cards and an indigo accent with lavender tints, and
/// a deep navy dark mode with the same accent.
@immutable
class TonitsPalette extends ThemeExtension<TonitsPalette> {
  const TonitsPalette({
    required this.background,
    required this.foreground,
    required this.card,
    required this.primary,
    required this.onPrimary,
    required this.soft,
    required this.onSoft,
    required this.muted,
    required this.mutedForeground,
    required this.subtleForeground,
    required this.border,
    required this.input,
    required this.ring,
    required this.destructive,
    required this.good,
    required this.info,
    required this.warn,
  });

  final Color background;
  final Color foreground;
  final Color card;
  final Color primary;
  final Color onPrimary;

  /// Lavender tint for selected and secondary surfaces, and text on it.
  final Color soft;
  final Color onSoft;
  final Color muted;

  /// Labels and captions. Below 4.5:1 on cards, so keep it to short labels.
  final Color mutedForeground;

  /// Secondary body text, readable at any size.
  final Color subtleForeground;
  final Color border;
  final Color input;
  final Color ring;
  final Color destructive;

  /// Status tones: (text, fill).
  final (Color, Color) good;
  final (Color, Color) info;
  final (Color, Color) warn;

  static const light = TonitsPalette(
    background: Color(0xFFF4F5FA),
    foreground: Color(0xFF1B1D3A),
    card: Color(0xFFFFFFFF),
    primary: Color(0xFF5B5BD6),
    onPrimary: Color(0xFFFFFFFF),
    soft: Color(0xFFEEF0FB),
    onSoft: Color(0xFF3F40B5),
    muted: Color(0xFFF1F2F8),
    mutedForeground: Color(0xFF858AA3),
    subtleForeground: Color(0xFF4A4E6B),
    border: Color(0xFFECEEF5),
    input: Color(0xFFE3E5EF),
    ring: Color(0xFF8B8CF0),
    destructive: Color(0xFFD13A3F),
    good: (Color(0xFF23824A), Color(0x264CCB74)),
    info: (Color(0xFF3150D8), Color(0x265677FF)),
    warn: (Color(0xFFC4421D), Color(0x26FF7448)),
  );

  static const dark = TonitsPalette(
    background: Color(0xFF0F1022),
    foreground: Color(0xFFECEEFE),
    card: Color(0xFF17182E),
    primary: Color(0xFF7C7CF0),
    onPrimary: Color(0xFFFFFFFF),
    soft: Color(0xFF23244A),
    onSoft: Color(0xFFD7D8FF),
    muted: Color(0xFF1F2040),
    mutedForeground: Color(0xFF9396B8),
    subtleForeground: Color(0xFFC3C5E0),
    border: Color(0x14FFFFFF),
    input: Color(0x1FFFFFFF),
    ring: Color(0xFF7C7CF0),
    destructive: Color(0xFFFF6369),
    good: (Color(0xFF7EE0A0), Color(0x264CCB74)),
    info: (Color(0xFF9AAEFF), Color(0x265677FF)),
    warn: (Color(0xFFFF9B78), Color(0x26FF7448)),
  );

  @override
  TonitsPalette copyWith() => this;

  @override
  TonitsPalette lerp(TonitsPalette? other, double t) =>
      t < 0.5 || other == null ? this : other;
}

extension TonitsTheme on BuildContext {
  TonitsPalette get palette => Theme.of(this).extension<TonitsPalette>()!;
}

abstract final class TonitsSpace {
  static const xs = 4.0, sm = 8.0, md = 16.0, lg = 24.0, xl = 32.0, xxl = 48.0;
}

abstract final class TonitsRadius {
  /// Inputs and buttons.
  static const control = 12.0;

  /// Cards and sheets.
  static const card = 16.0;
}

/// The wordmark face: Alexandria ExtraBold.
const brandFont = TextStyle(
  fontFamily: 'Alexandria',
  fontWeight: FontWeight.w800,
  fontVariations: [FontVariation.weight(800)],
);

/// Monospace, for codes such as Konami IDs and calling codes.
const monoFont = TextStyle(fontFamily: 'GeistMono');

SystemUiOverlayStyle systemUiFor(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  final palette = dark ? TonitsPalette.dark : TonitsPalette.light;
  return SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: dark ? Brightness.light : Brightness.dark,
    statusBarBrightness: brightness,
    systemNavigationBarColor: palette.background,
    systemNavigationBarIconBrightness: dark
        ? Brightness.light
        : Brightness.dark,
  );
}

ThemeData buildTheme(Brightness brightness) {
  final p = brightness == Brightness.dark
      ? TonitsPalette.dark
      : TonitsPalette.light;
  final base = ThemeData(
    brightness: brightness,
    useMaterial3: true,
    fontFamily: 'Geist',
  );
  final text = base.textTheme.apply(
    bodyColor: p.foreground,
    displayColor: p.foreground,
  );

  OutlineInputBorder outline(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(TonitsRadius.control),
        borderSide: BorderSide(color: color, width: width),
      );

  return base.copyWith(
    scaffoldBackgroundColor: p.background,
    extensions: [p],
    colorScheme: ColorScheme(
      brightness: brightness,
      primary: p.primary,
      onPrimary: p.onPrimary,
      secondary: p.soft,
      onSecondary: p.onSoft,
      error: p.destructive,
      onError: Colors.white,
      surface: p.background,
      onSurface: p.foreground,
      onSurfaceVariant: p.mutedForeground,
      surfaceContainerLowest: p.card,
      surfaceContainerLow: p.card,
      surfaceContainer: p.card,
      surfaceContainerHigh: p.card,
      outline: p.input,
      outlineVariant: p.border,
    ),
    textTheme: text.copyWith(
      headlineMedium: text.headlineMedium?.copyWith(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.75,
        height: 1.15,
      ),
      headlineSmall: text.headlineSmall?.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      titleMedium: text.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      bodyLarge: text.bodyLarge?.copyWith(height: 1.5),
      bodyMedium: text.bodyMedium?.copyWith(height: 1.5),
      labelLarge: text.labelLarge?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    dividerTheme: DividerThemeData(color: p.border, thickness: 1, space: 1),
    appBarTheme: AppBarTheme(
      backgroundColor: p.background,
      toolbarHeight: 56,
      // Titles line up with the content's 24px edge.
      titleSpacing: TonitsSpace.lg,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: 'Geist',
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: p.foreground,
      ),
      foregroundColor: p.foreground,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      systemOverlayStyle: systemUiFor(brightness),
    ),
    cardTheme: CardThemeData(
      color: p.card,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TonitsRadius.card),
        side: BorderSide(color: p.border),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: p.card,
      surfaceTintColor: Colors.transparent,
      showDragHandle: true,
      dragHandleColor: p.input,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: p.card,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TonitsRadius.control),
        side: BorderSide(color: p.border),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: p.foreground,
      contentTextStyle: text.bodyMedium?.copyWith(color: p.background),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TonitsRadius.control),
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: p.primary),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: p.primary,
      selectionColor: p.ring.withValues(alpha: 0.35),
      selectionHandleColor: p.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: p.card,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      border: outline(p.input),
      enabledBorder: outline(p.input),
      disabledBorder: outline(p.border),
      focusedBorder: outline(p.primary, 1.5),
      errorBorder: outline(p.destructive),
      focusedErrorBorder: outline(p.destructive, 1.5),
      hintStyle: TextStyle(color: p.mutedForeground),
      helperStyle: TextStyle(color: p.mutedForeground, fontSize: 12),
      errorStyle: TextStyle(color: p.destructive, fontSize: 12),
      prefixIconColor: p.mutedForeground,
      suffixIconColor: p.mutedForeground,
      helperMaxLines: 2,
      errorMaxLines: 2,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: p.primary,
        // Button styles replace the theme font unless it is named again.
        textStyle: const TextStyle(
          fontFamily: 'Geist',
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: p.foreground),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: p.mutedForeground,
      textColor: p.foreground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TonitsRadius.control),
      ),
    ),
  );
}
