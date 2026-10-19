import 'package:freezed_annotation/freezed_annotation.dart';

import 'match_summary.dart';

part 'match_room.freezed.dart';
part 'match_room.g.dart';

/// The signed-in player's view of one match (`MatchRoom` in the OpenAPI
/// contract): the summary, plus the result being settled and its deadlines.
@freezed
abstract class MatchRoom with _$MatchRoom {
  const MatchRoom._();

  const factory MatchRoom({
    /// The summary fields, read from the same object.
    @JsonKey(readValue: _whole) required MatchSummary summary,

    /// A short reference, such as "M-1042", for support.
    @Default('') String code,

    /// 1, 3 or 5 games; one point per game won.
    @Default(1) int bestOf,

    /// Games a side needs to win; the series stops there.
    @JsonKey(name: 'gamesToWin') int? gamesToWinValue,

    /// Round-robin matches may end level; knockouts need penalties.
    @Default(false) bool drawAllowed,
    DateTime? checkInOpensAt,

    /// When a result must be in; with none by then, both entries are removed.
    DateTime? resultDueAt,

    /// Why a finished match ended (`played`, `walkover`, ...).
    String? completionReason,
    @JsonKey(name: 'friendMatchInstructions')
    @Default(<FriendMatchInstruction>[])
    List<FriendMatchInstruction> instructions,
    @JsonKey(name: 'resultVerification')
    required ResultVerification verification,

    /// The final score, once the match is completed.
    ConfirmedResult? result,
    @JsonKey(name: 'verificationPolicy')
    @Default(VerificationWindows())
    VerificationWindows windows,
  }) = _MatchRoom;

  factory MatchRoom.fromJson(Map<String, dynamic> json) =>
      _$MatchRoomFromJson(json);

  String get id => summary.id;

  /// Games a side needs: 1, 2 or 3.
  int get gamesToWin => gamesToWinValue ?? bestOf ~/ 2 + 1;

  /// A best of 3 or 5: played and reported game by game.
  bool get isSeries => bestOf > 1;
  MatchLifecycle get lifecycle => summary.lifecycle;
  bool can(MatchAction action) => summary.allowedActions.contains(action.wire);
}

/// Reads the whole object, for a field built from its parent's keys.
Object? _whole(Map<dynamic, dynamic> json, String _) => json;

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

@freezed
abstract class FriendMatchInstruction with _$FriendMatchInstruction {
  const factory FriendMatchInstruction({
    required String title,
    required String detail,
  }) = _FriendMatchInstruction;

  factory FriendMatchInstruction.fromJson(Map<String, dynamic> json) =>
      _$FriendMatchInstructionFromJson(json);
}

@JsonEnum(fieldRename: FieldRename.snake)
enum VerificationPhase {
  notStarted,
  awaitingConfirmation,
  awaitingScreenshots,
  inReview,
  resolved,
}

/// The result being settled, as this player sees it. Neither player ever
/// sees the other's screenshot.
@freezed
abstract class ResultVerification with _$ResultVerification {
  const factory ResultVerification({
    @JsonKey(unknownEnumValue: VerificationPhase.notStarted)
    @Default(VerificationPhase.notStarted)
    VerificationPhase phase,
    @JsonKey(name: 'submittedResult') SubmittedResult? submitted,
    @JsonKey(name: 'myScreenshot', readValue: _present)
    @Default(false)
    bool myScreenshotSent,

    /// The screenshots this player sent, in game order.
    @Default(<ResultScreenshot>[]) List<ResultScreenshot> myScreenshots,
    @JsonKey(name: 'opponentScreenshotSubmitted')
    @Default(false)
    bool opponentScreenshotSent,
    DateTime? confirmationDeadline,
    DateTime? screenshotDeadline,

    /// `agreed`, `confirmation_timeout`, `response_timeout`, ...
    String? resolution,

    /// True only on the match that removed this player's entry.
    @Default(false) bool entryRemoved,
  }) = _ResultVerification;

  factory ResultVerification.fromJson(Map<String, dynamic> json) =>
      _$ResultVerificationFromJson(json);
}

/// One of this player's screenshots after a rejection.
@freezed
abstract class ResultScreenshot with _$ResultScreenshot {
  const factory ResultScreenshot({
    /// The game it shows; 1 for a best of 1.
    @Default(1) int game,
    required String evidenceId,
  }) = _ResultScreenshot;

  factory ResultScreenshot.fromJson(Map<String, dynamic> json) =>
      _$ResultScreenshotFromJson(json);
}

/// Whether the key holds a value.
Object? _present(Map<dynamic, dynamic> json, String key) => json[key] != null;

/// A home–away score with an optional penalty shootout: a match's total, or
/// one game of a series (`GameScore`), whose penalties decide a level
/// knockout game.
@freezed
abstract class Score with _$Score {
  const Score._();

  const factory Score(
    @JsonKey(name: 'homeScore') int home,
    @JsonKey(name: 'awayScore') int away, {
    @JsonKey(name: 'tiebreak') Score? penalties,
  }) = _Score;

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);

  /// The score from one side's point of view: (mine, theirs).
  (int, int) forSide({required bool home}) =>
      home ? (this.home, away) : (away, this.home);
}

@freezed
abstract class SubmittedResult with _$SubmittedResult {
  const factory SubmittedResult({
    @JsonKey(readValue: _whole) required Score score,

    /// Every game of a series, in order; empty for a best of 1.
    @Default(<Score>[]) List<Score> games,
    @JsonKey(name: 'submittedByMe') required bool byMe,
    @JsonKey(name: 'submittedAt') required DateTime at,
  }) = _SubmittedResult;

  factory SubmittedResult.fromJson(Map<String, dynamic> json) =>
      _$SubmittedResultFromJson(json);
}

@freezed
abstract class ConfirmedResult with _$ConfirmedResult {
  const factory ConfirmedResult({
    @JsonKey(readValue: _whole) required Score score,

    /// Every game of a series, in order; empty for a best of 1.
    @Default(<Score>[]) List<Score> games,

    /// `agreed_reports`, `unanswered`, `platform_review` or `legacy`.
    required String origin,
  }) = _ConfirmedResult;

  factory ConfirmedResult.fromJson(Map<String, dynamic> json) =>
      _$ConfirmedResultFromJson(json);
}

/// How long each step of settling a result lasts.
@freezed
abstract class VerificationWindows with _$VerificationWindows {
  const factory VerificationWindows({
    /// The opponent's time to confirm or reject a submitted result.
    @JsonKey(name: 'reportWindowSeconds', fromJson: _seconds)
    @Default(Duration(minutes: 10))
    Duration confirm,

    /// Each side's time to send its screenshots after a rejection.
    @JsonKey(name: 'responseWindowSeconds', fromJson: _seconds)
    @Default(Duration(minutes: 10))
    Duration screenshot,

    /// A series' dispute takes one screenshot per game, numbered by game.
    @JsonKey(name: 'screenshotEvidence', readValue: _perGame)
    @Default(false)
    bool perGameScreenshots,
  }) = _VerificationWindows;

  factory VerificationWindows.fromJson(Map<String, dynamic> json) =>
      _$VerificationWindowsFromJson(json);
}

Duration _seconds(int value) => Duration(seconds: value);

Object? _perGame(Map<dynamic, dynamic> json, String key) =>
    (json[key] as Map?)?['perGame'];
