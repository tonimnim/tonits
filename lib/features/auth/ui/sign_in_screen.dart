import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes.dart';
import '../../../core/theme.dart';
import '../application/auth_controller.dart';
import '../../../core/api/error_text.dart';
import 'validators.dart';
import 'widgets/auth_fields.dart';
import 'widgets/auth_layout.dart';
import 'widgets/form_error.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _form = GlobalKey<FormState>();
  final _konamiId = TextEditingController();
  final _password = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _konamiId.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_busy || !_form.currentState!.validate()) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref
          .read(authControllerProvider.notifier)
          .signIn(konamiId: _konamiId.text.trim(), password: _password.text);
    } catch (e) {
      if (mounted) setState(() => _error = describeError(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Welcome back',
      subtitle: 'Sign in with the Konami ID you play eFootball with.',
      footer: AuthFooterLink(
        prompt: 'New to Tonits?',
        action: 'Create an account',
        onPressed: () => context.push(Routes.register),
      ),
      children: [
        Form(
          key: _form,
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                KonamiIdField(
                  controller: _konamiId,
                  validator: AuthValidators.konamiId,
                ),
                const SizedBox(height: TonitsSpace.md),
                PasswordField(
                  controller: _password,
                  validator: AuthValidators.password,
                  onSubmitted: _submit,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push(
                      Routes.forgotPassword,
                      extra: _konamiId.text.trim(),
                    ),
                    child: const Text('Forgot password?'),
                  ),
                ),
                const SizedBox(height: TonitsSpace.md),
                FormError(_error),
                SubmitButton(label: 'Sign in', busy: _busy, onPressed: _submit),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
