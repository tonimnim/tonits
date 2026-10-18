import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/error_text.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/application/auth_controller.dart';
import '../../auth/ui/validators.dart';
import '../../auth/ui/widgets/auth_fields.dart';
import '../../auth/ui/widgets/form_error.dart';
import '../application/account_service.dart';
import 'widgets/account_form_page.dart';

/// Changes the password. This device stays signed in; every other device is
/// signed out.
class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _form = GlobalKey<FormState>();
  final _current = TextEditingController();
  final _new = TextEditingController();
  final _confirm = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _current.dispose();
    _new.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_busy || !_form.currentState!.validate()) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref
          .read(accountServiceProvider)
          .changePassword(
            currentPassword: _current.text,
            newPassword: _new.text,
          );
      if (mounted) {
        popWithMessage(
          context,
          'Password changed. Your other devices were signed out.',
        );
      }
    } catch (e) {
      if (mounted) setState(() => _error = _message(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// Here a wrong password isn't about the Konami ID, as it is at sign-in.
  static String _message(Object error) =>
      error is ApiException && error.code == 'invalid_credentials'
      ? "Your current password isn't right."
      : describeError(error);

  @override
  Widget build(BuildContext context) {
    final player = ref.watch(currentPlayerProvider);
    return AccountFormPage(
      title: 'Password',
      intro:
          "You'll stay signed in here. Every other device is signed out and "
          'needs the new password.',
      children: [
        AutofillGroup(
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PasswordField(
                  controller: _current,
                  label: 'Current password',
                  validator: AuthValidators.password,
                ),
                const SizedBox(height: TonitsSpace.md),
                PasswordField(
                  controller: _new,
                  label: 'New password',
                  hint: 'A new password',
                  newPassword: true,
                  validator: (value) {
                    final problem = AuthValidators.newPassword(
                      value,
                      username: player?.username,
                      konamiId: player?.konamiId,
                    );
                    if (problem != null) return problem;
                    return value == _current.text
                        ? 'Choose a different password'
                        : null;
                  },
                ),
                const SizedBox(height: TonitsSpace.md),
                PasswordField(
                  controller: _confirm,
                  label: 'Confirm new password',
                  hint: 'The new password again',
                  validator: (value) =>
                      value == _new.text ? null : "The passwords don't match",
                  onSubmitted: _save,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: TonitsSpace.lg),
        FormError(_error),
        PrimaryButton(label: 'Change password', busy: _busy, onPressed: _save),
      ],
    );
  }
}
