import 'package:flutter/material.dart';

import '../../../../core/api/error_text.dart';
import '../../../../core/l10n.dart';
import '../../../../core/widgets/widgets.dart';

/// A Home section's loading, empty or error state, in a card so the page
/// keeps its rhythm while one section is not ready.
class SectionMessageCard extends StatelessWidget {
  const SectionMessageCard.loading({super.key})
    : _child = const LoadingState(),
      _error = null;

  const SectionMessageCard.error({
    super.key,
    required Object error,
    required VoidCallback onRetry,
  }) : _child = null,
       _error = (error, onRetry);

  SectionMessageCard.empty({
    super.key,
    required IconData icon,
    required String title,
    String? message,
    String? actionLabel,
    VoidCallback? onAction,
  }) : _child = EmptyState(
         icon: icon,
         title: title,
         message: message,
         actionLabel: actionLabel,
         onAction: onAction,
       ),
       _error = null;

  final Widget? _child;

  /// The failure and its retry, described when built so the text follows
  /// the app's language.
  final (Object, VoidCallback)? _error;

  @override
  Widget build(BuildContext context) {
    final (error, onRetry) = _error ?? (null, null);
    return Card(
      child:
          _child ??
          ErrorState(
            message: describeError(error!, context.l10n),
            onRetry: onRetry!,
          ),
    );
  }
}
