import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/error_text.dart';
import '../../../core/countries.dart';
import '../../../core/country_lookup.dart';
import '../../../core/l10n.dart';
import '../../../core/phone_number.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../account/application/legal_links.dart';
import '../../auth/application/auth_providers.dart';
import '../../auth/data/models.dart';
import '../../auth/ui/validators.dart';
import '../../auth/ui/widgets/auth_fields.dart';
import 'widgets/onboarding_frame.dart';
import 'widgets/username_field.dart';

/// After a first Google or Apple sign-in: the username, the Konami ID, then
/// the phone, one step at a time, sent together at the end. The country
/// isn't asked: it comes from the player's IP address, looked up while they
/// type, and the phone starts with its calling code. Only if the lookup
/// can't tell is the country asked, before the phone. The router keeps the
/// player here until it's done.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

enum _Step { username, konamiId, country, phone }

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with BusyState {
  final _forms = {for (final s in _Step.values) s: GlobalKey<FormState>()};
  late final Player _player = ref.read(currentPlayerProvider)!;
  late final _username = TextEditingController(text: _player.username ?? '');
  final _konamiId = TextEditingController();
  final _phone = TextEditingController();

  /// Where the player is: from their account if it's set, else their IP.
  late Country? _country = Country.byCode(_player.countryCode);

  /// The phone number's own country, when the player picks another calling
  /// code. It doesn't change [_country].
  Country? _phoneCountry;

  /// Asked only when the IP couldn't tell, or the server refused it.
  var _askCountry = false;

  var _step = _Step.username;

  List<_Step> get _steps => [
    _Step.username,
    _Step.konamiId,
    if (_askCountry) _Step.country,
    _Step.phone,
  ];

  @override
  void initState() {
    super.initState();
    // Looked up while the first steps are filled in.
    if (_country == null) {
      unawaited(
        ref.read(countryLookupProvider.future).then((code) {
          if (mounted && _country == null) {
            setState(() => _country = Country.byCode(code));
          }
        }),
      );
    }
  }

  @override
  void dispose() {
    _username.dispose();
    _konamiId.dispose();
    _phone.dispose();
    super.dispose();
  }

  void _go(_Step step) => setState(() {
    _step = step;
    error = null;
  });

  Future<void> _next() async {
    if (busy || !_forms[_step]!.currentState!.validate()) return;
    if (_step == _Step.phone) return _finish();
    if (_step == _Step.konamiId && _country == null && !_askCountry) {
      // Still looking: wait for it, briefly, before the phone.
      setState(() => busy = true);
      final code = await ref.read(countryLookupProvider.future);
      if (!mounted) return;
      setState(() {
        busy = false;
        _country ??= Country.byCode(code);
        _askCountry = _country == null;
      });
    }
    _go(_steps[_steps.indexOf(_step) + 1]);
  }

  void _back() => _go(_steps[_steps.indexOf(_step) - 1]);

  Future<void> _finish() async {
    final country = _country!;
    setState(() {
      busy = true;
      error = null;
    });
    final username = _username.text.trim();
    try {
      await ref
          .read(authControllerProvider.notifier)
          .completeOnboarding(
            // Only a changed username is sent; the generated one stays.
            username: username == _player.username ? null : username,
            konamiId: _konamiId.text.trim(),
            phoneNumber: PhoneNumber.normalize(
              _phone.text,
              _phoneCountry ?? country,
            )!,
            countryCode: country.code,
          );
    } on ApiException catch (e) {
      if (!mounted) return;
      if (e.code == 'already_onboarded') {
        // Finished elsewhere; resuming the session lets the player in.
        await ref.read(authControllerProvider.notifier).restore();
        return;
      }
      // Back to the step the problem is in.
      final step = switch (e.code) {
        'username_taken' || 'invalid_username' => _Step.username,
        'konami_id_taken' || 'invalid_konami_id' => _Step.konamiId,
        'invalid_country' => _Step.country,
        _ => _Step.phone,
      };
      setState(() {
        if (step == _Step.country) _askCountry = true;
        _step = step;
        error = _message(e, context.l10n);
      });
    } catch (e) {
      if (mounted) setState(() => error = describeError(e, context.l10n));
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  static String _message(ApiException e, AppLocalizations l) =>
      switch (e.code) {
        'konami_id_taken' => l.errorKonamiIdTaken,
        'phone_taken' => l.errorPhoneTaken,
        _ => describeError(e, l),
      };

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final (title, subtitle, field) = switch (_step) {
      _Step.username => (
        l.onboardingUsernameTitle,
        l.onboardingUsernameSubtitle,
        UsernameField(controller: _username, onSubmitted: _next),
      ),
      _Step.konamiId => (
        l.onboardingKonamiIdTitle,
        l.onboardingKonamiIdSubtitle,
        KonamiIdField(
          controller: _konamiId,
          validator: (v) => AuthValidators.konamiId(v, l),
          autofill: false,
        ),
      ),
      _Step.country => (
        l.onboardingCountryTitle,
        l.onboardingCountrySubtitle,
        CountryField(
          initialValue: _country,
          validator: (c) => c == null ? l.chooseYourCountry : null,
          onChanged: (c) => setState(() => _country = c),
        ),
      ),
      _Step.phone => (
        l.onboardingPhoneTitle,
        (_phoneCountry ?? _country)?.code == 'KE'
            ? l.onboardingPhoneSubtitleMpesa
            : l.onboardingPhoneSubtitle,
        _PhoneStep(
          controller: _phone,
          country: _phoneCountry ?? _country!,
          onCountry: (c) => setState(() => _phoneCountry = c),
          onSubmitted: _next,
        ),
      ),
    };

    final last = _step == _Step.phone;
    return PopScope(
      canPop: _step == _Step.username,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _back();
      },
      child: OnboardingFrame(
        step: _steps.indexOf(_step),
        steps: _steps.length,
        title: title,
        subtitle: subtitle,
        onBack: _step == _Step.username ? null : _back,
        trailing: _step == _Step.username
            ? TextButton(
                onPressed: () =>
                    ref.read(authControllerProvider.notifier).signOut(),
                child: Text(l.profileSignOut),
              )
            : null,
        action: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (error != null) ...[
              Notice(error!),
              const SizedBox(height: TonitsSpace.md),
            ],
            PrimaryButton(
              label: last ? l.onboardingFinish : l.onboardingContinue,
              busy: busy,
              onPressed: _next,
            ),
            if (last) ...[const SizedBox(height: 12), const _Acceptance()],
          ],
        ),
        child: KeyedSubtree(
          key: ValueKey(_step),
          child: Form(key: _forms[_step], child: field),
        ),
      ),
    );
  }
}

