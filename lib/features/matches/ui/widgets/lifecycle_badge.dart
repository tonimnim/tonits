import 'package:flutter/material.dart';

import '../../../../core/widgets/widgets.dart';
import '../../data/match_summary.dart';

/// Where a match stands for the player, in their words. Warm tones mean
/// the player has something to do.
class LifecycleBadge extends StatelessWidget {
  const LifecycleBadge({super.key, required this.match});

  final MatchSummary match;

  @override
  Widget build(BuildContext context) {
    final (label, tone) = switch (match.lifecycle) {
      MatchLifecycle.assigned => ('Scheduled', StatusTone.muted),
      MatchLifecycle.readyForCheckIn => ('Check in', StatusTone.warn),
      MatchLifecycle.checkedIn => ('Checked in', StatusTone.info),
      MatchLifecycle.reportRequired => ('Report score', StatusTone.warn),
      MatchLifecycle.awaitingOpponentConfirmation => (
        'Waiting on opponent',
        StatusTone.info,
      ),
      MatchLifecycle.confirmationRequired => (
        'Confirm result',
        StatusTone.warn,
      ),
      MatchLifecycle.screenshotRequired => (
        'Send screenshots',
        StatusTone.warn,
      ),
      MatchLifecycle.awaitingOpponentScreenshot => (
        'Waiting on opponent',
        StatusTone.info,
      ),
      MatchLifecycle.awaitingResolution => ('Settling', StatusTone.info),
      MatchLifecycle.underReview => ('Under review', StatusTone.warn),
      MatchLifecycle.forfeited => _outcome(match.outcome, fallback: 'Forfeit'),
      MatchLifecycle.completed => _outcome(match.outcome),
      MatchLifecycle.cancelled => ('Cancelled', StatusTone.muted),
      MatchLifecycle.outOfCompetition => ('Out', StatusTone.bad),
      MatchLifecycle.unknown => ('—', StatusTone.muted),
    };
    return StatusBadge(label, tone: tone);
  }

  static (String, StatusTone) _outcome(
    MatchOutcome? outcome, {
    String fallback = 'Finished',
  }) => switch (outcome) {
    MatchOutcome.won => ('Won', StatusTone.good),
    MatchOutcome.lost => ('Lost', StatusTone.bad),
    MatchOutcome.drawn => ('Drawn', StatusTone.muted),
    MatchOutcome.noResult => ('No result', StatusTone.muted),
    null => (fallback, StatusTone.muted),
  };
}
