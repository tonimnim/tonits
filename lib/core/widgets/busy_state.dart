import 'package:flutter/widgets.dart';

import '../api/error_text.dart';
import '../l10n.dart';

/// The busy flag and error message every form and action screen keeps:
/// [run] shows the work in progress, and the failure as a sentence for the
/// player. One action at a time.
mixin BusyState<T extends StatefulWidget> on State<T> {
  bool busy = false;
  String? error;

  /// Runs [action] unless one is already running. Failures become [error]
  /// through [describe] (by default, [describeError]).
  Future<void> run(
    Future<void> Function() action, {
    String Function(Object error)? describe,
  }) async {
    if (busy) return;
    final l = context.l10n;
    setState(() {
      busy = true;
      error = null;
    });
    try {
      await action();
    } catch (e) {
      if (mounted) {
        setState(() => error = describe?.call(e) ?? describeError(e, l));
      }
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  /// For actions that report their own failure as a message, and null on
  /// success. Returns whether it succeeded.
  Future<bool> runForMessage(Future<String?> Function() action) async {
    if (busy) return false;
    final l = context.l10n;
    setState(() {
      busy = true;
      error = null;
    });
    String? message;
    try {
      message = await action();
    } catch (e) {
      message = describeError(e, l);
    }
    if (mounted) {
      setState(() {
        busy = false;
        error = message;
      });
    }
    return message == null;
  }
}
