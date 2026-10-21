import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/format.dart';
import '../../../../core/l10n.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../matches/application/matches_providers.dart';
import '../../../matches/data/match_summary.dart';
import '../../../matches/ui/widgets/lifecycle_badge.dart';

/// The player's next match as one row: who, where it stands, and when.
/// Shown only when there is one.
class UpNextCard extends ConsumerWidget {
  const UpNextCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final match = ref.watch(nextMatchProvider).value;
    if (match == null) return const SizedBox.shrink();
    final p = context.palette;
    final l = context.l10n;
    final (status, tone) = LifecycleBadge.describe(match, l);
    final when = _when(match, l);

    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(title: l.homeUpNext),
          const SizedBox(height: TonitsSpace.sm),
          // On the page like the rows below; the whole row opens the match.
          InkWell(
            borderRadius: BorderRadius.circular(TonitsRadius.control),
            onTap: () => context.go(Routes.match(match.id)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          match.opponent == null
                              ? l.homeOpponentToBeDecided
                              : l.playerVersus(match.opponent!.displayName),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 2),
                        // The status first, so a long name never cuts it off.
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: status,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: tone.colorsIn(p).$1,
                                ),
                              ),
                              TextSpan(
                                text: ' · ${match.place(l.seriesBestOf)}',
                              ),
                            ],
                          ),
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
                  if (when != null) ...[
                    const SizedBox(width: 12),
                    Flexible(
                      flex: 2,
                      child: Text(
                        when,
                        maxLines: 2,
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// The deadline that matters now: check-in when it's open, else kick-off.
  static String? _when(MatchSummary match, AppLocalizations l) {
    if (match.lifecycle == MatchLifecycle.readyForCheckIn &&
        match.checkInClosesAt != null) {
      return l.homeCheckInBy(Format.dateTime(match.checkInClosesAt!, l));
    }
    final at = match.scheduledAt;
    return at == null ? null : Format.dateTime(at, l);
  }
}
