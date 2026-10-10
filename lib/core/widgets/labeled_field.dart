import 'package:flutter/material.dart';

import '../theme.dart';

/// A form field with its label above it. Screen readers reach the label just
/// before the field. (Merging the two into one node trips a semantics
/// assertion when the route is removed.)
class LabeledField extends StatelessWidget {
  const LabeledField({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: TonitsSpace.sm),
        child,
      ],
    );
  }
}
