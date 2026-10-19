import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/countries.dart';
import '../../../core/l10n.dart';
import '../../../core/phone_number.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/application/auth_providers.dart';
import '../../auth/ui/widgets/form_error.dart';
import '../application/account_providers.dart';
import 'widgets/account_form_page.dart';

/// Adds, changes or removes the phone number used for payments.
class PhoneScreen extends ConsumerStatefulWidget {
  const PhoneScreen({super.key});

  @override
  ConsumerState<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends ConsumerState<PhoneScreen> with BusyState {
  final _form = GlobalKey<FormState>();
  late final String? _saved = ref.read(currentPlayerProvider)?.phoneNumber;

  /// Whose calling code the number uses; starts as the account's country.
  late Country _country = _savedCountry ?? _accountCountry;
  late final _phone = TextEditingController(
    text: _saved == null ? '' : PhoneNumber.local(_saved, _country),
  );

  Country get _accountCountry =>
      Country.byCode(ref.read(currentPlayerProvider)?.countryCode) ??
      Country.byCode('KE')!;

  /// The country whose calling code starts the saved number, longest match
  /// first, preferring the account's own country for shared codes like +1.
  Country? get _savedCountry {
    final saved = _saved;
    if (saved == null) return null;
    if (saved.startsWith('+${_accountCountry.dialCode}')) {
      return _accountCountry;
    }
    final matches =
        Country.all.where((c) => saved.startsWith('+${c.dialCode}')).toList()
          ..sort((a, b) => b.dialCode.length.compareTo(a.dialCode.length));
    return matches.firstOrNull;
  }

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    final number = PhoneNumber.normalize(_phone.text, _country)!;
    if (number == _saved) {
      Navigator.of(context).pop();
      return;
    }
    await run(() async {
      await ref.read(accountServiceProvider).savePhone(number);
      if (mounted) popWithMessage(context, context.l10n.accountPhoneSaved);
    });
  }

  Future<void> _remove() async {
    final l = context.l10n;
    final confirmed = await confirmAction(
      context,
      title: l.accountRemovePhoneTitle,
      message: l.accountRemovePhoneMessage,
      confirmLabel: l.accountRemove,
    );
    if (!confirmed || !mounted) return;
    await run(() async {
      await ref.read(accountServiceProvider).removePhone();
      if (mounted) popWithMessage(context, context.l10n.accountPhoneRemoved);
    });
  }

  Future<void> _pickCountry() async {
    final picked = await showCountryPicker(context);
    if (picked != null) setState(() => _country = picked);
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final kenya = _country.code == 'KE';
    return AccountFormPage(
      title: l.accountPhoneNumberLabel,
      intro: kenya ? l.accountPhoneIntroMpesa : l.accountPhoneIntro,
      children: [
        Form(
          key: _form,
          child: LabeledField(
            label: kenya
                ? l.accountMpesaNumberLabel
                : l.accountPhoneNumberLabel,
            child: TextFormField(
              controller: _phone,
              autofocus: _saved == null,
              keyboardType: TextInputType.phone,
              autofillHints: const [AutofillHints.telephoneNumberNational],
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _save(),
              validator: (value) => PhoneNumber.validate(value, _country, l),
              decoration: InputDecoration(
                hintText: kenya ? '0712 345 678' : l.accountPhoneNumberLabel,
                prefixIcon: CallingCodePrefix(
                  country: _country,
                  onTap: busy ? null : _pickCountry,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: TonitsSpace.lg),
        FormError(error),
        PrimaryButton(label: l.accountSave, busy: busy, onPressed: _save),
        if (_saved != null) ...[
          const SizedBox(height: TonitsSpace.md),
          Center(
            child: TextButton(
              onPressed: busy ? null : _remove,
              style: TextButton.styleFrom(foregroundColor: p.destructive),
              child: Text(l.accountRemovePhone),
            ),
          ),
        ],
      ],
    );
  }
}
