import 'package:flutter/material.dart';

import '../../../../core/l10n.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/match_summary.dart';

/// Where a match stands for the player, in their words. Warm tones mean
/// the player has something to do.
class LifecycleBadge extends StatelessWidget {
  const LifecycleBadge({super.key, required this.match});

  final MatchSummary match;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final (label, tone) = switch (match.lifecycle) {
      MatchLifecycle.assigned => (l.matchScheduled, StatusTone.muted),
      MatchLifecycle.readyForCheckIn => (l.matchCheckIn, StatusTone.warn),
      MatchLifecycle.checkedIn => (l.matchCheckedIn, StatusTone.info),
      MatchLifecycle.reportRequired => (
        l.matchBadgeReportScore,
        StatusTone.warn,
      ),
      MatchLifecycle.awaitingOpponentConfirmation => (
        l.matchBadgeWaitingOnOpponent,
        StatusTone.info,
      ),
      MatchLifecycle.confirmationRequired => (
        l.matchBadgeConfirmResult,
        StatusTone.warn,
      ),
      MatchLifecycle.screenshotRequired => (
        l.matchBadgeSendScreenshots,
        StatusTone.warn,
      ),
      MatchLifecycle.awaitingOpponentScreenshot => (
        l.matchBadgeWaitingOnOpponent,
        StatusTone.info,
      ),
      MatchLifecycle.awaitingResolution => (
        l.matchBadgeSettling,
        StatusTone.info,
      ),
      MatchLifecycle.underReview => (l.matchUnderReview, StatusTone.warn),
      MatchLifecycle.forfeited => _outcome(
        match.outcome,
        l,
        fallback: l.matchBadgeForfeit,
      ),
      MatchLifecycle.completed => _outcome(match.outcome, l),
      MatchLifecycle.cancelled => (l.matchBadgeCancelled, StatusTone.muted),
      MatchLifecycle.outOfCompetition => (l.matchBadgeOut, StatusTone.bad),
      MatchLifecycle.unknown => ('—', StatusTone.muted),
    };
    return StatusBadge(label, tone: tone);
  }

  static (String, StatusTone) _outcome(
    MatchOutcome? outcome,
    AppLocalizations l, {
    String? fallback,
  }) => switch (outcome) {
    MatchOutcome.won => (l.matchBadgeWon, StatusTone.good),
    MatchOutcome.lost => (l.matchBadgeLost, StatusTone.bad),
    MatchOutcome.drawn => (l.matchBadgeDrawn, StatusTone.muted),
    MatchOutcome.noResult => (l.matchNoResult, StatusTone.muted),
    null => (fallback ?? l.matchFinished, StatusTone.muted),
  };
}
