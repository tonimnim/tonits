import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';

/// The Tonits mark at the centre of two soft rings, with what the app is
/// about orbiting it: competitions, matches, rankings and the game.
class WelcomeOrbit extends StatelessWidget {
  const WelcomeOrbit({super.key, this.size = 280});

  final double size;

  static const _icons = [
    (Icons.emoji_events_outlined, 300.0),
    (Icons.sports_esports_outlined, 20.0),
    (Icons.leaderboard_outlined, 95.0),
    (Icons.sports_soccer_outlined, 160.0),
    (Icons.payments_outlined, 225.0),
  ];

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final ring = p.card.withValues(alpha: 0.35);
    final outer = size / 2;
    final inner = size * 0.32;
    return ExcludeSemantics(
      child: SizedBox.square(
        dimension: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _Disc(diameter: size, color: ring),
            _Disc(diameter: inner * 2, color: ring),
            Container(
              width: size * 0.3,
              height: size * 0.3,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: p.card, shape: BoxShape.circle),
              child: BrandMark(size: size * 0.14),
            ),
            for (final (i, (icon, degrees)) in _icons.indexed)
              _Satellite(
                icon: icon,
                // Alternate rings, so the icons don't sit in a line.
                radius: i.isEven ? outer - 4 : inner,
                degrees: degrees,
              ),
          ],
        ),
      ),
    );
  }
}

class _Disc extends StatelessWidget {
  const _Disc({required this.diameter, required this.color});

  final double diameter;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: diameter,
    height: diameter,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

class _Satellite extends StatelessWidget {
  const _Satellite({
    required this.icon,
    required this.radius,
    required this.degrees,
  });

  final IconData icon;
  final double radius;
  final double degrees;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final angle = degrees * pi / 180;
    return Transform.translate(
      offset: Offset(cos(angle) * radius, sin(angle) * radius),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: p.card,
          shape: BoxShape.circle,
          border: Border.all(color: p.soft, width: 3),
        ),
        child: Icon(icon, size: 20, color: p.primary),
      ),
    );
  }
}
