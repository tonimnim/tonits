import '../../../core/format.dart';
import '../data/match_room.dart';
import '../data/match_summary.dart';

/// How the room's main panel reads.
enum StepTone {
  /// The player has something to do.
  action,

  /// Waiting on the opponent or Tonits.
  waiting,
  won,
  neutral,

  /// Lost, removed or out.
  bad,
}

/// What the player sees in the room's main panel: where the match stands,
/// what happens next, and by when. Built from the server's lifecycle,
/// outcome and completion reason only.
class NextStep {
  const NextStep({
    required this.title,
    required this.message,
    required this.tone,
    this.deadline,
    this.deadlineNote,
  });

  factory NextStep.of(MatchRoom room) {
    final match = room.summary;
    final opp = match.opponent?.displayName ?? 'your opponent';
    final v = room.verification;
    final reported = v.submitted == null
        ? 'the score'
        : scoreText(v.submitted!.score, home: match.isHome);

    return switch (room.lifecycle) {
      MatchLifecycle.assigned => NextStep(
        title: 'Scheduled',
        tone: StepTone.neutral,
        message: match.opponent == null
            ? 'Your opponent comes from an earlier round.'
            : room.checkInOpensAt != null
            ? 'Check-in opens ${Format.dateTime(room.checkInOpensAt!)}.'
            : match.scheduledAt != null
            ? 'Kick-off ${Format.dateTime(match.scheduledAt!)}.'
            : "We'll let you know when it's time to play.",
      ),
      MatchLifecycle.readyForCheckIn => NextStep(
        title: 'Time to check in',
        tone: StepTone.action,
        message:
            "Check in to say you're ready. If only one player checks in, "
            'that player wins.',
        deadline: match.checkInClosesAt,
      ),
      MatchLifecycle.checkedIn => NextStep(
        title: "You're checked in",
        tone: StepTone.waiting,
        message: 'Waiting for $opp to check in.',
        deadline: match.checkInClosesAt,
      ),
      MatchLifecycle.reportRequired => NextStep(
        title: 'Play your match',
        tone: StepTone.action,
        message:
            'Play a Friend Match with $opp in eFootball. When it ends, '
            'either of you reports the score.',
        deadline: room.resultDueAt,
        deadlineNote: 'If nobody reports in time, you are both removed.',
      ),
      MatchLifecycle.awaitingOpponentConfirmation => NextStep(
        title: 'Waiting for $opp to confirm',
        tone: StepTone.waiting,
        message:
            'You reported $reported. If $opp doesn\'t answer in time, your '
            'result stands.',
        deadline: v.confirmationDeadline,
      ),
      MatchLifecycle.confirmationRequired => NextStep(
        title: 'Confirm the result',
        tone: StepTone.action,
        message:
            '$opp reported the score above. Is it right? If you don\'t '
            'answer in time, it stands.',
        deadline: v.confirmationDeadline,
      ),
      MatchLifecycle.screenshotRequired => NextStep(
        title: 'Send your screenshot',
        tone: StepTone.action,
        message:
            'The result was rejected. Send one screenshot of the Full Time '
            'screen; Ozone compares both players\' screenshots.',
        deadline: v.screenshotDeadline,
        deadlineNote:
            "If you don't send one in time, you're removed from the "
            'competition.',
      ),
      MatchLifecycle.awaitingOpponentScreenshot => NextStep(
        title: 'Screenshot sent',
        tone: StepTone.waiting,
        message: v.opponentScreenshotSent
            ? 'Both screenshots are in. Ozone will review them.'
            : 'Waiting for $opp\'s screenshot. Ozone then checks both.',
        deadline: v.screenshotDeadline,
      ),
      MatchLifecycle.awaitingResolution => const NextStep(
        title: 'Settling the result',
        tone: StepTone.waiting,
        message: 'A deadline just passed. This takes a few seconds.',
      ),
      MatchLifecycle.underReview => const NextStep(
        title: 'Under review',
        tone: StepTone.waiting,
        message:
            'Ozone is checking both screenshots against the reported '
            "score. You'll be notified of the decision.",
      ),
      MatchLifecycle.completed => NextStep(
        title: _outcomeTitle(match.outcome),
        tone: _outcomeTone(match.outcome),
        message: switch ((room.result?.origin, v.submitted?.byMe)) {
          ('agreed_reports', true) => '$opp confirmed your result.',
          ('agreed_reports', false) => 'You confirmed the result.',
          ('agreed_reports', null) => 'Both players agreed on the result.',
          ('unanswered', true) =>
            "$opp didn't answer in time, so your result stood.",
          ('unanswered', _) =>
            "The result wasn't answered in time, so it stood.",
          ('platform_review', _) => 'Ozone decided the result after a review.',
          _ => 'The result is confirmed.',
        },
      ),
      MatchLifecycle.forfeited => NextStep(
        title: _outcomeTitle(match.outcome),
        tone: _outcomeTone(match.outcome),
        message: _forfeitReason(
          room.completionReason,
          won: match.outcome == MatchOutcome.won,
          opp: opp,
        ),
      ),
      MatchLifecycle.cancelled => NextStep(
        title: 'No result',
        tone: v.entryRemoved ? StepTone.bad : StepTone.neutral,
        message: switch (room.completionReason) {
          'no_result_reported' =>
            'Nobody reported a score in time, so both players were removed.',
          'response_timeout' =>
            'Neither player sent a screenshot, so both were removed.',
          'double_no_show' => 'Neither player checked in.',
          'competition_cancelled' => 'The competition was cancelled.',
          'platform_review' => 'Ozone cancelled the match after a review.',
          'reset_not_required' ||
          'correction_voided' => 'The bracket no longer needed this match.',
          _ => 'This match was cancelled.',
        },
      ),
      MatchLifecycle.outOfCompetition => const NextStep(
        title: "You're out of this competition",
        tone: StepTone.bad,
        message: 'This match will be settled without you.',
      ),
      MatchLifecycle.unknown => const NextStep(
        title: 'Match',
        tone: StepTone.neutral,
        message: 'Update Ozone to see where this match stands.',
      ),
    };
  }

