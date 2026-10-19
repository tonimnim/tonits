import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/error_text.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../account/application/account_service.dart';
import '../../../auth/application/auth_controller.dart';

/// Picks a new country and saves it after the player confirms, since it
/// moves them to another country ladder.
Future<void> changeCountry(BuildContext context, WidgetRef ref) async {
  final current = ref.read(currentPlayerProvider)?.countryCode;
  final picked = await showCountryPicker(context);
  if (picked == null || picked.code == current || !context.mounted) return;

  final confirmed = await confirmAction(
    context,
    title: 'Change your country to ${picked.name}?',
    message:
        'Your country ranking and the competitions open to you follow your '
        'country.',
    confirmLabel: 'Change',
  );
  if (!confirmed || !context.mounted) return;

  final messenger = ScaffoldMessenger.of(context);
  try {
    await ref.read(accountServiceProvider).updateCountry(picked.code);
    messenger.showSnackBar(
      SnackBar(content: Text('Country changed to ${picked.name}')),
    );
  } catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(describeError(e))));
  }
}
