import 'package:flutter/material.dart';

import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';

/// The player's avatar beside a time-of-day greeting and their name.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.name, this.now});

  final String name;

  /// For tests; defaults to the current time.
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final hour = (now ?? DateTime.now()).hour;
    final greeting = hour < 12
        ? 'Good morning'
        : hour < 17
        ? 'Good afternoon'
        : 'Good evening';
    return Row(
      children: [
        InitialsAvatar(name: name, size: 44),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: TextStyle(fontSize: 13, color: p.subtleForeground),
              ),
              Semantics(
                header: true,
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
