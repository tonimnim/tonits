import 'package:flutter/material.dart';

import '../../core/theme.dart';
import 'auth_scope.dart';
import 'error_text.dart';
import 'validators.dart';
import 'widgets.dart';

/// Requests a reset code by email, then sets a new password with it. Only
/// accounts with a verified email can reset this way.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key, this.initialKonamiId = ''});

  final String initialKonamiId;

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _form = GlobalKey<FormState>();
  late final _konamiId = TextEditingController(text: widget.initialKonamiId);
  final _code = TextEditingController();
  final _password = TextEditingController();
  bool _codeSent = false;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _konamiId.dispose();
    _code.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _run(Future<void> Function() action) async {
    if (_busy || !_form.currentState!.validate()) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
    } catch (e) {
      if (mounted) setState(() => _error = authErrorText(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _requestCode() => _run(() async {
    await AuthScope.read(context).repository
        .requestPasswordReset(_konamiId.text.trim());
    if (mounted) setState(() => _codeSent = true);
  });

  Future<void> _confirm() => _run(() async {
    await AuthScope.read(context).repository.confirmPasswordReset(
      konamiId: _konamiId.text.trim(),
      code: _code.text.trim(),
      newPassword: _password.text,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password changed. Sign in with your new password.'),
      ),
    );
    Navigator.pop(context);
  });

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      eyebrow: 'Account recovery',
      title: 'Reset password',
      subtitle: _codeSent
          ? 'If this account has a verified email, we sent a 6-digit code to it.'
          : "We'll email a code to the address verified on your account.",
      children: [
        Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _konamiId,
                enabled: !_codeSent,
                autocorrect: false,
                validator: AuthValidators.konamiId,
                decoration: const InputDecoration(labelText: 'Konami ID'),
              ),
              if (_codeSent) ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _code,
                  keyboardType: TextInputType.number,
                  autofillHints: const [AutofillHints.oneTimeCode],
                  maxLength: 6,
                  validator: AuthValidators.resetCode,
                  decoration: const InputDecoration(labelText: 'Code'),
                ),
                const SizedBox(height: 8),
                PasswordField(
                  controller: _password,
                  label: 'New password',
                  newPassword: true,
                  validator: (v) =>
                      AuthValidators.newPassword(v, konamiId: _konamiId.text),
                  onSubmitted: _confirm,
                ),
              ],
              const SizedBox(height: 24),
              FormError(_error),
              SubmitButton(
                label: _codeSent ? 'Set new password' : 'Send code',
                busy: _busy,
                onPressed: _codeSent ? _confirm : _requestCode,
              ),
              const SizedBox(height: 16),
              const Text(
                "No verified email on your account? Contact Tonits support to get back in.",
                textAlign: TextAlign.center,
                style: TextStyle(color: TonitsColors.muted),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
