import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/application/auth_providers.dart';
import '../../auth/ui/widgets/form_error.dart';
import '../application/account_providers.dart';
import 'widgets/account_form_page.dart';

/// Changes the short bio on the player's public profile.
class EditBioScreen extends ConsumerStatefulWidget {
  const EditBioScreen({super.key});

  @override
  ConsumerState<EditBioScreen> createState() => _EditBioScreenState();
}

class _EditBioScreenState extends ConsumerState<EditBioScreen> with BusyState {
  static const _max = 280;

  late final _bio = TextEditingController(
    text: ref.read(currentPlayerProvider)?.profile?.bio ?? '',
  );

  @override
  void dispose() {
    _bio.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (busy) return;
    final bio = _bio.text.trim();
    if (bio == (ref.read(currentPlayerProvider)?.profile?.bio ?? '')) {
      Navigator.of(context).pop();
      return;
    }
    await run(() async {
      await ref.read(accountServiceProvider).updateProfile(bio: bio);
      if (mounted) popWithMessage(context, context.l10n.accountBioUpdated);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AccountFormPage(
      title: l.accountBio,
      intro: l.accountEditBioIntro,
      children: [
        LabeledField(
          label: l.accountBio,
          child: TextField(
            controller: _bio,
            autofocus: true,
            minLines: 3,
            maxLines: 6,
            maxLength: _max,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(hintText: l.accountBioHint),
          ),
        ),
        const SizedBox(height: TonitsSpace.lg),
        FormError(error),
        PrimaryButton(label: l.accountSave, busy: busy, onPressed: _save),
      ],
    );
  }
}
