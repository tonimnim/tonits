import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/format.dart';
import '../../../../core/l10n.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../competitions/application/competitions_providers.dart';
import '../../../matches/application/matches_providers.dart';
import '../../../matches/data/match_summary.dart';
import '../../../matches/ui/widgets/lifecycle_badge.dart';

/// Home's one volt card: the player's next match when they have one, which
/// opens it; otherwise the way to their next competition, which opens
/// Compete. It says only what's true: no match is promised that isn't
/// there.
///
/// Nothing shows until the next match is known, so the two never swap.
class HomeHeroCard extends ConsumerWidget {
  const HomeHeroCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final next = ref.watch(nextMatchProvider);
    if (!next.hasValue) return const SizedBox.shrink();
    final l = context.l10n;
    final match = next.value;

    final Widget card;
    if (match == null) {
      final open = ref.watch(openCompetitionsProvider).value;
      card = _VoltCard(
        title: l.homeFindTitle,
        lines: [
          if (open != null)
            open.isEmpty ? l.homeComingUp : l.homeOpenCount(open.length),
        ],
        onTap: () => context.go(Routes.competitions),
      );
    } else {
      final (status, _) = LifecycleBadge.describe(match, l);
      final when = _when(match, l);
      card = _VoltCard(
        eyebrow: l.homeUpNext,
        title: match.opponent == null
            ? l.homeOpponentToBeDecided
            : l.playerVersus(match.opponent!.displayName),
        lines: ['$status · ${match.place(l.seriesBestOf)}', ?when],
        onTap: () => context.go(Routes.match(match.id)),
      );
    }
    return Padding(padding: const EdgeInsets.only(bottom: 12), child: card);
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

/// A volt card with a title, a line or two under it and a round black
/// arrow. The whole card is the button.
class _VoltCard extends StatelessWidget {
  const _VoltCard({
    this.eyebrow,
    required this.title,
    required this.lines,
    required this.onTap,
  });

  final String? eyebrow;
  final String title;
  final List<String> lines;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final ink = p.onSoft;
    return Semantics(
      button: true,
      child: Material(
        color: p.soft,
        shape: TonitsShape.rounded(TonitsRadius.panel),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 20, 18, 22),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (eyebrow != null) ...[
                        Text(
                          eyebrow!,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: ink.withValues(alpha: 0.7),
                          ),
                        ),
                        const SizedBox(height: 6),
                      ],
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.7,
                          height: 1.15,
                          color: ink,
                        ),
                      ),
                      for (final line in lines) ...[
                        const SizedBox(height: 6),
                        Text(
                          line,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.3,
                            color: ink.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                ExcludeSemantics(
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: ink,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 24,
                      color: p.soft,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
