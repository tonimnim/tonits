import 'package:flutter/material.dart';

import '../theme.dart';

/// The app's pictures, by where they go. Each is null until its art is
/// made, and then the path of a bundled image (listed under `assets:` in
/// pubspec.yaml). They must be Orbits' own art, never Konami's.
abstract final class TonitsArt {
  /// Welcome's hero, above the headline. Square, around 1080px.
  static const String? welcome = null;
}

/// A picture with continuous corners, or [fallback] while there's no art
/// for it yet or it can't be loaded.
class Artwork extends StatelessWidget {
  const Artwork({
    super.key,
    required this.asset,
    required this.fallback,
    this.radius = TonitsRadius.panel,
    this.semanticLabel,
  });

  final String? asset;
  final Widget fallback;
  final double radius;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final path = asset;
    if (path == null) return fallback;
    return ClipRSuperellipse(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        path,
        fit: BoxFit.cover,
        semanticLabel: semanticLabel,
        excludeFromSemantics: semanticLabel == null,
        errorBuilder: (_, _, _) => fallback,
      ),
    );
  }
}
