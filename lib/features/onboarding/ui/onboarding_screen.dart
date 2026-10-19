import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/error_text.dart';
import '../../../core/countries.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../account/application/legal_links.dart';
import '../../../core/phone_number.dart';
import '../../auth/data/models.dart';
import '../../auth/ui/validators.dart';
import '../../auth/ui/widgets/auth_fields.dart';
import 'widgets/onboarding_frame.dart';
import 'widgets/username_field.dart';
import '../../auth/application/auth_providers.dart';

/// After a first Google or Apple sign-in: the username, the Konami ID, the
/// country, then the phone, one step at a time, sent together at the end.
/// The country comes before the phone so the number starts with the right
/// calling code. The router keeps the player here until it's done.
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
  late Country? _country =
      Country.byCode(_player.countryCode) ??
      Country.byCode(
        WidgetsBinding.instance.platformDispatcher.locale.countryCode,
      );

  var _step = _Step.username;

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
    if (_step != _Step.phone) return _go(_Step.values[_step.index + 1]);
    await _finish();
  }

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
            phoneNumber: PhoneNumber.normalize(_phone.text, country)!,
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
        _step = step;
        error = _message(e);
      });
    } catch (e) {
      if (mounted) setState(() => error = describeError(e));
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  static String _message(ApiException e) => switch (e.code) {
    'konami_id_taken' =>
      'That Konami ID is linked to another Ozone account. Contact Ozone '
          "support if it's yours.",
    'phone_taken' =>
      'That number is linked to another Ozone account. Contact Ozone '
          "support if it's yours.",
    _ => describeError(e),
  };

  @override
  Widget build(BuildContext context) {
    final (title, subtitle, field) = switch (_step) {
      _Step.username => (
        'Pick your username',
        "It's how players see you in matches and on the ladder.",
        UsernameField(controller: _username, onSubmitted: _next),
      ),
      _Step.konamiId => (
        'Link eFootball',
        'Your Konami ID connects Ozone to your eFootball account. Enter it '
            'exactly as the game shows it.',
        KonamiIdField(
          controller: _konamiId,
          validator: AuthValidators.konamiId,
          autofill: false,
        ),
      ),
      _Step.country => (
        'Where do you play from?',
        'Your country decides your ladder and the competitions you can '
            'enter.',
        CountryField(
          initialValue: _country,
          validator: (c) => c == null ? 'Choose your country' : null,
          onChanged: (c) => setState(() => _country = c),
        ),
      ),
      _Step.phone => (
        'Your phone number',
        _country?.code == 'KE'
            ? 'Your M-Pesa number, for paying entry fees. Other players '
                  'never see it.'
            : 'For paying entry fees. Other players never see it.',
        _PhoneStep(
          controller: _phone,
          country: _country!,
          onCountry: (c) => setState(() => _country = c),
          onSubmitted: _next,
        ),
      ),
    };

    final last = _step == _Step.phone;
    return PopScope(
      canPop: _step == _Step.username,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _go(_Step.values[_step.index - 1]);
      },
      child: OnboardingFrame(
        step: _step.index,
        steps: _Step.values.length,
        title: title,
        subtitle: subtitle,
        onBack: _step == _Step.username
            ? null
            : () => _go(_Step.values[_step.index - 1]),
        trailing: _step == _Step.username
            ? TextButton(
                onPressed: () =>
                    ref.read(authControllerProvider.notifier).signOut(),
                child: const Text('Sign out'),
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
              label: last ? 'Finish' : 'Continue',
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
/// the code picks another country for the number.
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
    final kenya = country.code == 'KE';
    return LabeledField(
      label: kenya ? 'M-Pesa number' : 'Phone number',
      child: TextFormField(
        controller: controller,
        autofocus: true,
        keyboardType: TextInputType.phone,
        autofillHints: const [AutofillHints.telephoneNumberNational],
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (_) => onSubmitted(),
        validator: (value) => PhoneNumber.validate(value, country),
        decoration: InputDecoration(
          hintText: kenya ? '0712 345 678' : 'Phone number',
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
    TextSpan link(String label, LegalDocumentType type) => TextSpan(
      text: label,
      style: TextStyle(color: p.primary, fontWeight: FontWeight.w600),
      recognizer: TapGestureRecognizer()
        ..onTap = () => openLegalDocument(ref, type),
    );
    return Text.rich(
      TextSpan(
        style: TextStyle(fontSize: 13, height: 1.5, color: p.mutedForeground),
        children: [
          const TextSpan(text: 'By finishing you accept the '),
          link('Terms', LegalDocumentType.terms),
          const TextSpan(text: ' and the '),
          link('Privacy Notice', LegalDocumentType.privacy),
          const TextSpan(text: '.'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
