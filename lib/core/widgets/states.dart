import 'package:flutter/material.dart';

import '../theme.dart';
import 'buttons.dart';

/// A quiet message for an empty list, with an optional action.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: TonitsSpace.lg,
        vertical: TonitsSpace.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28, color: p.mutedForeground),
          const SizedBox(height: TonitsSpace.md),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (message != null) ...[
            const SizedBox(height: TonitsSpace.xs),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: TextStyle(color: p.subtleForeground),
            ),
          ],
          if (actionLabel != null) ...[
            const SizedBox(height: TonitsSpace.lg),
            SecondaryButton(label: actionLabel!, onPressed: onAction),
          ],
        ],
      ),
    );
  }
}

/// A failed load, with a retry.
class ErrorState extends StatelessWidget {
  const ErrorState({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.cloud_off_outlined,
      title: "Couldn't load this",
      message: message,
      actionLabel: 'Try again',
      onAction: onRetry,
    );
  }
}

/// A spinner sized like the content it stands in for.
class LoadingState extends StatelessWidget {
  const LoadingState({super.key, this.height = 120});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: const Center(
        child: SizedBox.square(
          dimension: 24,
          child: CircularProgressIndicator(strokeWidth: 2.5),
        ),
      ),
    );
  }
}