  final String title;
  final String message;
  final StepTone tone;

  /// When the current step ends, for a countdown.
  final DateTime? deadline;

  /// What happens when it does, if that costs the player something.
  final String? deadlineNote;

  /// "2–1", or "1–1 (4–3 pens)", from the player's side.
  static String scoreText(Score score, {required bool home}) {
    final (mine, theirs) = score.forSide(home: home);
    final pens = score.penalties;
    if (pens == null) return '$mine–$theirs';
    final (pMine, pTheirs) = pens.forSide(home: home);
    return '$mine–$theirs ($pMine–$pTheirs pens)';
  }

  static String _outcomeTitle(MatchOutcome? outcome) => switch (outcome) {
    MatchOutcome.won => 'You won',
    MatchOutcome.lost => 'You lost',
    MatchOutcome.drawn => 'Draw',
    _ => 'Finished',
  };

  static StepTone _outcomeTone(MatchOutcome? outcome) => switch (outcome) {
    MatchOutcome.won => StepTone.won,
    MatchOutcome.lost => StepTone.bad,
    _ => StepTone.neutral,
  };

  static String _forfeitReason(
    String? reason, {
    required bool won,
    required String opp,
  }) => switch (reason) {
    'timeout_forfeit' =>
      won ? "$opp didn't check in." : "You didn't check in in time.",
    'walkover' =>
      won
          ? '$opp had already left the competition.'
          : 'Your entry had already left the competition.',
    'response_timeout' =>
      won
          ? "$opp didn't send a screenshot after the result was rejected."
          : "You didn't send a screenshot in time, so you were removed.",
    'platform_review' => 'Ozone decided the match after a review.',
    _ =>
      won ? 'You won without playing.' : 'The match was decided without you.',
  };
}
