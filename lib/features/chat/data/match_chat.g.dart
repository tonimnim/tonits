// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchChat _$MatchChatFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_MatchChat',
  json,
  ($checkedConvert) {
    final val = _MatchChat(
      matchId: $checkedConvert('matchId', (v) => v as String),
      open: $checkedConvert('open', (v) => v as bool),
      roomCode: $checkedConvert(
        'roomCode',
        (v) =>
            v == null ? null : ChatRoomCode.fromJson(v as Map<String, dynamic>),
      ),
      agreedStartAt: $checkedConvert(
        'agreedStartAt',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      playBy: $checkedConvert(
        'playBy',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      lastSeq: $checkedConvert('lastSeq', (v) => (v as num?)?.toInt() ?? 0),
      readSeq: $checkedConvert('readSeq', (v) => (v as num?)?.toInt() ?? 0),
      opponentReadSeq: $checkedConvert(
        'opponentReadSeq',
        (v) => (v as num?)?.toInt() ?? 0,
      ),
      messages: $checkedConvert(
        'messages',
        (v) =>
            (v as List<dynamic>?)
                ?.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const <ChatMessage>[],
      ),
      hasMore: $checkedConvert('hasMore', (v) => v as bool? ?? false),
    );
    return val;
  },
);

_ChatRoomCode _$ChatRoomCodeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ChatRoomCode', json, ($checkedConvert) {
      final val = _ChatRoomCode(
        code: $checkedConvert('code', (v) => v as String),
        setBy: $checkedConvert('setBy', (v) => v as String),
      );
      return val;
    });

_ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ChatMessage', json, ($checkedConvert) {
      final val = _ChatMessage(
        seq: $checkedConvert('seq', (v) => (v as num).toInt()),
        mine: $checkedConvert('mine', (v) => v as bool),
        kind: $checkedConvert(
          'kind',
          (v) =>
              $enumDecode(_$ChatKindEnumMap, v, unknownValue: ChatKind.unknown),
        ),
        text: $checkedConvert('text', (v) => v as String?),
        quickReply: $checkedConvert(
          'quickReply',
          (v) => $enumDecodeNullable(
            _$QuickReplyEnumMap,
            v,
            unknownValue: JsonKey.nullForUndefinedEnumValue,
          ),
        ),
        roomCode: $checkedConvert('roomCode', (v) => v as String?),
        proposedStartAt: $checkedConvert(
          'proposedStartAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        replyToSeq: $checkedConvert('replyToSeq', (v) => (v as num?)?.toInt()),
        accepted: $checkedConvert('accepted', (v) => v as bool?),
        contactHidden: $checkedConvert(
          'contactHidden',
          (v) => v as bool? ?? false,
        ),
        sentAt: $checkedConvert('sentAt', (v) => DateTime.parse(v as String)),
      );
      return val;
    });

const _$ChatKindEnumMap = {
  ChatKind.text: 'text',
  ChatKind.quickReply: 'quick_reply',
  ChatKind.roomCode: 'room_code',
  ChatKind.timeProposal: 'time_proposal',
  ChatKind.timeAnswer: 'time_answer',
  ChatKind.unknown: 'unknown',
};

const _$QuickReplyEnumMap = {
  QuickReply.readyNow: 'ready_now',
  QuickReply.fiveMinutes: 'five_minutes',
  QuickReply.tenMinutes: 'ten_minutes',
  QuickReply.friendRequestSent: 'friend_request_sent',
  QuickReply.roomCreated: 'room_created',
  QuickReply.goodGame: 'good_game',
};
