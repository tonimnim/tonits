import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/error_text.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../application/auth_controller.dart';
import 'validators.dart';
import 'widgets/auth_fields.dart';
import 'widgets/auth_layout.dart';
import 'widgets/form_error.dart';

/// Debug builds only: a Konami ID and password account on a local API,
/// for testing before Google and Apple are set up. Production refuses it.
class DevSignInScreen extends ConsumerStatefulWidget {
  const DevSignInScreen({super.key});

  @override
  ConsumerState<DevSignInScreen> createState() => _DevSignInScreenState();
}

class _DevSignInScreenState extends ConsumerState<DevSignInScreen> {
  final _form = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _konamiId = TextEditingController();
  final _password = TextEditingController();
  bool _create = false;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _username.dispose();
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
    final auth = ref.read(authControllerProvider.notifier);
    try {
      if (_create) {
        await auth.devRegister(
          username: _username.text.trim(),
          konamiId: _konamiId.text.trim(),
          password: _password.text,
        );
      } else {
        await auth.devSignIn(
          konamiId: _konamiId.text.trim(),
          password: _password.text,
        );
      }
    } catch (e) {
      if (mounted) setState(() => _error = describeError(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Developer sign-in',
      subtitle:
          'Test accounts on a local API. Players sign in with Google or '
          'Apple; this screen is not in release builds.',
      children: [
        SegmentedTabs(
          options: const {false: 'Sign in', true: 'Create'},
          selected: _create,
          onChanged: (v) => setState(() => _create = v),
        ),
        const SizedBox(height: TonitsSpace.lg),
        Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_create) ...[
                LabeledField(
                  label: 'Username',
                  child: TextFormField(
                    controller: _username,
                    autocorrect: false,
                    validator: AuthValidators.username,
                    decoration: const InputDecoration(hintText: 'striker.9'),
                  ),
                ),
                const SizedBox(height: TonitsSpace.md),
              ],
              KonamiIdField(
                controller: _konamiId,
                validator: AuthValidators.konamiId,
              ),
              const SizedBox(height: TonitsSpace.md),
              PasswordField(
                controller: _password,
                validator: _create
                    ? AuthValidators.newPassword
                    : AuthValidators.password,
                newPassword: _create,
                onSubmitted: _submit,
              ),
              const SizedBox(height: TonitsSpace.lg),
              FormError(_error),
              PrimaryButton(
                label: _create ? 'Create test account' : 'Sign in',
                busy: _busy,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
