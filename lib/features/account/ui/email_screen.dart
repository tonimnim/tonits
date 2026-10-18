import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/error_text.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/application/auth_controller.dart';
import '../../auth/ui/validators.dart';
import '../../auth/ui/widgets/form_error.dart';
import '../application/account_service.dart';
import 'widgets/account_form_page.dart';

/// Adds or changes the account email in two steps: send a code to the new
/// address, then enter it. The address is only saved once verified.
class EmailScreen extends ConsumerStatefulWidget {
  const EmailScreen({super.key});

  @override
  ConsumerState<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends ConsumerState<EmailScreen> {
  final _emailForm = GlobalKey<FormState>();
  final _codeForm = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _code = TextEditingController();

  /// The address a code was sent to; null while on the first step.
  String? _sentTo;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _code.dispose();
    super.dispose();
  }

  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? _validateEmail(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Enter your email';
    return _emailPattern.hasMatch(v) ? null : 'Enter a valid email address';
  }

  Future<void> _run(Future<void> Function() action) async {
    if (_busy) return;
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

  void _send() {
    if (!_emailForm.currentState!.validate()) return;
    final email = _email.text.trim();
    _run(() async {
      await ref.read(accountServiceProvider).requestEmailCode(email);
      if (mounted) setState(() => _sentTo = email);
    });
  }

  void _resend() => _run(() async {
    await ref.read(accountServiceProvider).requestEmailCode(_sentTo!);
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('New code sent to $_sentTo')));
  });

  void _verify() {
    if (!_codeForm.currentState!.validate()) return;
    _run(() async {
      await ref.read(accountServiceProvider).verifyEmail(_code.text.trim());
      if (mounted) popWithMessage(context, 'Email verified');
    });
  }

  void _changeAddress() => setState(() {
    _sentTo = null;
    _code.clear();
    _error = null;
  });

  @override
  Widget build(BuildContext context) {
    final current = ref.watch(currentPlayerProvider)?.email;
    final sentTo = _sentTo;
    if (sentTo != null) return _codeStep(sentTo);
    return AccountFormPage(
      title: 'Email',
      intro: current == null
          ? "With a verified email you can reset a forgotten password. We'll "
                'send a code to confirm it.'
          : 'Your email is $current. Enter a new address and it replaces '
                'this one once confirmed.',
      children: [
        Form(
          key: _emailForm,
          child: LabeledField(
            label: current == null ? 'Email' : 'New email',
            child: TextFormField(
              controller: _email,
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              autofillHints: const [AutofillHints.email],
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _send(),
              validator: _validateEmail,
              decoration: const InputDecoration(hintText: 'you@example.com'),
            ),
          ),
        ),
        const SizedBox(height: TonitsSpace.lg),
        FormError(_error),
        PrimaryButton(label: 'Send code', busy: _busy, onPressed: _send),
      ],
    );
  }

  Widget _codeStep(String sentTo) {
    return AccountFormPage(
      title: 'Check your email',
      intro: 'We sent a 6-digit code to $sentTo. It expires soon.',
      children: [
        Form(
          key: _codeForm,
          child: LabeledField(
            label: 'Code',
            child: TextFormField(
              controller: _code,
              autofocus: true,
              keyboardType: TextInputType.number,
              autofillHints: const [AutofillHints.oneTimeCode],
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _verify(),
              validator: AuthValidators.resetCode,
              style: monoFont.copyWith(fontSize: 20, letterSpacing: 6),
              decoration: const InputDecoration(hintText: '000000'),
            ),
          ),
        ),
        const SizedBox(height: TonitsSpace.lg),
        FormError(_error),
        PrimaryButton(label: 'Verify', busy: _busy, onPressed: _verify),
        const SizedBox(height: TonitsSpace.md),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: TonitsSpace.sm,
          children: [
            TextButton(
              onPressed: _busy ? null : _resend,
              child: const Text('Send a new code'),
            ),
            TextButton(
              onPressed: _busy ? null : _changeAddress,
              child: const Text('Use another email'),
            ),
          ],
        ),
      ],
    );
  }
}
