import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n.dart';

/// Asks the player to confirm an action. Returns true only when they
/// chose [confirmLabel].
Future<bool> confirmAction(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  String? cancelLabel,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(cancelLabel ?? context.l10n.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}

/// A short confirmation at the bottom of the screen. It replaces any
/// still showing, so the latest one is never stuck in a queue.
void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

/// Leaves the current screen and confirms what it did on the one below.
void popWithMessage(BuildContext context, String message) {
  final messenger = ScaffoldMessenger.of(context);
  Navigator.of(context).pop();
  messenger.showSnackBar(SnackBar(content: Text(message)));
}

/// Copies [value] and says so, such as "Konami ID copied".
Future<void> copyToClipboard(
  BuildContext context,
  String value, {
  required String what,
}) async {
  await Clipboard.setData(ClipboardData(text: value));
  if (context.mounted) showMessage(context, context.l10n.copied(what));
}
