import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/error_text.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/application/auth_controller.dart';
import '../../auth/ui/widgets/form_error.dart';
import '../application/account_service.dart';
import 'widgets/account_form_page.dart';

/// Changes the name opponents and public profiles show.
class EditNameScreen extends ConsumerStatefulWidget {
  const EditNameScreen({super.key});

  @override
  ConsumerState<EditNameScreen> createState() => _EditNameScreenState();
}

class _EditNameScreenState extends ConsumerState<EditNameScreen> {
  final _form = GlobalKey<FormState>();
  late final _name = TextEditingController(
    text: ref.read(currentPlayerProvider)?.displayName ?? '',
  );
  bool _busy = false;
  String? _error;

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
    if (_busy || !_form.currentState!.validate()) return;
    final name = _name.text.trim();
    if (name == ref.read(currentPlayerProvider)?.displayName) {
      Navigator.of(context).pop();
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(accountServiceProvider).updateDisplayName(name);
      if (mounted) popWithMessage(context, 'Display name updated');
    } catch (e) {
      if (mounted) setState(() => _error = describeError(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
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
        FormError(_error),
        PrimaryButton(label: 'Save', busy: _busy, onPressed: _save),
      ],
    );
  }
}
