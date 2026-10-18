import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/error_text.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../application/auth_controller.dart';
import 'validators.dart';
import 'widgets/auth_fields.dart';
import 'widgets/auth_layout.dart';
import 'widgets/form_error.dart';
import 'widgets/recovery_code_formatter.dart';

enum _Method { recoveryCode, email }

/// Resets a forgotten password, with the recovery code saved at sign-up or
/// with a code sent to a verified email.
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
  final _recoveryCode = TextEditingController();
  final _emailCode = TextEditingController();
  final _password = TextEditingController();
  var _method = _Method.recoveryCode;
  bool _emailCodeSent = false;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _konamiId.dispose();
    _recoveryCode.dispose();
    _emailCode.dispose();
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

  /// Signs the player in; the router then shows the code that replaces the
  /// spent one.
  Future<void> _resetWithRecoveryCode() => _run(
    () => ref
        .read(authControllerProvider.notifier)
        .resetWithRecoveryCode(
          konamiId: _konamiId.text.trim(),
          recoveryCode: _recoveryCode.text,
          newPassword: _password.text,
        ),
  );

  Future<void> _requestEmailCode() => _run(() async {
    await ref
        .read(authRepositoryProvider)
        .requestPasswordReset(_konamiId.text.trim());
    if (mounted) setState(() => _emailCodeSent = true);
  });

  Future<void> _confirmEmailCode() => _run(() async {
    await ref
        .read(authRepositoryProvider)
        .confirmPasswordReset(
          konamiId: _konamiId.text.trim(),
          code: _emailCode.text.trim(),
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

  void _switchTo(_Method method) => setState(() {
    _method = method;
    _error = null;
    _form.currentState?.reset();
  });

  @override
  Widget build(BuildContext context) {
    final byCode = _method == _Method.recoveryCode;
    final VoidCallback submit = byCode
        ? _resetWithRecoveryCode
        : _emailCodeSent
        ? _confirmEmailCode
        : _requestEmailCode;

    return AuthLayout(
      title: 'Reset password',
      subtitle: switch ((_method, _emailCodeSent)) {
        (_Method.recoveryCode, _) =>
          'Use the recovery code you saved when you signed up.',
        (_Method.email, false) =>
          "We'll email a code to the address verified on your account.",
        (_Method.email, true) =>
          'If this account has a verified email, we sent it a code. Enter '
              'the 6 digits below.',
      },
      footer: Text(
        'No recovery code or verified email? Contact Tonits support to get '
        'back in.',
        textAlign: TextAlign.center,
        style: TextStyle(color: context.palette.subtleForeground, fontSize: 13),
      ),
      children: [
        SegmentedTabs(
          options: const {
            _Method.recoveryCode: 'Recovery code',
            _Method.email: 'Email',
          },
          selected: _method,
          onChanged: _busy ? (_) {} : _switchTo,
        ),
        const SizedBox(height: TonitsSpace.lg),
        Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              KonamiIdField(
                controller: _konamiId,
                enabled: byCode || !_emailCodeSent,
                validator: AuthValidators.konamiId,
              ),
              if (byCode) ...[
                const SizedBox(height: TonitsSpace.md),
                LabeledField(
                  label: 'Recovery code',
                  child: TextFormField(
                    controller: _recoveryCode,
                    autocorrect: false,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: const [RecoveryCodeFormatter()],
                    validator: AuthValidators.recoveryCode,
                    style: monoFont.copyWith(fontSize: 16, letterSpacing: 0.5),
                    decoration: const InputDecoration(
                      hintText: 'XXXX-XXXX-XXXX-XXXX-XXXX',
                    ),
                  ),
                ),
              ],
              if (!byCode && _emailCodeSent) ...[
                const SizedBox(height: TonitsSpace.md),
                LabeledField(
                  label: 'Code',
                  child: TextFormField(
                    controller: _emailCode,
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
              ],
              if (byCode || _emailCodeSent) ...[
                const SizedBox(height: TonitsSpace.md),
                PasswordField(
                  controller: _password,
                  label: 'New password',
                  hint: 'Choose a new password',
                  newPassword: true,
                  validator: (v) =>
                      AuthValidators.newPassword(v, konamiId: _konamiId.text),
                  onSubmitted: submit,
                ),
              ],
              const SizedBox(height: TonitsSpace.lg),
              FormError(_error),
              SubmitButton(
                label: byCode || _emailCodeSent
                    ? 'Set new password'
                    : 'Send code',
                busy: _busy,
                onPressed: submit,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