/// The phone number, with the country's calling code in front; tapping
/// the code picks another calling code for a number from elsewhere. It
/// doesn't change where the player is.
class _PhoneStep extends StatelessWidget {
  const _PhoneStep({
    required this.controller,
    required this.country,
    required this.onCountry,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final Country country;
  final ValueChanged<Country> onCountry;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final kenya = country.code == 'KE';
    return LabeledField(
      label: kenya ? l.accountMpesaNumberLabel : l.accountPhoneNumberLabel,
      child: TextFormField(
        controller: controller,
        autofocus: true,
        keyboardType: TextInputType.phone,
        autofillHints: const [AutofillHints.telephoneNumberNational],
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (_) => onSubmitted(),
        validator: (value) => PhoneNumber.validate(value, country, l),
        decoration: InputDecoration(
          hintText: kenya ? '0712 345 678' : l.accountPhoneNumberLabel,
          prefixIcon: CallingCodePrefix(
            country: country,
            onTap: () async {
              final picked = await showCountryPicker(context);
              if (picked != null) onCountry(picked);
            },
          ),
        ),
      ),
    );
  }
}

/// Finishing accepts the current Terms and Privacy Notice.
class _Acceptance extends ConsumerWidget {
  const _Acceptance();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final l = context.l10n;
    TextSpan link(String label, LegalDocumentType type) => TextSpan(
      text: label,
      style: TextStyle(
        color: p.foreground,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.underline,
      ),
      recognizer: TapGestureRecognizer()
        ..onTap = () => openLegalDocument(ref, type),
    );
    return Text.rich(
      TextSpan(
        style: TextStyle(fontSize: 13, height: 1.5, color: p.mutedForeground),
        children: [
          TextSpan(text: l.onboardingAcceptBefore),
          link(l.accountLegalTerms, LegalDocumentType.terms),
          TextSpan(text: l.onboardingAcceptBetween),
          link(l.accountLegalPrivacy, LegalDocumentType.privacy),
          TextSpan(text: l.onboardingAcceptAfter),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
