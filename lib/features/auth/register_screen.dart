import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/api/api_client.dart';
import '../../core/countries.dart';
import '../../core/theme.dart';
import '../../core/widgets/country_field.dart';
import 'auth_scope.dart';
import 'error_text.dart';
import 'models.dart';
import 'validators.dart';
import 'widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
  bool _konamiIdTaken = false;

  @override
  void initState() {
    super.initState();
    _legal = AuthScope.read(context).repository.currentLegalDocuments();
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
      _konamiIdTaken = false;
    });
    try {
      await AuthScope.read(context).register(
        username: _username.text.trim(),
        konamiId: _konamiId.text.trim(),
        password: _password.text,
        countryCode: _country!.code,
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = authErrorText(e);
          _konamiIdTaken = e is ApiException && e.code == 'konami_id_taken';
        });
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      eyebrow: 'Your game. Your name.',
      title: 'Join Tonits',
      subtitle: 'Your Konami ID links your Tonits account to eFootball.',
      children: [
        Form(
          key: _form,
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _username,
                  autocorrect: false,
                  autofillHints: const [AutofillHints.newUsername],
                  textInputAction: TextInputAction.next,
                  validator: AuthValidators.username,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    helperText: 'Your public handle. Letters, numbers, _ and .',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _konamiId,
                  autocorrect: false,
                  textInputAction: TextInputAction.next,
                  validator: AuthValidators.konamiId,
                  decoration: const InputDecoration(
                    labelText: 'Konami ID',
                    helperText: 'As shown in eFootball. You sign in with it.',
                  ),
                ),
                const SizedBox(height: 16),
                CountryField(
                  initialValue: _country,
                  onChanged: (c) => _country = c,
                  validator: (c) => c == null ? 'Choose your country' : null,
                ),
                const SizedBox(height: 16),
                PasswordField(
                  controller: _password,
                  newPassword: true,
                  validator: (v) => AuthValidators.newPassword(
                    v,
                    username: _username.text,
                    konamiId: _konamiId.text,
                  ),
                ),
                const SizedBox(height: 24),
                FutureBuilder<List<LegalDocument>>(
                  future: _legal,
                  builder: (context, snapshot) {
                    final docs = snapshot.data;
                    if (snapshot.hasError) {
                      return _LegalUnavailable(
                        onRetry: () => setState(() {
                          _legal = AuthScope.read(context).repository
                              .currentLegalDocuments();
                        }),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (docs != null) _LegalNotice(docs),
                        const SizedBox(height: 16),
                        FormError(_error),
                        if (_konamiIdTaken)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Sign in instead'),
                            ),
                          ),
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

class _LegalNotice extends StatelessWidget {
  const _LegalNotice(this.documents);

  final List<LegalDocument> documents;

  @override
  Widget build(BuildContext context) {
    final repository = AuthScope.read(context).repository;
    TextSpan link(LegalDocumentType type, String label) {
      final doc = documents.where((d) => d.type == type).firstOrNull;
      return TextSpan(
        text: label,
        style: const TextStyle(
          color: TonitsColors.acid,
          decoration: TextDecoration.underline,
          decorationColor: TonitsColors.acid,
        ),
        recognizer: doc == null
            ? null
            : (TapGestureRecognizer()
                ..onTap = () => launchUrl(repository.resolve(doc.contentUrl))),
      );
    }

    return Text.rich(
      TextSpan(
        style: const TextStyle(color: TonitsColors.muted, height: 1.4),
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
        OutlinedButton(onPressed: onRetry, child: const Text('Try again')),
      ],
    );
  }
}
