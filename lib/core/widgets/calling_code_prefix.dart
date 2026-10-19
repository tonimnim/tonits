import 'package:flutter/material.dart';

import '../countries.dart';
import '../l10n.dart';
import '../theme.dart';

/// The flag and calling code inside the field; tapping changes country.
class CallingCodePrefix extends StatelessWidget {
  const CallingCodePrefix({
    super.key,
    required this.country,
    required this.onTap,
  });

  final Country country;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Semantics(
      button: true,
      label: context.l10n.callingCodeLabel(country.dialCode, country.name),
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(TonitsRadius.control),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 0, 10, 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(country.flag, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 6),
              Text(
                '+${country.dialCode}',
                style: monoFont.copyWith(color: p.foreground),
              ),
              Icon(Icons.expand_more, size: 18, color: p.mutedForeground),
              const SizedBox(width: 6),
              Container(width: 1, height: 22, color: p.border),
            ],
          ),
        ),
      ),
    );
  }
}
