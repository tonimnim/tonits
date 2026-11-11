import 'package:flutter/material.dart';

import '../theme.dart';

/// A round avatar: the player's photo when there is one, otherwise up to
/// two initials on warm grey. The initials also show while the photo loads
/// and if it can't.
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar({
    super.key,
    required this.name,
    this.size = 40,
    this.image,
  });

  final String name;
  final double size;
  final Uri? image;

  @override
  Widget build(BuildContext context) {
    final initials = _initials(context);
    final image = this.image;
    // Decoded at the size shown: a 1024 px photo in a 40 px circle would
    // otherwise hold about 4 MB of memory.
    final pixels = (size * MediaQuery.devicePixelRatioOf(context)).round();
    return ExcludeSemantics(
      child: image == null
          ? initials
          : ClipOval(
              child: Image.network(
                image.toString(),
                width: size,
                height: size,
                cacheWidth: pixels,
                fit: BoxFit.cover,
                frameBuilder: (_, child, frame, synchronous) =>
                    frame == null && !synchronous ? initials : child,
                errorBuilder: (_, _, _) => initials,
              ),
            ),
    );
  }

  Widget _initials(BuildContext context) {
    final p = context.palette;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: p.muted, shape: BoxShape.circle),
      child: Text(
        initialsOf(name),
        style: TextStyle(
          color: p.foreground,
          fontWeight: FontWeight.w600,
          fontSize: size * 0.36,
        ),
      ),
    );
  }
}

/// Up to two initials, from words that start with a letter: "Amina Otieno"
/// is "AO", "striker.9" is "S".
String initialsOf(String name) {
  final letter = RegExp(r'^\p{L}', unicode: true);
  final words = name
      .split(RegExp(r'[\s._-]+'))
      .where((w) => w.isNotEmpty && letter.hasMatch(w))
      .toList();
  if (words.isEmpty) return name.isEmpty ? '?' : name[0].toUpperCase();
  return words.take(2).map((w) => w[0].toUpperCase()).join();
}
