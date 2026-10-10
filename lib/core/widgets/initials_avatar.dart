import 'package:flutter/material.dart';

import '../theme.dart';

/// A round lavender avatar with up to two initials.
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar({super.key, required this.name, this.size = 40});

  final String name;
  final double size;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return ExcludeSemantics(
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: p.soft, shape: BoxShape.circle),
        child: Text(
          initialsOf(name),
          style: TextStyle(
            color: p.onSoft,
            fontWeight: FontWeight.w700,
            fontSize: size * 0.36,
          ),
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
