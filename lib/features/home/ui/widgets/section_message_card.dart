import 'package:flutter/material.dart';

import '../../../../core/api/error_text.dart';
import '../../../../core/widgets/widgets.dart';

/// A Home section's loading, empty or error state, in a card so the page
/// keeps its rhythm while one section is not ready.
class SectionMessageCard extends StatelessWidget {
  const SectionMessageCard.loading({super.key}) : _child = const LoadingState();

  SectionMessageCard.error({
    super.key,
    required Object error,
    required VoidCallback onRetry,
  }) : _child = ErrorState(message: describeError(error), onRetry: onRetry);

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
       );

  final Widget _child;

  @override
  Widget build(BuildContext context) => Card(child: _child);
}
