import 'package:flutter/material.dart';

import '../../core/theme.dart';

/// Shared layout for the signed-out screens: a poster-style headline over a
/// scrollable form.
class AuthLayout extends StatelessWidget {
  const AuthLayout({
    super.key,
    this.eyebrow,
    required this.title,
    this.subtitle,
    required this.children,
  });

  /// A short mono label above the headline.
  final String? eyebrow;
  final String title;
  final String? subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: Navigator.canPop(context) ? AppBar() : null,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              TonitsSpace.lg,
              TonitsSpace.lg,
              TonitsSpace.lg,
              TonitsSpace.xl,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (eyebrow != null) ...[
                    Text(eyebrow!.toUpperCase(), style: text.labelSmall),
                    const SizedBox(height: TonitsSpace.md),
                  ],
                  Text(
                    title.toUpperCase(),
                    style: text.displaySmall?.copyWith(
                      color: TonitsColors.paper,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: TonitsSpace.md),
                    Text(
                      subtitle!,
                      style: text.bodyLarge?.copyWith(
                        color: TonitsColors.muted,
                      ),
                    ),
                  ],
                  const SizedBox(height: TonitsSpace.xl),
                  ...children,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    this.label = 'Password',
    this.validator,
    this.newPassword = false,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String label;
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
    return TextFormField(
      controller: widget.controller,
      obscureText: _hidden,
      autocorrect: false,
      enableSuggestions: false,
      autofillHints: [
        widget.newPassword ? AutofillHints.newPassword : AutofillHints.password,
      ],
      textInputAction: widget.onSubmitted == null
          ? TextInputAction.next
          : TextInputAction.done,
      onFieldSubmitted: (_) => widget.onSubmitted?.call(),
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        helperText: widget.newPassword ? 'At least 8 characters' : null,
        suffixIcon: IconButton(
          tooltip: _hidden ? 'Show password' : 'Hide password',
          icon: Icon(_hidden ? Icons.visibility : Icons.visibility_off),
          onPressed: () => setState(() => _hidden = !_hidden),
        ),
      ),
    );
  }
}

/// A full-width primary button that shows a spinner while [busy].
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
    return FilledButton(
      onPressed: busy ? null : onPressed,
      child: busy
          ? const SizedBox.square(
              dimension: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: TonitsColors.paper,
              ),
            )
          : Text(label.toUpperCase()),
    );
  }
}

/// An inline error message above a form's submit button.
class FormError extends StatelessWidget {
  const FormError(this.message, {super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    if (message == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Semantics(
        liveRegion: true,
        child: Text(
          message!,
          style: const TextStyle(
            color: TonitsColors.orange,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
