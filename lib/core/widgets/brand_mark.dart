import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme.dart';

/// The Tonits mark: a circular "G" whose counter is a game controller. Below
/// 48px it reads as a silhouette, which is fine for a badge.
class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 32, this.color});

  final double size;

  /// Defaults to the primary indigo.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/brand/mark.svg',
      width: size,
      height: size,
      excludeFromSemantics: true,
      colorFilter: ColorFilter.mode(
        color ?? context.palette.primary,
        BlendMode.srcIn,
      ),
    );
  }
}

/// The mark beside the "Tonits" wordmark in Alexandria ExtraBold.
class BrandLockup extends StatelessWidget {
  const BrandLockup({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Tonits',
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BrandMark(size: 32),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              'Tonits',
              overflow: TextOverflow.ellipsis,
              style: brandFont.copyWith(
                fontSize: 18,
                height: 1,
                letterSpacing: -0.4,
                color: context.palette.foreground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
