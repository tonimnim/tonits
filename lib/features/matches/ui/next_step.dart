import '../../../core/format.dart';
import '../../../core/l10n.dart';
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

  factory NextStep.of(MatchRoom room, AppLocalizations l) {
    final match = room.summary;
    final opp = match.opponent?.displayName ?? l.matchYourOpponent;
    final v = room.verification;
    final reported = v.submitted == null
        ? l.matchTheScore
        : scoreText(v.submitted!.score, home: match.isHome, l: l);

    return switch (room.lifecycle) {
      MatchLifecycle.assigned => NextStep(
        title: l.matchScheduled,
        tone: StepTone.neutral,
        message: match.opponent == null
            ? l.matchStepOpponentFromEarlierRound
            : room.checkInOpensAt != null
            ? l.matchStepCheckInOpens(Format.dateTime(room.checkInOpensAt!, l))
            : match.scheduledAt != null
            ? l.matchStepKickOff(Format.dateTime(match.scheduledAt!, l))
            : l.matchStepWeWillLetYouKnow,
      ),
      MatchLifecycle.readyForCheckIn => NextStep(
        title: l.matchStepCheckInTitle,
        tone: StepTone.action,
        message: l.matchStepCheckInMessage,
        deadline: match.checkInClosesAt,
      ),
      MatchLifecycle.checkedIn => NextStep(
        title: l.matchStepCheckedInTitle,
        tone: StepTone.waiting,
        message: l.matchStepCheckedInMessage(opp),
        deadline: match.checkInClosesAt,
      ),
      MatchLifecycle.reportRequired => NextStep(
        title: l.matchStepPlayTitle,
        tone: StepTone.action,
        message: room.isSeries
            ? l.seriesStepPlayMessage(
                room.bestOf,
                opp,
                room.gamesToWin,
                '${room.gamesToWin}\u2060–\u2060${room.gamesToWin - 1}',
              )
            : l.matchStepPlayMessage(opp),
        deadline: room.resultDueAt,
        deadlineNote: l.matchStepPlayDeadlineNote,
      ),
      MatchLifecycle.awaitingOpponentConfirmation => NextStep(
        title: l.matchStepAwaitingConfirmationTitle(opp),
        tone: StepTone.waiting,
        message: l.matchStepAwaitingConfirmationMessage(reported, opp),
        deadline: v.confirmationDeadline,
      ),
      MatchLifecycle.confirmationRequired => NextStep(
        title: l.matchStepConfirmTitle,
        tone: StepTone.action,
        message: l.matchStepConfirmMessage(opp),
        deadline: v.confirmationDeadline,
      ),
      MatchLifecycle.screenshotRequired => NextStep(
        title: room.isSeries
            ? l.seriesStepScreenshotTitle
            : l.matchStepScreenshotTitle,
        tone: StepTone.action,
        message: room.isSeries
            ? l.seriesStepScreenshotMessage
            : l.matchStepScreenshotMessage,
        deadline: v.screenshotDeadline,
        deadlineNote: room.isSeries
            ? l.seriesStepScreenshotNote
            : l.matchStepScreenshotDeadlineNote,
      ),
      MatchLifecycle.awaitingOpponentScreenshot => NextStep(
        title: room.isSeries
            ? l.seriesStepScreenshotsSentTitle
            : l.matchStepScreenshotSentTitle,
        tone: StepTone.waiting,
        message: v.opponentScreenshotSent
            ? l.matchStepBothScreenshotsIn
            : l.matchStepWaitingForScreenshot(opp),
        deadline: v.screenshotDeadline,
      ),
      MatchLifecycle.awaitingResolution => NextStep(
        title: l.matchStepSettlingTitle,
        tone: StepTone.waiting,
        message: l.matchStepSettlingMessage,
      ),
      MatchLifecycle.underReview => NextStep(
        title: l.matchUnderReview,
        tone: StepTone.waiting,
        message: l.matchStepUnderReviewMessage,
      ),
      MatchLifecycle.completed => NextStep(
        title: _outcomeTitle(match.outcome, l),
        tone: _outcomeTone(match.outcome),
        message: switch ((room.result?.origin, v.submitted?.byMe)) {
          ('agreed_reports', true) => l.matchStepOpponentConfirmedYours(opp),
          ('agreed_reports', false) => l.matchStepYouConfirmed,
          ('agreed_reports', null) => l.matchStepBothAgreed,
          ('unanswered', true) => l.matchStepOpponentUnanswered(opp),
          ('unanswered', _) => l.matchStepUnanswered,
          ('platform_review', _) => l.matchStepDecidedByReview,
          _ => l.matchStepResultConfirmed,
        },
      ),
      MatchLifecycle.forfeited => NextStep(
        title: _outcomeTitle(match.outcome, l),
        tone: _outcomeTone(match.outcome),
        message: _forfeitReason(
          room.completionReason,
          won: match.outcome == MatchOutcome.won,
          opp: opp,
          l: l,
        ),
      ),
      MatchLifecycle.cancelled => NextStep(
        title: l.matchNoResult,
        tone: v.entryRemoved ? StepTone.bad : StepTone.neutral,
        message: switch (room.completionReason) {
          'no_result_reported' => l.matchCancelledNoResultReported,
          'response_timeout' => l.matchCancelledResponseTimeout,
          'double_no_show' => l.matchCancelledDoubleNoShow,
          'competition_cancelled' => l.matchCancelledCompetitionCancelled,
          'platform_review' => l.matchCancelledPlatformReview,
          'reset_not_required' ||
          'correction_voided' => l.matchCancelledNotNeeded,
          _ => l.matchCancelledOther,
        },
      ),
      MatchLifecycle.outOfCompetition => NextStep(
        title: l.matchStepOutTitle,
        tone: StepTone.bad,
        message: l.matchStepOutMessage,
      ),
      MatchLifecycle.unknown => NextStep(
        title: l.matchStepUnknownTitle,
        tone: StepTone.neutral,
        message: l.matchStepUnknownMessage,
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
  static String scoreText(
    Score score, {
    required bool home,
    required AppLocalizations l,
  }) {
    final (mine, theirs) = score.forSide(home: home);
    final pens = score.penalties;
    if (pens == null) return '$mine–$theirs';
    final (pMine, pTheirs) = pens.forSide(home: home);
    return l.matchScoreWithPens(mine, theirs, pMine, pTheirs);
  }

  static String _outcomeTitle(MatchOutcome? outcome, AppLocalizations l) =>
      switch (outcome) {
        MatchOutcome.won => l.matchOutcomeYouWon,
        MatchOutcome.lost => l.matchOutcomeYouLost,
        MatchOutcome.drawn => l.matchOutcomeDraw,
        _ => l.matchFinished,
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
    required AppLocalizations l,
  }) => switch (reason) {
    'timeout_forfeit' =>
      won ? l.matchForfeitOpponentNoCheckIn(opp) : l.matchForfeitYouNoCheckIn,
    'walkover' => won ? l.matchForfeitOpponentLeft(opp) : l.matchForfeitYouLeft,
    'response_timeout' =>
      won
          ? l.matchForfeitOpponentNoScreenshot(opp)
          : l.matchForfeitYouNoScreenshot,
    'platform_review' => l.matchForfeitPlatformReview,
    _ =>
      won ? l.matchForfeitWonWithoutPlaying : l.matchForfeitDecidedWithoutYou,
  };
}
