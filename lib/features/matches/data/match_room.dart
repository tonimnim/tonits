import 'match_summary.dart';

/// The signed-in player's view of one match (`MatchRoom` in the OpenAPI
/// contract): the summary, plus the result being settled and its deadlines.
class MatchRoom {
  const MatchRoom({
    required this.summary,
    required this.code,
    required this.bestOf,
    required this.drawAllowed,
    required this.checkInOpensAt,
    required this.resultDueAt,
    required this.completionReason,
    required this.instructions,
    required this.verification,
    required this.result,
    required this.windows,
  });

  factory MatchRoom.fromJson(Map<String, dynamic> json) => MatchRoom(
    summary: MatchSummary.fromJson(json),
    code: json['code'] as String? ?? '',
    bestOf: json['bestOf'] as int? ?? 1,
    drawAllowed: json['drawAllowed'] as bool? ?? false,
    checkInOpensAt: _date(json['checkInOpensAt']),
    resultDueAt: _date(json['resultDueAt']),
    completionReason: json['completionReason'] as String?,
    instructions: [
      for (final i in (json['friendMatchInstructions'] as List? ?? const []))
        FriendMatchInstruction.fromJson(i as Map<String, dynamic>),
    ],
    verification: ResultVerification.fromJson(
      json['resultVerification'] as Map<String, dynamic>,
    ),
    result: json['result'] is Map<String, dynamic>
        ? ConfirmedResult.fromJson(json['result'] as Map<String, dynamic>)
        : null,
    windows: VerificationWindows.fromJson(
      json['verificationPolicy'] as Map<String, dynamic>? ?? const {},
    ),
  );

  final MatchSummary summary;

  /// A short reference, such as "M-1042", for support.
  final String code;
  final int bestOf;

  /// Round-robin matches may end level; knockouts need penalties.
  final bool drawAllowed;
  final DateTime? checkInOpensAt;

  /// When a result must be in; with none by then, both entries are removed.
  final DateTime? resultDueAt;

  /// Why a finished match ended (`played`, `walkover`, ...).
  final String? completionReason;
  final List<FriendMatchInstruction> instructions;
  final ResultVerification verification;

  /// The final score, once the match is completed.
  final ConfirmedResult? result;
  final VerificationWindows windows;

  String get id => summary.id;
  MatchLifecycle get lifecycle => summary.lifecycle;
  bool can(MatchAction action) => summary.allowedActions.contains(action.wire);

  static DateTime? _date(Object? value) =>
      value is String ? DateTime.parse(value) : null;
}

/// What the server lets the player do now, by its wire name.
enum MatchAction {
  checkIn('check_in'),
  reportScore('report_score'),
  confirmResult('confirm_result'),
  rejectResult('reject_result'),
  submitScreenshot('submit_screenshot');

  const MatchAction(this.wire);

  final String wire;
}

class FriendMatchInstruction {
  const FriendMatchInstruction({required this.title, required this.detail});

  factory FriendMatchInstruction.fromJson(Map<String, dynamic> json) =>
      FriendMatchInstruction(
        title: json['title'] as String,
        detail: json['detail'] as String,
      );

  final String title;
  final String detail;
}

enum VerificationPhase {
  notStarted,
  awaitingConfirmation,
  awaitingScreenshots,
  inReview,
  resolved;

  static VerificationPhase parse(String? value) => switch (value) {
    'awaiting_confirmation' => awaitingConfirmation,
    'awaiting_screenshots' => awaitingScreenshots,
    'in_review' => inReview,
    'resolved' => resolved,
    _ => notStarted,
  };
}

/// The result being settled, as this player sees it. Neither player ever
/// sees the other's screenshot.
class ResultVerification {
  const ResultVerification({
    required this.phase,
    required this.submitted,
    required this.myScreenshotSent,
    required this.opponentScreenshotSent,
    required this.confirmationDeadline,
    required this.screenshotDeadline,
    required this.resolution,
    required this.entryRemoved,
  });

  factory ResultVerification.fromJson(Map<String, dynamic> json) =>
      ResultVerification(
        phase: VerificationPhase.parse(json['phase'] as String?),
        submitted: json['submittedResult'] is Map<String, dynamic>
            ? SubmittedResult.fromJson(
                json['submittedResult'] as Map<String, dynamic>,
              )
            : null,
        myScreenshotSent: json['myScreenshot'] != null,
        opponentScreenshotSent:
            json['opponentScreenshotSubmitted'] as bool? ?? false,
        confirmationDeadline: MatchRoom._date(json['confirmationDeadline']),
        screenshotDeadline: MatchRoom._date(json['screenshotDeadline']),
        resolution: json['resolution'] as String?,
        entryRemoved: json['entryRemoved'] as bool? ?? false,
      );

  final VerificationPhase phase;
  final SubmittedResult? submitted;
  final bool myScreenshotSent;
  final bool opponentScreenshotSent;
  final DateTime? confirmationDeadline;
  final DateTime? screenshotDeadline;

  /// `agreed`, `confirmation_timeout`, `response_timeout`, ...
  final String? resolution;

  /// True only on the match that removed this player's entry.
  final bool entryRemoved;
}

/// A home–away score with an optional penalty shootout.
class Score {
  const Score(this.home, this.away, {this.penalties});

  static Score fromJson(Map<String, dynamic> json) => Score(
    json['homeScore'] as int,
    json['awayScore'] as int,
    penalties: json['tiebreak'] is Map<String, dynamic>
        ? Score.fromJson(json['tiebreak'] as Map<String, dynamic>)
        : null,
  );

  final int home;
  final int away;
  final Score? penalties;

  /// The score from one side's point of view: (mine, theirs).
  (int, int) forSide({required bool home}) =>
      home ? (this.home, away) : (away, this.home);
}

class SubmittedResult {
  const SubmittedResult({
    required this.score,
    required this.byMe,
    required this.at,
  });

  factory SubmittedResult.fromJson(Map<String, dynamic> json) =>
      SubmittedResult(
        score: Score.fromJson(json),
        byMe: json['submittedByMe'] as bool,
        at: DateTime.parse(json['submittedAt'] as String),
      );

  final Score score;
  final bool byMe;
  final DateTime at;
}

class ConfirmedResult {
  const ConfirmedResult({required this.score, required this.origin});

  factory ConfirmedResult.fromJson(Map<String, dynamic> json) =>
      ConfirmedResult(
        score: Score.fromJson(json),
        origin: json['origin'] as String,
      );

  final Score score;

  /// `agreed_reports`, `unanswered`, `platform_review` or `legacy`.
  final String origin;
}

/// How long each step of settling a result lasts.
class VerificationWindows {
  const VerificationWindows({required this.confirm, required this.screenshot});

  factory VerificationWindows.fromJson(Map<String, dynamic> json) =>
      VerificationWindows(
        confirm: Duration(seconds: json['reportWindowSeconds'] as int? ?? 600),
        screenshot: Duration(
          seconds: json['responseWindowSeconds'] as int? ?? 600,
        ),
      );

  /// The opponent's time to confirm or reject a submitted result.
  final Duration confirm;

  /// Each side's time to send a screenshot after a rejection.
  final Duration screenshot;
}
