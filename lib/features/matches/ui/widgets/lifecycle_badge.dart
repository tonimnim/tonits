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
    final (label, tone) = describe(match, context.l10n);
    return StatusBadge(label, tone: tone);
  }

  /// The badge's words and tone, for places that show them as text.
  static (String, StatusTone) describe(MatchSummary match, AppLocalizations l) {
    return switch (match.lifecycle) {
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
