import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/error_text.dart';
import '../../../../core/l10n.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../account/application/account_providers.dart';
import '../../../auth/application/auth_providers.dart';

/// Picks a new country and saves it after the player confirms, since it
/// moves them to another country ladder.
Future<void> changeCountry(BuildContext context, WidgetRef ref) async {
  final current = ref.read(currentPlayerProvider)?.countryCode;
  final picked = await showCountryPicker(context);
  if (picked == null || picked.code == current || !context.mounted) return;

  final l = context.l10n;
  final confirmed = await confirmAction(
    context,
    title: l.profileChangeCountryTitle(picked.name),
    message: l.profileChangeCountryMessage,
    confirmLabel: l.profileChangeCountryConfirm,
  );
  if (!confirmed || !context.mounted) return;

  final messenger = ScaffoldMessenger.of(context);
  try {
    await ref.read(accountServiceProvider).updateCountry(picked.code);
    messenger.showSnackBar(
      SnackBar(content: Text(l.profileCountryChanged(picked.name))),
    );
  } catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(describeError(e, l))));
  }
}
