import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/application/auth_providers.dart';
import '../../auth/ui/widgets/form_error.dart';
import '../application/account_providers.dart';
import 'widgets/account_form_page.dart';

/// Changes the name opponents and public profiles show.
class EditNameScreen extends ConsumerStatefulWidget {
  const EditNameScreen({super.key});

  @override
  ConsumerState<EditNameScreen> createState() => _EditNameScreenState();
}

class _EditNameScreenState extends ConsumerState<EditNameScreen>
    with BusyState {
  final _form = GlobalKey<FormState>();
  late final _name = TextEditingController(
    text: ref.read(currentPlayerProvider)?.displayName ?? '',
  );

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  static String? _validate(String? value, AppLocalizations l) {
    final length = (value ?? '').trim().runes.length;
    if (length == 0) return l.accountEnterDisplayName;
    if (length < 2 || length > 80) return l.accountDisplayNameLength;
    return null;
  }

  Future<void> _save() async {
    if (busy || !_form.currentState!.validate()) return;
    final name = _name.text.trim();
    if (name == ref.read(currentPlayerProvider)?.displayName) {
      Navigator.of(context).pop();
      return;
    }
    await run(() async {
      await ref.read(accountServiceProvider).updateDisplayName(name);
      if (mounted) {
        popWithMessage(context, context.l10n.accountDisplayNameUpdated);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AccountFormPage(
      title: l.accountDisplayName,
      intro: l.accountEditNameIntro,
      children: [
        Form(
          key: _form,
          child: LabeledField(
            label: l.accountDisplayName,
            child: TextFormField(
              controller: _name,
              autofocus: true,
              maxLength: 80,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _save(),
              validator: (v) => _validate(v, l),
              decoration: InputDecoration(
                hintText: l.accountYourNameHint,
                counterText: '',
              ),
            ),
          ),
        ),
        const SizedBox(height: TonitsSpace.lg),
        FormError(error),
        PrimaryButton(label: l.accountSave, busy: busy, onPressed: _save),
      ],
    );
  }
}
