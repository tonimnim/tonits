import 'package:flutter/material.dart';

import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    this.label = 'Password',
    this.hint = 'Your password',
    this.validator,
    this.newPassword = false,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final FormFieldValidator<String>? validator;
  final bool newPassword;
  final VoidCallback? onSubmitted;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    return LabeledField(
      label: widget.label,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _hidden,
        autocorrect: false,
        enableSuggestions: false,
        autofillHints: [
          widget.newPassword
              ? AutofillHints.newPassword
              : AutofillHints.password,
        ],
        textInputAction: widget.onSubmitted == null
            ? TextInputAction.next
            : TextInputAction.done,
        onFieldSubmitted: (_) => widget.onSubmitted?.call(),
        validator: widget.validator,
        decoration: InputDecoration(
          hintText: widget.hint,
          helperText: widget.newPassword ? 'At least 8 characters' : null,
          suffixIcon: IconButton(
            tooltip: _hidden ? 'Show password' : 'Hide password',
            icon: Icon(
              _hidden
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              size: 20,
            ),
            onPressed: () => setState(() => _hidden = !_hidden),
          ),
        ),
      ),
    );
  }
}

class KonamiIdField extends StatelessWidget {
  const KonamiIdField({
    super.key,
    required this.controller,
    required this.validator,
    this.helper,
    this.enabled = true,
    this.autofill = true,
  });

  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final String? helper;
  final bool enabled;
  final bool autofill;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return LabeledField(
      label: 'Konami ID',
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        autocorrect: false,
        autofillHints: autofill ? const [AutofillHints.username] : null,
        textInputAction: TextInputAction.next,
        validator: validator,
        // A locked ID is still the answer, so keep it readable rather than
        // greyed out like a placeholder.
        style: enabled ? null : TextStyle(color: palette.subtleForeground),
        decoration: InputDecoration(
          hintText: 'ABCD-1234-EFGH',
          helperText: helper,
          fillColor: enabled ? null : palette.muted,
        ),
      ),
    );
  }
}
