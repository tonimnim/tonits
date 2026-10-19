import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_summary.freezed.dart';
part 'match_summary.g.dart';

/// One of the player's match assignments (`MatchSummary` in the OpenAPI
/// contract). The server decides what the player can do next: drive the UI
/// from [lifecycle] and [allowedActions], never from guesses.
@freezed
abstract class MatchSummary with _$MatchSummary {
  const MatchSummary._();

  const factory MatchSummary({
    required String id,
    @Default('') String competitionId,
    required String competitionName,
    required String roundName,
    DateTime? scheduledAt,
    DateTime? checkInClosesAt,
    @JsonKey(unknownEnumValue: MatchLifecycle.unknown)
    required MatchLifecycle lifecycle,
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    MatchOutcome? outcome,

    /// `home` or `away`: which side the signed-in player is on.
    required String currentPlayerSide,
    MatchParticipant? home,
    MatchParticipant? away,
    @Default(<String>{}) Set<String> allowedActions,

    /// 1, 3 or 5 games.
    @Default(1) int bestOf,

    /// The match's chat, once both sides are known.
    ChatSummary? chat,
  }) = _MatchSummary;

  factory MatchSummary.fromJson(Map<String, dynamic> json) =>
      _$MatchSummaryFromJson(json);

  /// Null until the other slot is filled (for example, by a previous round).
  MatchParticipant? get opponent => isHome ? away : home;

  MatchParticipant? get me => isHome ? home : away;

  bool get isHome => currentPlayerSide == 'home';

  /// "Nairobi Weekend Cup · Round of 32", with "· Best of 3" for a series.
  String place(String Function(int bestOf) bestOfLabel) => [
    competitionName,
    roundName,
    if (bestOf > 1) bestOfLabel(bestOf),
  ].join(' · ');
}

/// A match's chat as the room and the list show it (`MatchChatSummary`).
@freezed
abstract class ChatSummary with _$ChatSummary {
  const factory ChatSummary({
    /// Players can post while both sides are known and the match isn't
    /// final.
    @Default(false) bool open,

    /// The opponent's messages the player hasn't read.
    @Default(0) int unread,

    /// The Friend Match room code a player pinned.
    String? roomCode,

    /// The kick-off both players agreed. It moves no deadline.
    DateTime? agreedStartAt,
  }) = _ChatSummary;

  factory ChatSummary.fromJson(Map<String, dynamic> json) =>
      _$ChatSummaryFromJson(json);
}

@freezed
abstract class MatchParticipant with _$MatchParticipant {
  const MatchParticipant._();

  const factory MatchParticipant({
    required String displayName,
    required String handle,
    String? playerId,
    DateTime? checkedInAt,

    /// The eFootball account this side plays with, for finding each other in
    /// the game. Only the match's two players receive it.
    MatchGameAccount? gameAccount,
  }) = _MatchParticipant;

  factory MatchParticipant.fromJson(Map<String, dynamic> json) =>
      _$MatchParticipantFromJson(json);

  bool get checkedIn => checkedInAt != null;
}

@freezed
abstract class MatchGameAccount with _$MatchGameAccount {
  const factory MatchGameAccount({
    /// The name shown in eFootball.
    required String inGameName,

    /// `android` or `ios`.
    required String platform,

    /// The eFootball User ID players add each other by; null when not added.
    @JsonKey(name: 'publisherPlayerId') String? userId,
  }) = _MatchGameAccount;

  factory MatchGameAccount.fromJson(Map<String, dynamic> json) =>
      _$MatchGameAccountFromJson(json);
}

/// Where the match stands for this player, as the server derives it.
@JsonEnum(fieldRename: FieldRename.snake)
enum MatchLifecycle {
  assigned,
  readyForCheckIn,
  checkedIn,
  reportRequired,
  awaitingOpponentConfirmation,
  confirmationRequired,
  screenshotRequired,
  awaitingOpponentScreenshot,
  awaitingResolution,
  underReview,
  forfeited,
  completed,
  cancelled,
  outOfCompetition,
  unknown;

  bool get isOver =>
      this == completed || this == forfeited || this == cancelled;
}

@JsonEnum(fieldRename: FieldRename.snake)
enum MatchOutcome { won, lost, drawn, noResult }
