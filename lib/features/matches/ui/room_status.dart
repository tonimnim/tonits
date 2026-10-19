import '../../../core/format.dart';
import '../../../core/l10n.dart';
import '../data/match_room.dart';
import '../data/match_summary.dart';

/// How the room's status line reads.
enum RoomTone {
  /// The player has something to do.
  action,

  /// Waiting on the opponent or Ozone.
  waiting,
  won,
  neutral,

  /// Lost, removed or out.
  bad,
}

/// The one line under the score saying where the match stands, the time
/// left when a step has a deadline, and a short warning only where missing
/// it costs the player. The actions sit right under it. Built from the
/// server's lifecycle, outcome and completion reason only.
class RoomStatus {
  const RoomStatus(
    this.text, {
    required this.tone,
    this.deadline,
    this.note,
    this.outcome = false,
  });

  factory RoomStatus.of(MatchRoom room, AppLocalizations l) {
    final match = room.summary;
    final opp = match.opponent?.displayName ?? l.matchYourOpponent;
    final v = room.verification;

    return switch (room.lifecycle) {
      MatchLifecycle.assigned => RoomStatus(
        match.opponent == null
            ? l.roomOpponentTbd
            : room.checkInOpensAt != null
            ? l.roomCheckInOpens(Format.dateTime(room.checkInOpensAt!, l))
            : match.scheduledAt != null
            ? l.roomKickOff(Format.dateTime(match.scheduledAt!, l))
            : l.roomScheduled,
        tone: RoomTone.neutral,
      ),
      MatchLifecycle.readyForCheckIn => RoomStatus(
        l.roomCheckInNow,
        tone: RoomTone.action,
        deadline: match.checkInClosesAt,
      ),
      MatchLifecycle.checkedIn => RoomStatus(
        l.roomWaitingCheckIn(opp),
        tone: RoomTone.waiting,
        deadline: match.checkInClosesAt,
      ),
      MatchLifecycle.reportRequired => RoomStatus(
        room.isSeries ? l.roomPlayThenReportSeries : l.roomPlayThenReport,
        tone: RoomTone.action,
        deadline: room.resultDueAt,
      ),
      MatchLifecycle.awaitingOpponentConfirmation => RoomStatus(
        l.roomWaitingConfirm(opp),
        tone: RoomTone.waiting,
        deadline: v.confirmationDeadline,
      ),
      MatchLifecycle.confirmationRequired => RoomStatus(
        l.roomOpponentReported(opp),
        tone: RoomTone.action,
        deadline: v.confirmationDeadline,
      ),
      MatchLifecycle.screenshotRequired => RoomStatus(
        room.windows.perGameScreenshots
            ? l.roomSendScreenshots
            : l.roomSendScreenshot,
        tone: RoomTone.action,
        deadline: v.screenshotDeadline,
        note: l.roomScreenshotNote,
      ),
      MatchLifecycle.awaitingOpponentScreenshot => RoomStatus(
        v.opponentScreenshotSent
            ? l.roomBothScreenshotsIn
            : l.roomWaitingScreenshots(opp),
        tone: RoomTone.waiting,
        deadline: v.screenshotDeadline,
      ),
      MatchLifecycle.awaitingResolution => RoomStatus(
        l.roomSettling,
        tone: RoomTone.waiting,
      ),
      MatchLifecycle.underReview => RoomStatus(
        l.roomUnderReview,
        tone: RoomTone.waiting,
      ),
      MatchLifecycle.completed => RoomStatus(
        _outcome(match.outcome, l),
        tone: _tone(match.outcome),
        outcome: true,
        note: switch ((room.result?.origin, v.submitted?.byMe)) {
          ('agreed_reports', true) => l.roomConfirmedBy(opp),
          ('agreed_reports', false) => l.roomYouConfirmed,
          ('unanswered', true) => l.roomUnansweredYours(opp),
          ('unanswered', _) => l.roomUnanswered,
          ('platform_review', _) => l.roomDecidedByReview,
          _ => null,
        },
      ),
      MatchLifecycle.forfeited => RoomStatus(
        _outcome(match.outcome, l),
        tone: _tone(match.outcome),
        outcome: true,
        note: _forfeitReason(
          room.completionReason,
          won: match.outcome == MatchOutcome.won,
          opp: opp,
          l: l,
        ),
      ),
      MatchLifecycle.cancelled => RoomStatus(
        l.matchNoResult,
        tone: v.entryRemoved ? RoomTone.bad : RoomTone.neutral,
        outcome: true,
        note: switch (room.completionReason) {
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
      MatchLifecycle.outOfCompetition => RoomStatus(
        l.roomOut,
        tone: RoomTone.bad,
      ),
      MatchLifecycle.unknown => RoomStatus(
        l.roomUpdate,
        tone: RoomTone.neutral,
      ),
    };
  }

  /// One line, such as "Amina Otieno reported this score".
  final String text;
  final RoomTone tone;

  /// When the current step ends, for the time left.
  final DateTime? deadline;

  /// A short warning, or how a finished match was settled.
  final String? note;

  /// A final result: shown large, as "You won".
  final bool outcome;

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

  static String _outcome(MatchOutcome? outcome, AppLocalizations l) =>
      switch (outcome) {
        MatchOutcome.won => l.matchOutcomeYouWon,
        MatchOutcome.lost => l.matchOutcomeYouLost,
        MatchOutcome.drawn => l.matchOutcomeDraw,
        _ => l.matchFinished,
      };

  static RoomTone _tone(MatchOutcome? outcome) => switch (outcome) {
    MatchOutcome.won => RoomTone.won,
    MatchOutcome.lost => RoomTone.bad,
    _ => RoomTone.neutral,
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
