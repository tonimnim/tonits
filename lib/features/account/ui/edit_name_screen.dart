import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/ui/widgets/form_error.dart';
import 'widgets/account_form_page.dart';
import '../../auth/application/auth_providers.dart';
import '../application/account_providers.dart';

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

  static String? _validate(String? value) {
    final length = (value ?? '').trim().runes.length;
    if (length == 0) return 'Enter a display name';
    if (length < 2 || length > 80) return 'Use 2 to 80 characters';
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
      if (mounted) popWithMessage(context, 'Display name updated');
    });
  }

  @override
  Widget build(BuildContext context) {
    return AccountFormPage(
      title: 'Display name',
      intro:
          'The name opponents see in matches, rankings and on your profile. '
          'Your username stays the same.',
      children: [
        Form(
          key: _form,
          child: LabeledField(
            label: 'Display name',
            child: TextFormField(
              controller: _name,
              autofocus: true,
              maxLength: 80,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _save(),
              validator: _validate,
              decoration: const InputDecoration(
                hintText: 'Your name',
                counterText: '',
              ),
            ),
          ),
        ),
        const SizedBox(height: TonitsSpace.lg),
        FormError(error),
        PrimaryButton(label: 'Save', busy: busy, onPressed: _save),
      ],
    );
  }
}
