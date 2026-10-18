import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/error_text.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/application/auth_controller.dart';
import '../../../auth/ui/recovery_code_screen.dart';
import '../../../auth/ui/widgets/auth_fields.dart';

/// Issues a new recovery code: the player confirms their password, then
/// sees the code once on its own screen.
Future<void> startNewRecoveryCode(BuildContext context, WidgetRef ref) async {
  final hadCode =
      ref.read(authControllerProvider).player?.recoveryCodeSet ?? false;
  final code = await showDialog<String>(
    context: context,
    builder: (_) => const _ConfirmPasswordDialog(),
  );
  if (code == null || !context.mounted) return;
  await Navigator.of(context).push(
    MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => RecoveryCodeScreen(
        code: code,
        replacesOld: hadCode,
        onDone: () => Navigator.of(context).pop(),
      ),
    ),
  );
}

/// Asks for the password and returns the new code, or null when cancelled.
class _ConfirmPasswordDialog extends ConsumerStatefulWidget {
  const _ConfirmPasswordDialog();

  @override
  ConsumerState<_ConfirmPasswordDialog> createState() =>
      _ConfirmPasswordDialogState();
}

class _ConfirmPasswordDialogState
    extends ConsumerState<_ConfirmPasswordDialog> {
  final _password = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_busy) return;
    if (_password.text.isEmpty) {
      setState(() => _error = 'Enter your password');
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final code = await ref
          .read(authControllerProvider.notifier)
          .createRecoveryCode(password: _password.text);
      if (mounted) Navigator.of(context).pop(code);
    } catch (e) {
      if (mounted) setState(() => _error = _message(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// Here a wrong password isn't about the Konami ID, as it is at sign-in.
  static String _message(Object error) {
    final text = describeError(error);
    return text == "That Konami ID and password don't match."
        ? "That password isn't right."
        : text;
  }

  @override
  Widget build(BuildContext context) {
    final hadCode =
        ref.watch(authControllerProvider).player?.recoveryCodeSet ?? false;
    return AlertDialog(
      title: Text(
        hadCode ? 'Get a new recovery code' : 'Create a recovery code',
      ),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              hadCode
                  ? 'Your current code will stop working. Confirm your '
                        'password to continue.'
                  : 'Confirm your password to continue.',
              style: TextStyle(color: context.palette.subtleForeground),
            ),
            const SizedBox(height: TonitsSpace.md),
            PasswordField(controller: _password, onSubmitted: _submit),
            if (_error != null) ...[
              const SizedBox(height: TonitsSpace.md),
              Notice(_error!),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _busy ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _busy ? null : _submit,
          child: Text(_busy ? 'Checking…' : 'Continue'),
        ),
      ],
    );
  }
}
