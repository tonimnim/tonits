import 'package:flutter/material.dart';

import '../theme.dart';

/// An inline problem message in the destructive tone.
class Notice extends StatelessWidget {
  const Notice(this.message, {super.key, this.action});

  final String message;

  /// An optional button beside the message, such as "Retry".
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Semantics(
      liveRegion: true,
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        decoration: BoxDecoration(
          color: p.destructive.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(TonitsRadius.control),
          border: Border.all(color: p.destructive.withValues(alpha: 0.35)),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, size: 20, color: p.destructive),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: p.destructive,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ?action,
          ],
        ),
      ),
    );
  }
}
