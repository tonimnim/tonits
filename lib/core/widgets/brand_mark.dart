import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../l10n.dart';
import '../theme.dart';

/// The Orbits mark: a ring whose counter is a game controller; in the
/// wordmark it is the "O". Below 48px it reads as a silhouette.
class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 32, this.color});

  final double size;

  /// Defaults to the text colour.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/brand/mark.svg',
      width: size,
      height: size,
      excludeFromSemantics: true,
      colorFilter: ColorFilter.mode(
        color ?? context.palette.foreground,
        BlendMode.srcIn,
      ),
    );
  }
}

/// The Orbits wordmark: the mark stands in for the "O", followed by "rbits"
/// in Alexandria ExtraBold.
class BrandLockup extends StatelessWidget {
  const BrandLockup({super.key, this.size = 22});

  /// The wordmark's font size; the mark is sized to match.
  final double size;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.l10n.appName,
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BrandMark(size: size * 1.08),
          SizedBox(width: size * 0.06),
          Text(
            'rbits',
            style: brandFont.copyWith(
              fontSize: size,
              height: 1,
              letterSpacing: -0.02 * size,
              color: context.palette.foreground,
            ),
          ),
        ],
      ),
    );
  }
}
