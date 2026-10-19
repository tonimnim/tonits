// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchChat {

 String get matchId;/// False once the match is final: the chat is then read-only.
 bool get open; ChatRoomCode? get roomCode;/// The kick-off both players agreed. It moves no deadline.
 DateTime? get agreedStartAt;/// The match's result deadline; a proposed time must be before it.
 DateTime? get playBy; int get lastSeq; int get readSeq;/// How far the opponent has read, for "Seen".
 int get opponentReadSeq; List<ChatMessage> get messages; bool get hasMore;
/// Create a copy of MatchChat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchChatCopyWith<MatchChat> get copyWith => _$MatchChatCopyWithImpl<MatchChat>(this as MatchChat, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MatchChat;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchChat&&(identical(other.matchId, _this.matchId) || other.matchId == _this.matchId)&&(identical(other.open, _this.open) || other.open == _this.open)&&(identical(other.roomCode, _this.roomCode) || other.roomCode == _this.roomCode)&&(identical(other.agreedStartAt, _this.agreedStartAt) || other.agreedStartAt == _this.agreedStartAt)&&(identical(other.playBy, _this.playBy) || other.playBy == _this.playBy)&&(identical(other.lastSeq, _this.lastSeq) || other.lastSeq == _this.lastSeq)&&(identical(other.readSeq, _this.readSeq) || other.readSeq == _this.readSeq)&&(identical(other.opponentReadSeq, _this.opponentReadSeq) || other.opponentReadSeq == _this.opponentReadSeq)&&const DeepCollectionEquality().equals(other.messages, _this.messages)&&(identical(other.hasMore, _this.hasMore) || other.hasMore == _this.hasMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MatchChat;
  return Object.hash(runtimeType,_this.matchId,_this.open,_this.roomCode,_this.agreedStartAt,_this.playBy,_this.lastSeq,_this.readSeq,_this.opponentReadSeq,const DeepCollectionEquality().hash(_this.messages),_this.hasMore);
}

@override
String toString() {
  final _this = this as MatchChat;
  return 'MatchChat(matchId: ${_this.matchId}, open: ${_this.open}, roomCode: ${_this.roomCode}, agreedStartAt: ${_this.agreedStartAt}, playBy: ${_this.playBy}, lastSeq: ${_this.lastSeq}, readSeq: ${_this.readSeq}, opponentReadSeq: ${_this.opponentReadSeq}, messages: ${_this.messages}, hasMore: ${_this.hasMore})';
}


}

