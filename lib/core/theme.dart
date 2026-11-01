import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Ozone's colours: a quiet neutral canvas with white cards, near-black
/// text and actions, and indigo as the single accent; a near-black dark
/// mode with the same accent.
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

  /// A step off the canvas for selected and secondary surfaces, and text
  /// on it.
  final Color soft;
  final Color onSoft;
  final Color muted;

  /// Labels and captions, at 4.5:1 or more on cards and the canvas.
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

  // Neutral canvas and cards, told apart by tone rather than lines or
  // shadows. Indigo is the one accent: the rating card, the selected tab,
  // focus. Colour otherwise only means something (good, warn, bad).
  static const light = TonitsPalette(
    background: Color(0xFFF2F2F4),
    foreground: Color(0xFF18181B),
    card: Color(0xFFFFFFFF),
    primary: Color(0xFF5B5BD6),
    onPrimary: Color(0xFFFFFFFF),
    soft: Color(0xFFE8E8EC),
    onSoft: Color(0xFF18181B),
    muted: Color(0xFFE8E8EC),
    mutedForeground: Color(0xFF71717A),
    subtleForeground: Color(0xFF52525B),
    border: Color(0xFFE6E6EA),
    input: Color(0xFFE0E0E5),
    ring: Color(0xFF8B8CF0),
    destructive: Color(0xFFD13A3F),
    good: (Color(0xFF1F7A44), Color(0x264CCB74)),
    info: (Color(0xFF3150D8), Color(0x265677FF)),
    warn: (Color(0xFFB83D1A), Color(0x26FF7448)),
  );

  static const dark = TonitsPalette(
    background: Color(0xFF0E0E10),
    foreground: Color(0xFFF4F4F5),
    card: Color(0xFF1B1B1F),
    // The light theme's indigo: white on it stays readable on the card.
    primary: Color(0xFF6262E0),
    onPrimary: Color(0xFFFFFFFF),
    soft: Color(0xFF27272B),
    onSoft: Color(0xFFF4F4F5),
    muted: Color(0xFF232327),
    mutedForeground: Color(0xFFA1A1AA),
    subtleForeground: Color(0xFFD4D4D8),
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
  /// Inputs and small controls.
  static const control = 16.0;

  /// Cards.
  static const card = 24.0;

  /// Small tiles, such as a fact with its icon.
  static const tile = 20.0;

  /// Feature cards, such as the match room's main panel.
  static const panel = 28.0;

  /// The top of a sheet laid over a tinted hero.
  static const sheet = 32.0;
}

/// Continuous ("squircle") corners, as on iOS: the straight edge eases
/// into the curve instead of meeting a circular arc. Every rounded surface
/// uses them. A surface inside another takes its parent's radius minus the
/// gap between them, so the corners stay concentric.
abstract final class TonitsShape {
  static OutlinedBorder rounded(
    double radius, {
    BorderSide side = BorderSide.none,
  }) => RoundedSuperellipseBorder(
    borderRadius: BorderRadius.circular(radius),
    side: side,
  );

  /// Rounded on top only, such as a bottom sheet or a pinned bar.
  static OutlinedBorder top(double radius) => RoundedSuperellipseBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
  );

  /// A fill with these corners, for a [Container]'s decoration.
  static ShapeDecoration fill(
    Color color,
    double radius, {
    BorderSide side = BorderSide.none,
  }) => ShapeDecoration(
    color: color,
    shape: rounded(radius, side: side),
  );
}

/// The wordmark face: Alexandria ExtraBold.
const brandFont = TextStyle(
  fontFamily: 'Alexandria',
  fontWeight: FontWeight.w600,
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

  // Fields are filled grey pills of the canvas's next tone, outlined only
  // when focused or wrong.
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
        fontWeight: FontWeight.w600,
        letterSpacing: -0.6,
        height: 1.15,
      ),
      headlineSmall: text.headlineSmall?.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.4,
      ),
      titleMedium: text.titleMedium?.copyWith(fontWeight: FontWeight.w500),
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
        fontWeight: FontWeight.w600,
        letterSpacing: -0.4,
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
      // Told apart from the canvas by tone alone: no edge, no shadow.
      shape: TonitsShape.rounded(TonitsRadius.card),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: p.card,
      surfaceTintColor: Colors.transparent,
      showDragHandle: true,
      dragHandleColor: p.input,
      shape: TonitsShape.top(TonitsRadius.sheet),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: p.card,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: TonitsShape.rounded(TonitsRadius.panel),
      titleTextStyle: TextStyle(
        fontFamily: 'Geist',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
        color: p.foreground,
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: p.card,
      surfaceTintColor: Colors.transparent,
      shape: TonitsShape.rounded(TonitsRadius.control),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: p.foreground,
      contentTextStyle: text.bodyMedium?.copyWith(color: p.background),
      behavior: SnackBarBehavior.floating,
      shape: TonitsShape.rounded(TonitsRadius.control),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: p.primary),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: p.primary,
      selectionColor: p.ring.withValues(alpha: 0.35),
      selectionHandleColor: p.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: p.muted,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
      border: outline(Colors.transparent),
      enabledBorder: outline(Colors.transparent),
      disabledBorder: outline(Colors.transparent),
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
        // Neutral: indigo is kept for the one accent on a screen.
        foregroundColor: p.foreground,
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
      shape: TonitsShape.rounded(TonitsRadius.control),
    ),
  );
}
