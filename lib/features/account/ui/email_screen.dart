import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/application/auth_providers.dart';
import '../../auth/ui/validators.dart';
import '../../auth/ui/widgets/form_error.dart';
import '../application/account_providers.dart';
import 'widgets/account_form_page.dart';

/// Adds or changes the account email in two steps: send a code to the new
/// address, then enter it. The address is only saved once verified.
class EmailScreen extends ConsumerStatefulWidget {
  const EmailScreen({super.key});

  @override
  ConsumerState<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends ConsumerState<EmailScreen> with BusyState {
  final _emailForm = GlobalKey<FormState>();
  final _codeForm = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _code = TextEditingController();

  /// The address a code was sent to; null while on the first step.
  String? _sentTo;

  /// How long the last code lasts, when the API says.
  Duration? _expiresIn;

  @override
  void dispose() {
    _email.dispose();
    _code.dispose();
    super.dispose();
  }

  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? _validateEmail(String? value, AppLocalizations l) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return l.accountEnterEmail;
    return _emailPattern.hasMatch(v) ? null : l.accountEmailInvalid;
  }

  Future<void> _send() async {
    if (!_emailForm.currentState!.validate()) return;
    final email = _email.text.trim();
    await run(() async {
      final expiresIn = await ref
          .read(accountServiceProvider)
          .requestEmailCode(email);
      if (mounted) {
        setState(() {
          _sentTo = email;
          _expiresIn = expiresIn;
        });
      }
    });
  }

  void _resend() => run(() async {
    final expiresIn = await ref
        .read(accountServiceProvider)
        .requestEmailCode(_sentTo!);
    if (!mounted) return;
    setState(() => _expiresIn = expiresIn);
    showMessage(context, context.l10n.accountNewCodeSent(_sentTo!));
  });

  Future<void> _verify() async {
    if (!_codeForm.currentState!.validate()) return;
    await run(() async {
      await ref.read(accountServiceProvider).verifyEmail(_code.text.trim());
      if (mounted) popWithMessage(context, context.l10n.accountEmailVerified);
    });
  }

  void _changeAddress() => setState(() {
    _sentTo = null;
    _code.clear();
    error = null;
  });

  @override
  Widget build(BuildContext context) {
    final current = ref.watch(currentPlayerProvider)?.email;
    final sentTo = _sentTo;
    final l = context.l10n;
    if (sentTo != null) return _codeStep(sentTo, l);
    return AccountFormPage(
      title: l.accountEmailTitle,
      intro: current == null
          ? l.accountEmailIntroAdd
          : l.accountEmailIntroChange(current),
      children: [
        Form(
          key: _emailForm,
          child: LabeledField(
            label: current == null
                ? l.accountEmailTitle
                : l.accountNewEmailLabel,
            child: TextFormField(
              controller: _email,
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              autofillHints: const [AutofillHints.email],
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _send(),
              validator: (v) => _validateEmail(v, l),
              decoration: const InputDecoration(hintText: 'you@example.com'),
            ),
          ),
        ),
        const SizedBox(height: TonitsSpace.lg),
        FormError(error),
        PrimaryButton(label: l.accountSendCode, busy: busy, onPressed: _send),
      ],
    );
  }

  static String _expiry(Duration? lasts, AppLocalizations l) {
    if (lasts == null) return l.accountCodeExpiresSoon;
    final minutes = (lasts.inSeconds / 60).ceil();
    return l.accountCodeExpiresIn(minutes);
  }

  Widget _codeStep(String sentTo, AppLocalizations l) {
    return AccountFormPage(
      title: l.accountCheckEmailTitle,
      intro: l.accountCodeSentIntro(sentTo, _expiry(_expiresIn, l)),
      children: [
        Form(
          key: _codeForm,
          child: LabeledField(
            label: l.accountCodeLabel,
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
              validator: (v) => AuthValidators.resetCode(v, l),
              style: monoFont.copyWith(fontSize: 20, letterSpacing: 6),
              decoration: const InputDecoration(hintText: '000000'),
            ),
          ),
        ),
        const SizedBox(height: TonitsSpace.lg),
        FormError(error),
        PrimaryButton(label: l.accountVerify, busy: busy, onPressed: _verify),
        const SizedBox(height: TonitsSpace.md),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: TonitsSpace.sm,
          children: [
            TextButton(
              onPressed: busy ? null : _resend,
              child: Text(l.accountSendNewCode),
            ),
            TextButton(
              onPressed: busy ? null : _changeAddress,
              child: Text(l.accountUseAnotherEmail),
            ),
          ],
        ),
      ],
    );
  }
}
