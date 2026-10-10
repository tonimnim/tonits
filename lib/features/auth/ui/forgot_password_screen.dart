import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../application/auth_controller.dart';
import '../../../core/api/error_text.dart';
import 'validators.dart';
import 'widgets/auth_fields.dart';
import 'widgets/auth_layout.dart';
import 'widgets/form_error.dart';

/// Requests a reset code by email, then sets a new password with it. Only
/// accounts with a verified email can reset this way.
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key, this.initialKonamiId = ''});

  final String initialKonamiId;

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
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
      if (mounted) setState(() => _error = describeError(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _requestCode() => _run(() async {
    await ref
        .read(authRepositoryProvider)
        .requestPasswordReset(_konamiId.text.trim());
    if (mounted) setState(() => _codeSent = true);
  });

  Future<void> _confirm() => _run(() async {
    await ref
        .read(authRepositoryProvider)
        .confirmPasswordReset(
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
    context.pop();
  });

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Reset password',
      subtitle: _codeSent
          ? 'If this account has a verified email, we sent it a code. Enter the 6 digits below.'
          : "We'll email a code to the address verified on your account.",
      footer: Text(
        'No verified email? Contact Tonits support to get back in.',
        textAlign: TextAlign.center,
        style: TextStyle(color: context.palette.subtleForeground, fontSize: 13),
      ),
      children: [
        Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              KonamiIdField(
                controller: _konamiId,
                enabled: !_codeSent,
                validator: AuthValidators.konamiId,
              ),
              if (_codeSent) ...[
                const SizedBox(height: TonitsSpace.md),
                LabeledField(
                  label: 'Code',
                  child: TextFormField(
                    controller: _code,
                    keyboardType: TextInputType.number,
                    autofillHints: const [AutofillHints.oneTimeCode],
                    maxLength: 6,
                    validator: AuthValidators.resetCode,
                    style: monoFont.copyWith(fontSize: 18, letterSpacing: 6),
                    decoration: const InputDecoration(
                      hintText: '000000',
                      counterText: '',
                    ),
                  ),
                ),
                const SizedBox(height: TonitsSpace.md),
                PasswordField(
                  controller: _password,
                  label: 'New password',
                  hint: 'Choose a new password',
                  newPassword: true,
                  validator: (v) =>
                      AuthValidators.newPassword(v, konamiId: _konamiId.text),
                  onSubmitted: _confirm,
                ),
              ],
              const SizedBox(height: TonitsSpace.lg),
              FormError(_error),
              SubmitButton(
                label: _codeSent ? 'Set new password' : 'Send code',
                busy: _busy,
                onPressed: _codeSent ? _confirm : _requestCode,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
