import 'package:flutter/material.dart';

import '../../../../core/api/error_text.dart';
import '../../../../core/l10n.dart';
import '../../../../core/widgets/widgets.dart';

/// A Home section that failed to load, in a card so the page keeps its
/// rhythm, with a retry.
class SectionMessageCard extends StatelessWidget {
  const SectionMessageCard.error({
    super.key,
    required this.error,
    required this.onRetry,
  });

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Card(
    child: ErrorState(
      message: describeError(error, context.l10n),
      onRetry: onRetry,
    ),
  );
}
