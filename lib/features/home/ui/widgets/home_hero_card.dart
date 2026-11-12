import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/clock.dart';
import '../../../../core/format.dart';
import '../../../../core/l10n.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme.dart';
import '../../../competitions/application/competitions_providers.dart';
import '../../../competitions/data/competition.dart';
import '../../../competitions/data/registration.dart';
import '../../../matches/application/matches_providers.dart';
import '../../../matches/data/match_summary.dart';
import '../../../matches/ui/widgets/lifecycle_badge.dart';
import '../../application/find_card_snooze.dart';

/// Home's one volt card, for the one thing that matters now, most
/// important first:
///
/// 1. The player's next match, which opens it. When the match is waiting
///    on them (check in, report, confirm, a screenshot) it says so.
/// 2. Otherwise, competitions open to enter, which opens Compete; only
///    while the player isn't in one, and not for [findCardSnooze] after
///    they tap it or close it.
/// 3. Otherwise nothing: no card sends them to an empty list.
///
/// Nothing shows until what decides it is known, so cards never swap.
class HomeHeroCard extends ConsumerWidget {
  const HomeHeroCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final next = ref.watch(nextMatchProvider);
    if (!next.hasValue) return const SizedBox.shrink();
    final match = next.value;

    final card = match == null
        ? _findCard(context, ref)
        : _matchCard(context, match);
    if (card == null) return const SizedBox.shrink();
    return Padding(padding: const EdgeInsets.only(bottom: 12), child: card);
  }

  Widget _matchCard(BuildContext context, MatchSummary match) {
    final l = context.l10n;
    final (status, _) = LifecycleBadge.describe(match, l);
    final when = _when(match, l);
    return _VoltCard(
      eyebrow: _waitsOnPlayer(match.lifecycle) ? l.homeYourMove : l.homeUpNext,
      title: match.opponent == null
          ? l.homeOpponentToBeDecided
          : l.playerVersus(match.opponent!.displayName),
      lines: ['$status · ${match.place(l.seriesBestOf)}', ?when],
      onTap: () => context.go(Routes.match(match.id)),
    );
  }

  Widget? _findCard(BuildContext context, WidgetRef ref) {
    final open = ref.watch(openCompetitionsProvider).value;
    if (open == null || open.isEmpty) return null;
    final entries = ref.watch(myEntriesProvider);
    if (entries.isLoading && !entries.hasValue) return null;
    // Already in one: the draw brings their match; no need to push more.
    if (entries.value?.items.any(_active) ?? false) return null;
    final snooze = ref.watch(findCardSnoozeProvider);
    if (snooze.isLoading && !snooze.hasValue) return null;
    final now = ref.watch(clockProvider).value ?? DateTime.now();
    if (findCardSnoozed(snooze.value, now)) return null;

    final l = context.l10n;
    void rest() => ref.read(findCardSnoozeProvider.notifier).snooze(now);
    return _VoltCard(
      title: l.homeFindTitle,
      lines: [l.homeOpenCount(open.length)],
      onTap: () {
        rest();
        context.go(Routes.competitions);
      },
      onClose: rest,
      closeLabel: l.homeFindNotNow,
    );
  }

  static bool _waitsOnPlayer(MatchLifecycle lifecycle) => switch (lifecycle) {
    MatchLifecycle.readyForCheckIn ||
    MatchLifecycle.reportRequired ||
    MatchLifecycle.confirmationRequired ||
    MatchLifecycle.screenshotRequired => true,
    _ => false,
  };

  /// An entry the player is still in, in a competition still to finish.
  static bool _active(Registration entry) =>
      (entry.status == EntryStatus.registered ||
          entry.status == EntryStatus.checkedIn ||
          entry.status == EntryStatus.accepted) &&
      entry.competitionStatus != CompetitionStatus.completed &&
      entry.competitionStatus != CompetitionStatus.cancelled;

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
/// arrow. The whole card is the button; with [onClose], a small cross in
/// the corner puts it away.
class _VoltCard extends StatelessWidget {
  const _VoltCard({
    this.eyebrow,
    required this.title,
    required this.lines,
    required this.onTap,
    this.onClose,
    this.closeLabel,
  });

  final String? eyebrow;
  final String title;
  final List<String> lines;
  final VoidCallback onTap;
  final VoidCallback? onClose;
  final String? closeLabel;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final ink = p.onSoft;
    final card = Semantics(
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
    if (onClose == null) return card;
    return Stack(
      children: [
        card,
        Positioned(
          top: 6,
          right: 6,
          child: IconButton(
            tooltip: closeLabel,
            onPressed: onClose,
            icon: const Icon(Icons.close_rounded, size: 18),
            color: ink.withValues(alpha: 0.6),
            visualDensity: VisualDensity.compact,
          ),
        ),
      ],
    );
  }
}
