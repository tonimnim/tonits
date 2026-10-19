import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_chat.freezed.dart';
part 'match_chat.g.dart';

/// A match's chat as one read returns it (`MatchChat`): where it stands,
/// and the messages after the seq asked for, oldest first.
@freezed
abstract class MatchChat with _$MatchChat {
  const factory MatchChat({
    required String matchId,

    /// False once the match is final: the chat is then read-only.
    required bool open,
    ChatRoomCode? roomCode,

    /// The kick-off both players agreed. It moves no deadline.
    DateTime? agreedStartAt,

    /// The match's result deadline; a proposed time must be before it.
    DateTime? playBy,
    @Default(0) int lastSeq,
    @Default(0) int readSeq,

    /// How far the opponent has read, for "Seen".
    @Default(0) int opponentReadSeq,
    @Default(<ChatMessage>[]) List<ChatMessage> messages,
    @Default(false) bool hasMore,
  }) = _MatchChat;

  factory MatchChat.fromJson(Map<String, dynamic> json) =>
      _$MatchChatFromJson(json);
}

/// The Friend Match room code a player pinned.
@freezed
abstract class ChatRoomCode with _$ChatRoomCode {
  const factory ChatRoomCode({
    required String code,

    /// `home` or `away`.
    required String setBy,
  }) = _ChatRoomCode;

  factory ChatRoomCode.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomCodeFromJson(json);
}

/// One message (`MatchChatMessage`). The field of its [kind] is set; the
/// others are null.
@freezed
abstract class ChatMessage with _$ChatMessage {
  const ChatMessage._();

  const factory ChatMessage({
    /// Gapless within the chat, so polling after the last one skips none.
    required int seq,
    required bool mine,
    @JsonKey(unknownEnumValue: ChatKind.unknown) required ChatKind kind,
    String? text,
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    QuickReply? quickReply,
    String? roomCode,
    DateTime? proposedStartAt,

    /// The proposal a time answer answers.
    int? replyToSeq,
    bool? accepted,

    /// Emails, links or phone numbers in the text became "[hidden]".
    @Default(false) bool contactHidden,
    required DateTime sentAt,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}

@JsonEnum(fieldRename: FieldRename.snake)
enum ChatKind { text, quickReply, roomCode, timeProposal, timeAnswer, unknown }

/// A canned reply, stored as a code; the app words it.
@JsonEnum(fieldRename: FieldRename.snake)
enum QuickReply {
  readyNow,
  fiveMinutes,
  tenMinutes,
  friendRequestSent,
  roomCreated,
  goodGame;

  String get wire => switch (this) {
    readyNow => 'ready_now',
    fiveMinutes => 'five_minutes',
    tenMinutes => 'ten_minutes',
    friendRequestSent => 'friend_request_sent',
    roomCreated => 'room_created',
    goodGame => 'good_game',
  };
}

/// Why a player reports a message.
enum ChatReportReason { abuse, harassment, cheating, spam, other }

/// Something the player is sending, before the server numbers it.
sealed class ChatDraft {
  const ChatDraft();

  ChatKind get kind;

  /// The request body's fields for this kind, without the client id.
  Map<String, Object> get fields;
}

class TextDraft extends ChatDraft {
  const TextDraft(this.text);

  final String text;

  @override
  ChatKind get kind => ChatKind.text;

  @override
  Map<String, Object> get fields => {'kind': 'text', 'text': text};
}

class QuickReplyDraft extends ChatDraft {
  const QuickReplyDraft(this.reply);

  final QuickReply reply;

  @override
  ChatKind get kind => ChatKind.quickReply;

  @override
  Map<String, Object> get fields => {
    'kind': 'quick_reply',
    'quickReply': reply.wire,
  };
}

class RoomCodeDraft extends ChatDraft {
  const RoomCodeDraft(this.code);

  final String code;

  @override
  ChatKind get kind => ChatKind.roomCode;

  @override
  Map<String, Object> get fields => {'kind': 'room_code', 'roomCode': code};
}

class TimeProposalDraft extends ChatDraft {
  const TimeProposalDraft(this.startAt);

  final DateTime startAt;

  @override
  ChatKind get kind => ChatKind.timeProposal;

  /// Rounded down to the minute, as the API keeps it.
  @override
  Map<String, Object> get fields {
    final at = startAt.toUtc();
    final minute = DateTime.utc(at.year, at.month, at.day, at.hour, at.minute);
    return {
      'kind': 'time_proposal',
      'proposedStartAt': minute.toIso8601String(),
    };
  }
}

class TimeAnswerDraft extends ChatDraft {
  const TimeAnswerDraft({required this.proposalSeq, required this.accepted});

  final int proposalSeq;
  final bool accepted;

  @override
  ChatKind get kind => ChatKind.timeAnswer;

  @override
  Map<String, Object> get fields => {
    'kind': 'time_answer',
    'replyToSeq': proposalSeq,
    'accepted': accepted,
  };
}
