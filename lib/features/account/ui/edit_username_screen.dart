import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/application/auth_providers.dart';
import '../../auth/ui/widgets/form_error.dart';
import '../../onboarding/ui/widgets/username_field.dart';
import '../application/account_providers.dart';
import 'widgets/account_form_page.dart';

/// Changes the @handle, checked with the server as the player types.
class EditUsernameScreen extends ConsumerStatefulWidget {
  const EditUsernameScreen({super.key});

  @override
  ConsumerState<EditUsernameScreen> createState() => _EditUsernameScreenState();
}

class _EditUsernameScreenState extends ConsumerState<EditUsernameScreen>
    with BusyState {
  final _form = GlobalKey<FormState>();
  late final _handle = TextEditingController(text: _current ?? '');

  String? get _current => ref.read(currentPlayerProvider)?.handle;

  @override
  void dispose() {
    _handle.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (busy || !_form.currentState!.validate()) return;
    final handle = _handle.text.trim();
    if (handle == _current) {
      Navigator.of(context).pop();
      return;
    }
    await run(() async {
      await ref.read(accountServiceProvider).updateProfile(handle: handle);
      if (mounted) popWithMessage(context, context.l10n.accountUsernameUpdated);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AccountFormPage(
      title: l.accountUsername,
      intro: l.accountEditUsernameIntro,
      children: [
        Form(
          key: _form,
          child: UsernameField(controller: _handle, onSubmitted: _save),
        ),
        const SizedBox(height: TonitsSpace.lg),
        FormError(error),
        PrimaryButton(label: l.accountSave, busy: busy, onPressed: _save),
      ],
    );
  }
}
