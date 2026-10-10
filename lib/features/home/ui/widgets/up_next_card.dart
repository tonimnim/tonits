import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/format.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../matches/application/matches_providers.dart';
import '../../../matches/data/match_summary.dart';
import '../../../matches/ui/widgets/lifecycle_badge.dart';

/// The player's next match in one line, shown only when there is one.
class UpNextCard extends ConsumerWidget {
  const UpNextCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final match = ref.watch(nextMatchProvider).value;
    if (match == null) return const SizedBox.shrink();
    final p = context.palette;
    final when = _when(match);

    return Padding(
      padding: const EdgeInsets.only(top: TonitsSpace.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(title: 'Up next'),
          const SizedBox(height: TonitsSpace.sm),
          Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => context.go(Routes.matches),
              child: Padding(
                padding: const EdgeInsets.all(TonitsSpace.md),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              LifecycleBadge(match: match),
                              if (when != null) ...[
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    when,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: p.subtleForeground,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            match.opponent == null
                                ? 'Opponent to be decided'
                                : 'vs ${match.opponent!.displayName}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '${match.competitionName} · ${match.roundName}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: p.mutedForeground,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: p.mutedForeground),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// The deadline that matters now: check-in when it's open, else kick-off.
  static String? _when(MatchSummary match) {
    if (match.lifecycle == MatchLifecycle.readyForCheckIn &&
        match.checkInClosesAt != null) {
      return 'by ${Format.dateTime(match.checkInClosesAt!)}';
    }
    final at = match.scheduledAt;
    return at == null ? null : Format.dateTime(at);
  }
}
