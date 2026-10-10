import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/countries.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../application/auth_controller.dart';
import '../data/models.dart';
import '../../../core/api/error_text.dart';
import 'validators.dart';
import 'widgets/auth_fields.dart';
import 'widgets/auth_layout.dart';
import 'widgets/form_error.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _konamiId = TextEditingController();
  final _password = TextEditingController();
  Country? _country = Country.byCode(
    WidgetsBinding.instance.platformDispatcher.locale.countryCode,
  );

  late Future<List<LegalDocument>> _legal;
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _legal = ref.read(authRepositoryProvider).currentLegalDocuments();
  }

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
    try {
      await ref
          .read(authControllerProvider.notifier)
          .register(
            username: _username.text.trim(),
            konamiId: _konamiId.text.trim(),
            password: _password.text,
            countryCode: _country!.code,
          );
    } catch (e) {
      if (mounted) {
        setState(() => _error = describeError(e));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Create your account',
      subtitle: 'Your Konami ID links your Tonits account to eFootball.',
      footer: AuthFooterLink(
        prompt: 'Already have an account?',
        action: 'Sign in',
        onPressed: () => context.pop(),
      ),
      children: [
        Form(
          key: _form,
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LabeledField(
                  label: 'Username',
                  child: TextFormField(
                    controller: _username,
                    autocorrect: false,
                    autofillHints: const [AutofillHints.newUsername],
                    textInputAction: TextInputAction.next,
                    validator: AuthValidators.username,
                    decoration: const InputDecoration(
                      hintText: 'striker.9',
                      helperText:
                          'Your public handle. Letters, numbers, _ and .',
                    ),
                  ),
                ),
                const SizedBox(height: TonitsSpace.md),
                KonamiIdField(
                  controller: _konamiId,
                  validator: AuthValidators.konamiId,
                  helper: 'As shown in eFootball. You sign in with it.',
                  autofill: false,
                ),
                const SizedBox(height: TonitsSpace.md),
                CountryField(
                  initialValue: _country,
                  onChanged: (c) => _country = c,
                  validator: (c) => c == null ? 'Choose your country' : null,
                ),
                const SizedBox(height: TonitsSpace.md),
                PasswordField(
                  controller: _password,
                  hint: 'Choose a password',
                  newPassword: true,
                  validator: (v) => AuthValidators.newPassword(
                    v,
                    username: _username.text,
                    konamiId: _konamiId.text,
                  ),
                ),
                const SizedBox(height: TonitsSpace.lg),
                FutureBuilder<List<LegalDocument>>(
                  future: _legal,
                  builder: (context, snapshot) {
                    final docs = snapshot.data;
                    if (snapshot.hasError) {
                      return _LegalUnavailable(
                        onRetry: () => setState(() {
                          _legal = ref
                              .read(authRepositoryProvider)
                              .currentLegalDocuments();
                        }),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (docs != null) _LegalNotice(docs),
                        const SizedBox(height: TonitsSpace.md),
                        FormError(_error),
                        // Registering records the terms as accepted, so they
                        // must be on screen first.
                        SubmitButton(
                          label: 'Create account',
                          busy: _busy || docs == null,
                          onPressed: _submit,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LegalNotice extends ConsumerWidget {
  const _LegalNotice(this.documents);

  final List<LegalDocument> documents;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.read(authRepositoryProvider);
    final palette = context.palette;
    TextSpan link(LegalDocumentType type, String label) {
      final doc = documents.where((d) => d.type == type).firstOrNull;
      return TextSpan(
        text: label,
        style: TextStyle(color: palette.primary, fontWeight: FontWeight.w600),
        recognizer: doc == null
            ? null
            : (TapGestureRecognizer()
                ..onTap = () => launchUrl(repository.resolve(doc.contentUrl))),
      );
    }

    return Text.rich(
      TextSpan(
        style: TextStyle(
          color: palette.subtleForeground,
          fontSize: 13,
          height: 1.5,
        ),
        children: [
          const TextSpan(text: 'By creating an account you accept the '),
          link(LegalDocumentType.terms, 'Terms'),
          const TextSpan(text: ' and the '),
          link(LegalDocumentType.privacy, 'Privacy Notice'),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}

class _LegalUnavailable extends StatelessWidget {
  const _LegalUnavailable({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const FormError(
          "Couldn't load the Terms and Privacy Notice. You need them to create an account.",
        ),
        SecondaryButton(label: 'Try again', onPressed: onRetry),
      ],
    );
  }
}
