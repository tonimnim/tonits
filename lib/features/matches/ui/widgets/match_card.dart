import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/format.dart';
import '../../../../core/l10n.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/match_summary.dart';
import 'lifecycle_badge.dart';

/// A match in a list: where it's from, who it's against, and when.
class MatchCard extends StatelessWidget {
  const MatchCard({super.key, required this.match});

  final MatchSummary match;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final opponent = match.opponent;
    final checkInBy =
        match.lifecycle == MatchLifecycle.readyForCheckIn &&
        match.checkInClosesAt != null;
    final when = checkInBy
        ? l.matchCheckInBy(Format.dateTime(match.checkInClosesAt!, l))
        : match.scheduledAt == null
        ? null
        : Format.dateTime(match.scheduledAt!, l);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(Routes.match(match.id)),
        child: Padding(
          padding: const EdgeInsets.all(TonitsSpace.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${match.competitionName} · ${match.roundName}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13, color: p.subtleForeground),
                    ),
                  ),
                  const SizedBox(width: TonitsSpace.sm),
                  LifecycleBadge(match: match),
                ],
              ),
              const SizedBox(height: TonitsSpace.md),
              Row(
                children: [
                  InitialsAvatar(name: opponent?.displayName ?? '?'),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          opponent == null
                              ? l.matchOpponentToBeDecided
                              : l.matchVsOpponent(opponent.displayName),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          opponent == null
                              ? l.matchWaitingEarlierRound
                              : '@${opponent.handle}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: p.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (when != null) ...[
                const SizedBox(height: TonitsSpace.md),
                const Divider(),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      checkInBy ? Icons.how_to_reg_outlined : Icons.schedule,
                      size: 16,
                      color: checkInBy ? p.warn.$1 : p.mutedForeground,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        when,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: checkInBy ? FontWeight.w600 : null,
                          color: checkInBy ? p.warn.$1 : p.subtleForeground,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
