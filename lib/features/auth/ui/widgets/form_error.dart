import 'package:flutter/material.dart';

import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';

/// The screen's main action.
class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.label,
    required this.busy,
    required this.onPressed,
  });

  final String label;
  final bool busy;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(label: label, busy: busy, onPressed: onPressed);
  }
}

/// An inline error above a form's submit button.
class FormError extends StatelessWidget {
  const FormError(this.message, {super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    if (message == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: TonitsSpace.md),
      child: Notice(message!),
    );
  }
}