/// @nodoc
abstract mixin class $MatchChatCopyWith<$Res>  {
  factory $MatchChatCopyWith(MatchChat value, $Res Function(MatchChat) _then) = _$MatchChatCopyWithImpl;
@useResult
$Res call({
 String matchId, bool open, ChatRoomCode? roomCode, DateTime? agreedStartAt, DateTime? playBy, int lastSeq, int readSeq, int opponentReadSeq, List<ChatMessage> messages, bool hasMore
});


$ChatRoomCodeCopyWith<$Res>? get roomCode;

}
/// @nodoc
class _$MatchChatCopyWithImpl<$Res>
    implements $MatchChatCopyWith<$Res> {
  _$MatchChatCopyWithImpl(this._self, this._then);

  final MatchChat _self;
  final $Res Function(MatchChat) _then;

/// Create a copy of MatchChat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? matchId = null,Object? open = null,Object? roomCode = freezed,Object? agreedStartAt = freezed,Object? playBy = freezed,Object? lastSeq = null,Object? readSeq = null,Object? opponentReadSeq = null,Object? messages = null,Object? hasMore = null,}) {
  return _then(MatchChat(
matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String,open: null == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as bool,roomCode: freezed == roomCode ? _self.roomCode : roomCode // ignore: cast_nullable_to_non_nullable
as ChatRoomCode?,agreedStartAt: freezed == agreedStartAt ? _self.agreedStartAt : agreedStartAt // ignore: cast_nullable_to_non_nullable
as DateTime?,playBy: freezed == playBy ? _self.playBy : playBy // ignore: cast_nullable_to_non_nullable
as DateTime?,lastSeq: null == lastSeq ? _self.lastSeq : lastSeq // ignore: cast_nullable_to_non_nullable
as int,readSeq: null == readSeq ? _self.readSeq : readSeq // ignore: cast_nullable_to_non_nullable
as int,opponentReadSeq: null == opponentReadSeq ? _self.opponentReadSeq : opponentReadSeq // ignore: cast_nullable_to_non_nullable
as int,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of MatchChat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatRoomCodeCopyWith<$Res>? get roomCode {
    if (_self.roomCode == null) {
    return null;
  }

  return $ChatRoomCodeCopyWith<$Res>(_self.roomCode!, (value) {
    return _then(_self.copyWith(roomCode: value));
  });
}
}


/// Adds pattern-matching-related methods to [MatchChat].
extension MatchChatPatterns on MatchChat {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchChat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchChat() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchChat value)  $default,){
final _that = this;
switch (_that) {
case _MatchChat():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchChat value)?  $default,){
final _that = this;
switch (_that) {
case _MatchChat() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String matchId,  bool open,  ChatRoomCode? roomCode,  DateTime? agreedStartAt,  DateTime? playBy,  int lastSeq,  int readSeq,  int opponentReadSeq,  List<ChatMessage> messages,  bool hasMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchChat() when $default != null:
return $default(_that.matchId,_that.open,_that.roomCode,_that.agreedStartAt,_that.playBy,_that.lastSeq,_that.readSeq,_that.opponentReadSeq,_that.messages,_that.hasMore);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String matchId,  bool open,  ChatRoomCode? roomCode,  DateTime? agreedStartAt,  DateTime? playBy,  int lastSeq,  int readSeq,  int opponentReadSeq,  List<ChatMessage> messages,  bool hasMore)  $default,) {final _that = this;
switch (_that) {
case _MatchChat():
return $default(_that.matchId,_that.open,_that.roomCode,_that.agreedStartAt,_that.playBy,_that.lastSeq,_that.readSeq,_that.opponentReadSeq,_that.messages,_that.hasMore);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String matchId,  bool open,  ChatRoomCode? roomCode,  DateTime? agreedStartAt,  DateTime? playBy,  int lastSeq,  int readSeq,  int opponentReadSeq,  List<ChatMessage> messages,  bool hasMore)?  $default,) {final _that = this;
switch (_that) {
case _MatchChat() when $default != null:
return $default(_that.matchId,_that.open,_that.roomCode,_that.agreedStartAt,_that.playBy,_that.lastSeq,_that.readSeq,_that.opponentReadSeq,_that.messages,_that.hasMore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _MatchChat implements MatchChat {
  const _MatchChat({required this.matchId, required this.open, this.roomCode, this.agreedStartAt, this.playBy, this.lastSeq = 0, this.readSeq = 0, this.opponentReadSeq = 0,  List<ChatMessage> messages = const <ChatMessage>[], this.hasMore = false}): _messages = messages;
  factory _MatchChat.fromJson(Map<String, dynamic> json) => _$MatchChatFromJson(json);

@override final  String matchId;
/// False once the match is final: the chat is then read-only.
@override final  bool open;
@override final  ChatRoomCode? roomCode;
/// The kick-off both players agreed. It moves no deadline.
@override final  DateTime? agreedStartAt;
/// The match's result deadline; a proposed time must be before it.
@override final  DateTime? playBy;
@override@JsonKey() final  int lastSeq;
@override@JsonKey() final  int readSeq;
/// How far the opponent has read, for "Seen".
@override@JsonKey() final  int opponentReadSeq;
 final  List<ChatMessage> _messages;
@override@JsonKey() List<ChatMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@JsonKey() final  bool hasMore;

/// Create a copy of MatchChat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchChatCopyWith<_MatchChat> get copyWith => __$MatchChatCopyWithImpl<_MatchChat>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchChat&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.open, open) || other.open == open)&&(identical(other.roomCode, roomCode) || other.roomCode == roomCode)&&(identical(other.agreedStartAt, agreedStartAt) || other.agreedStartAt == agreedStartAt)&&(identical(other.playBy, playBy) || other.playBy == playBy)&&(identical(other.lastSeq, lastSeq) || other.lastSeq == lastSeq)&&(identical(other.readSeq, readSeq) || other.readSeq == readSeq)&&(identical(other.opponentReadSeq, opponentReadSeq) || other.opponentReadSeq == opponentReadSeq)&&const DeepCollectionEquality().equals(other.messages, _messages)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,matchId,open,roomCode,agreedStartAt,playBy,lastSeq,readSeq,opponentReadSeq,const DeepCollectionEquality().hash(_messages),hasMore);
}

@override
String toString() {
    return 'MatchChat(matchId: $matchId, open: $open, roomCode: $roomCode, agreedStartAt: $agreedStartAt, playBy: $playBy, lastSeq: $lastSeq, readSeq: $readSeq, opponentReadSeq: $opponentReadSeq, messages: $messages, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class _$MatchChatCopyWith<$Res> implements $MatchChatCopyWith<$Res> {
  factory _$MatchChatCopyWith(_MatchChat value, $Res Function(_MatchChat) _then) = __$MatchChatCopyWithImpl;
@override @useResult
$Res call({
 String matchId, bool open, ChatRoomCode? roomCode, DateTime? agreedStartAt, DateTime? playBy, int lastSeq, int readSeq, int opponentReadSeq, List<ChatMessage> messages, bool hasMore
});


@override $ChatRoomCodeCopyWith<$Res>? get roomCode;

}
/// @nodoc
class __$MatchChatCopyWithImpl<$Res>
    implements _$MatchChatCopyWith<$Res> {
  __$MatchChatCopyWithImpl(this._self, this._then);

  final _MatchChat _self;
  final $Res Function(_MatchChat) _then;

/// Create a copy of MatchChat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? matchId = null,Object? open = null,Object? roomCode = freezed,Object? agreedStartAt = freezed,Object? playBy = freezed,Object? lastSeq = null,Object? readSeq = null,Object? opponentReadSeq = null,Object? messages = null,Object? hasMore = null,}) {
  return _then(_MatchChat(
matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String,open: null == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as bool,roomCode: freezed == roomCode ? _self.roomCode : roomCode // ignore: cast_nullable_to_non_nullable
as ChatRoomCode?,agreedStartAt: freezed == agreedStartAt ? _self.agreedStartAt : agreedStartAt // ignore: cast_nullable_to_non_nullable
as DateTime?,playBy: freezed == playBy ? _self.playBy : playBy // ignore: cast_nullable_to_non_nullable
as DateTime?,lastSeq: null == lastSeq ? _self.lastSeq : lastSeq // ignore: cast_nullable_to_non_nullable
as int,readSeq: null == readSeq ? _self.readSeq : readSeq // ignore: cast_nullable_to_non_nullable
as int,opponentReadSeq: null == opponentReadSeq ? _self.opponentReadSeq : opponentReadSeq // ignore: cast_nullable_to_non_nullable
as int,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of MatchChat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatRoomCodeCopyWith<$Res>? get roomCode {
    if (_self.roomCode == null) {
    return null;
  }

  return $ChatRoomCodeCopyWith<$Res>(_self.roomCode!, (value) {
    return _then(_self.copyWith(roomCode: value));
  });
}
}


/// @nodoc
mixin _$ChatRoomCode {

 String get code;/// `home` or `away`.
 String get setBy;
/// Create a copy of ChatRoomCode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatRoomCodeCopyWith<ChatRoomCode> get copyWith => _$ChatRoomCodeCopyWithImpl<ChatRoomCode>(this as ChatRoomCode, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatRoomCode;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatRoomCode&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.setBy, _this.setBy) || other.setBy == _this.setBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatRoomCode;
  return Object.hash(runtimeType,_this.code,_this.setBy);
}

@override
String toString() {
  final _this = this as ChatRoomCode;
  return 'ChatRoomCode(code: ${_this.code}, setBy: ${_this.setBy})';
}


}

/// @nodoc
abstract mixin class $ChatRoomCodeCopyWith<$Res>  {
  factory $ChatRoomCodeCopyWith(ChatRoomCode value, $Res Function(ChatRoomCode) _then) = _$ChatRoomCodeCopyWithImpl;
@useResult
$Res call({
 String code, String setBy
});




}
/// @nodoc
class _$ChatRoomCodeCopyWithImpl<$Res>
    implements $ChatRoomCodeCopyWith<$Res> {
  _$ChatRoomCodeCopyWithImpl(this._self, this._then);

  final ChatRoomCode _self;
  final $Res Function(ChatRoomCode) _then;

/// Create a copy of ChatRoomCode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? setBy = null,}) {
  return _then(ChatRoomCode(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,setBy: null == setBy ? _self.setBy : setBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatRoomCode].
extension ChatRoomCodePatterns on ChatRoomCode {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatRoomCode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatRoomCode() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatRoomCode value)  $default,){
final _that = this;
switch (_that) {
case _ChatRoomCode():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatRoomCode value)?  $default,){
final _that = this;
switch (_that) {
case _ChatRoomCode() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String setBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatRoomCode() when $default != null:
return $default(_that.code,_that.setBy);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String setBy)  $default,) {final _that = this;
switch (_that) {
case _ChatRoomCode():
return $default(_that.code,_that.setBy);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String setBy)?  $default,) {final _that = this;
switch (_that) {
case _ChatRoomCode() when $default != null:
return $default(_that.code,_that.setBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _ChatRoomCode implements ChatRoomCode {
  const _ChatRoomCode({required this.code, required this.setBy});
  factory _ChatRoomCode.fromJson(Map<String, dynamic> json) => _$ChatRoomCodeFromJson(json);

@override final  String code;
/// `home` or `away`.
@override final  String setBy;

/// Create a copy of ChatRoomCode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatRoomCodeCopyWith<_ChatRoomCode> get copyWith => __$ChatRoomCodeCopyWithImpl<_ChatRoomCode>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatRoomCode&&(identical(other.code, code) || other.code == code)&&(identical(other.setBy, setBy) || other.setBy == setBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,setBy);
}

@override
String toString() {
    return 'ChatRoomCode(code: $code, setBy: $setBy)';
}


}

/// @nodoc
abstract mixin class _$ChatRoomCodeCopyWith<$Res> implements $ChatRoomCodeCopyWith<$Res> {
  factory _$ChatRoomCodeCopyWith(_ChatRoomCode value, $Res Function(_ChatRoomCode) _then) = __$ChatRoomCodeCopyWithImpl;
@override @useResult
$Res call({
 String code, String setBy
});




}
/// @nodoc
class __$ChatRoomCodeCopyWithImpl<$Res>
    implements _$ChatRoomCodeCopyWith<$Res> {
  __$ChatRoomCodeCopyWithImpl(this._self, this._then);

  final _ChatRoomCode _self;
  final $Res Function(_ChatRoomCode) _then;

/// Create a copy of ChatRoomCode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? setBy = null,}) {
  return _then(_ChatRoomCode(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,setBy: null == setBy ? _self.setBy : setBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ChatMessage {

/// Gapless within the chat, so polling after the last one skips none.
 int get seq; bool get mine;@JsonKey(unknownEnumValue: ChatKind.unknown) ChatKind get kind; String? get text;@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) QuickReply? get quickReply; String? get roomCode; DateTime? get proposedStartAt;/// The proposal a time answer answers.
 int? get replyToSeq; bool? get accepted;/// Emails, links or phone numbers in the text became "[hidden]".
 bool get contactHidden; DateTime get sentAt;
/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageCopyWith<ChatMessage> get copyWith => _$ChatMessageCopyWithImpl<ChatMessage>(this as ChatMessage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatMessage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessage&&(identical(other.seq, _this.seq) || other.seq == _this.seq)&&(identical(other.mine, _this.mine) || other.mine == _this.mine)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.quickReply, _this.quickReply) || other.quickReply == _this.quickReply)&&(identical(other.roomCode, _this.roomCode) || other.roomCode == _this.roomCode)&&(identical(other.proposedStartAt, _this.proposedStartAt) || other.proposedStartAt == _this.proposedStartAt)&&(identical(other.replyToSeq, _this.replyToSeq) || other.replyToSeq == _this.replyToSeq)&&(identical(other.accepted, _this.accepted) || other.accepted == _this.accepted)&&(identical(other.contactHidden, _this.contactHidden) || other.contactHidden == _this.contactHidden)&&(identical(other.sentAt, _this.sentAt) || other.sentAt == _this.sentAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatMessage;
  return Object.hash(runtimeType,_this.seq,_this.mine,_this.kind,_this.text,_this.quickReply,_this.roomCode,_this.proposedStartAt,_this.replyToSeq,_this.accepted,_this.contactHidden,_this.sentAt);
}

@override
String toString() {
  final _this = this as ChatMessage;
  return 'ChatMessage(seq: ${_this.seq}, mine: ${_this.mine}, kind: ${_this.kind}, text: ${_this.text}, quickReply: ${_this.quickReply}, roomCode: ${_this.roomCode}, proposedStartAt: ${_this.proposedStartAt}, replyToSeq: ${_this.replyToSeq}, accepted: ${_this.accepted}, contactHidden: ${_this.contactHidden}, sentAt: ${_this.sentAt})';
}


}

/// @nodoc
abstract mixin class $ChatMessageCopyWith<$Res>  {
  factory $ChatMessageCopyWith(ChatMessage value, $Res Function(ChatMessage) _then) = _$ChatMessageCopyWithImpl;
@useResult
$Res call({
 int seq, bool mine,@JsonKey(unknownEnumValue: ChatKind.unknown) ChatKind kind, String? text,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) QuickReply? quickReply, String? roomCode, DateTime? proposedStartAt, int? replyToSeq, bool? accepted, bool contactHidden, DateTime sentAt
});




}
/// @nodoc
class _$ChatMessageCopyWithImpl<$Res>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._self, this._then);

  final ChatMessage _self;
  final $Res Function(ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seq = null,Object? mine = null,Object? kind = null,Object? text = freezed,Object? quickReply = freezed,Object? roomCode = freezed,Object? proposedStartAt = freezed,Object? replyToSeq = freezed,Object? accepted = freezed,Object? contactHidden = null,Object? sentAt = null,}) {
  return _then(ChatMessage(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,mine: null == mine ? _self.mine : mine // ignore: cast_nullable_to_non_nullable
as bool,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ChatKind,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,quickReply: freezed == quickReply ? _self.quickReply : quickReply // ignore: cast_nullable_to_non_nullable
as QuickReply?,roomCode: freezed == roomCode ? _self.roomCode : roomCode // ignore: cast_nullable_to_non_nullable
as String?,proposedStartAt: freezed == proposedStartAt ? _self.proposedStartAt : proposedStartAt // ignore: cast_nullable_to_non_nullable
as DateTime?,replyToSeq: freezed == replyToSeq ? _self.replyToSeq : replyToSeq // ignore: cast_nullable_to_non_nullable
as int?,accepted: freezed == accepted ? _self.accepted : accepted // ignore: cast_nullable_to_non_nullable
as bool?,contactHidden: null == contactHidden ? _self.contactHidden : contactHidden // ignore: cast_nullable_to_non_nullable
as bool,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessage].
extension ChatMessagePatterns on ChatMessage {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessage value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessage():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int seq,  bool mine, @JsonKey(unknownEnumValue: ChatKind.unknown)  ChatKind kind,  String? text, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  QuickReply? quickReply,  String? roomCode,  DateTime? proposedStartAt,  int? replyToSeq,  bool? accepted,  bool contactHidden,  DateTime sentAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.seq,_that.mine,_that.kind,_that.text,_that.quickReply,_that.roomCode,_that.proposedStartAt,_that.replyToSeq,_that.accepted,_that.contactHidden,_that.sentAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int seq,  bool mine, @JsonKey(unknownEnumValue: ChatKind.unknown)  ChatKind kind,  String? text, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  QuickReply? quickReply,  String? roomCode,  DateTime? proposedStartAt,  int? replyToSeq,  bool? accepted,  bool contactHidden,  DateTime sentAt)  $default,) {final _that = this;
switch (_that) {
case _ChatMessage():
return $default(_that.seq,_that.mine,_that.kind,_that.text,_that.quickReply,_that.roomCode,_that.proposedStartAt,_that.replyToSeq,_that.accepted,_that.contactHidden,_that.sentAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int seq,  bool mine, @JsonKey(unknownEnumValue: ChatKind.unknown)  ChatKind kind,  String? text, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  QuickReply? quickReply,  String? roomCode,  DateTime? proposedStartAt,  int? replyToSeq,  bool? accepted,  bool contactHidden,  DateTime sentAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.seq,_that.mine,_that.kind,_that.text,_that.quickReply,_that.roomCode,_that.proposedStartAt,_that.replyToSeq,_that.accepted,_that.contactHidden,_that.sentAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _ChatMessage extends ChatMessage {
  const _ChatMessage({required this.seq, required this.mine, @JsonKey(unknownEnumValue: ChatKind.unknown) required this.kind, this.text, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.quickReply, this.roomCode, this.proposedStartAt, this.replyToSeq, this.accepted, this.contactHidden = false, required this.sentAt}): super._();
  factory _ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);

/// Gapless within the chat, so polling after the last one skips none.
@override final  int seq;
@override final  bool mine;
@override@JsonKey(unknownEnumValue: ChatKind.unknown) final  ChatKind kind;
@override final  String? text;
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  QuickReply? quickReply;
@override final  String? roomCode;
@override final  DateTime? proposedStartAt;
/// The proposal a time answer answers.
@override final  int? replyToSeq;
@override final  bool? accepted;
/// Emails, links or phone numbers in the text became "[hidden]".
@override@JsonKey() final  bool contactHidden;
@override final  DateTime sentAt;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageCopyWith<_ChatMessage> get copyWith => __$ChatMessageCopyWithImpl<_ChatMessage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessage&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.mine, mine) || other.mine == mine)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.text, text) || other.text == text)&&(identical(other.quickReply, quickReply) || other.quickReply == quickReply)&&(identical(other.roomCode, roomCode) || other.roomCode == roomCode)&&(identical(other.proposedStartAt, proposedStartAt) || other.proposedStartAt == proposedStartAt)&&(identical(other.replyToSeq, replyToSeq) || other.replyToSeq == replyToSeq)&&(identical(other.accepted, accepted) || other.accepted == accepted)&&(identical(other.contactHidden, contactHidden) || other.contactHidden == contactHidden)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,seq,mine,kind,text,quickReply,roomCode,proposedStartAt,replyToSeq,accepted,contactHidden,sentAt);
}

@override
String toString() {
    return 'ChatMessage(seq: $seq, mine: $mine, kind: $kind, text: $text, quickReply: $quickReply, roomCode: $roomCode, proposedStartAt: $proposedStartAt, replyToSeq: $replyToSeq, accepted: $accepted, contactHidden: $contactHidden, sentAt: $sentAt)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory _$ChatMessageCopyWith(_ChatMessage value, $Res Function(_ChatMessage) _then) = __$ChatMessageCopyWithImpl;
@override @useResult
$Res call({
 int seq, bool mine,@JsonKey(unknownEnumValue: ChatKind.unknown) ChatKind kind, String? text,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) QuickReply? quickReply, String? roomCode, DateTime? proposedStartAt, int? replyToSeq, bool? accepted, bool contactHidden, DateTime sentAt
});




}
/// @nodoc
class __$ChatMessageCopyWithImpl<$Res>
    implements _$ChatMessageCopyWith<$Res> {
  __$ChatMessageCopyWithImpl(this._self, this._then);

  final _ChatMessage _self;
  final $Res Function(_ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seq = null,Object? mine = null,Object? kind = null,Object? text = freezed,Object? quickReply = freezed,Object? roomCode = freezed,Object? proposedStartAt = freezed,Object? replyToSeq = freezed,Object? accepted = freezed,Object? contactHidden = null,Object? sentAt = null,}) {
  return _then(_ChatMessage(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,mine: null == mine ? _self.mine : mine // ignore: cast_nullable_to_non_nullable
as bool,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ChatKind,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,quickReply: freezed == quickReply ? _self.quickReply : quickReply // ignore: cast_nullable_to_non_nullable
as QuickReply?,roomCode: freezed == roomCode ? _self.roomCode : roomCode // ignore: cast_nullable_to_non_nullable
as String?,proposedStartAt: freezed == proposedStartAt ? _self.proposedStartAt : proposedStartAt // ignore: cast_nullable_to_non_nullable
as DateTime?,replyToSeq: freezed == replyToSeq ? _self.replyToSeq : replyToSeq // ignore: cast_nullable_to_non_nullable
as int?,accepted: freezed == accepted ? _self.accepted : accepted // ignore: cast_nullable_to_non_nullable
as bool?,contactHidden: null == contactHidden ? _self.contactHidden : contactHidden // ignore: cast_nullable_to_non_nullable
as bool,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
