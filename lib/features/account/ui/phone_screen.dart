import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/countries.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/application/auth_controller.dart';
import '../../auth/ui/widgets/form_error.dart';
import '../application/account_service.dart';
import 'phone_number.dart';
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

  void _save() {
    if (!_form.currentState!.validate()) return;
    final number = PhoneNumber.normalize(_phone.text, _country)!;
    if (number == _saved) {
      Navigator.of(context).pop();
      return;
    }
    run(() async {
      await ref.read(accountServiceProvider).savePhone(number);
      if (mounted) popWithMessage(context, 'Phone number saved');
    });
  }

  Future<void> _remove() async {
    final confirmed = await confirmAction(
      context,
      title: 'Remove your phone number?',
      message: "You'll enter a number each time you pay an entry fee.",
      confirmLabel: 'Remove',
    );
    if (!confirmed || !mounted) return;
    await run(() async {
      await ref.read(accountServiceProvider).removePhone();
      if (mounted) popWithMessage(context, 'Phone number removed');
    });
  }

  Future<void> _pickCountry() async {
    final picked = await showCountryPicker(context);
    if (picked != null) setState(() => _country = picked);
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final kenya = _country.code == 'KE';
    return AccountFormPage(
      title: 'Phone number',
      intro: kenya
          ? 'Your M-Pesa number. Entry fees are requested from it, so you '
                "don't type it each time."
          : 'Saved for paying entry fees. Other players never see it.',
      children: [
        Form(
          key: _form,
          child: LabeledField(
            label: kenya ? 'M-Pesa number' : 'Phone number',
            child: TextFormField(
              controller: _phone,
              autofocus: _saved == null,
              keyboardType: TextInputType.phone,
              autofillHints: const [AutofillHints.telephoneNumberNational],
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _save(),
              validator: (value) => PhoneNumber.validate(value, _country),
              decoration: InputDecoration(
                hintText: kenya ? '0712 345 678' : 'Phone number',
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
        PrimaryButton(label: 'Save', busy: busy, onPressed: _save),
        if (_saved != null) ...[
          const SizedBox(height: TonitsSpace.md),
          Center(
            child: TextButton(
              onPressed: busy ? null : _remove,
              style: TextButton.styleFrom(foregroundColor: p.destructive),
              child: const Text('Remove phone number'),
            ),
          ),
        ],
      ],
    );
  }
}
