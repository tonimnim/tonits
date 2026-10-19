// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchSummary {

 String get id; String get competitionId; String get competitionName; String get roundName; DateTime? get scheduledAt; DateTime? get checkInClosesAt;@JsonKey(unknownEnumValue: MatchLifecycle.unknown) MatchLifecycle get lifecycle;@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) MatchOutcome? get outcome;/// `home` or `away`: which side the signed-in player is on.
 String get currentPlayerSide; MatchParticipant? get home; MatchParticipant? get away; Set<String> get allowedActions;/// 1, 3 or 5 games.
 int get bestOf;/// The match's chat, once both sides are known.
 ChatSummary? get chat;
/// Create a copy of MatchSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchSummaryCopyWith<MatchSummary> get copyWith => _$MatchSummaryCopyWithImpl<MatchSummary>(this as MatchSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MatchSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchSummary&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.competitionId, _this.competitionId) || other.competitionId == _this.competitionId)&&(identical(other.competitionName, _this.competitionName) || other.competitionName == _this.competitionName)&&(identical(other.roundName, _this.roundName) || other.roundName == _this.roundName)&&(identical(other.scheduledAt, _this.scheduledAt) || other.scheduledAt == _this.scheduledAt)&&(identical(other.checkInClosesAt, _this.checkInClosesAt) || other.checkInClosesAt == _this.checkInClosesAt)&&(identical(other.lifecycle, _this.lifecycle) || other.lifecycle == _this.lifecycle)&&(identical(other.outcome, _this.outcome) || other.outcome == _this.outcome)&&(identical(other.currentPlayerSide, _this.currentPlayerSide) || other.currentPlayerSide == _this.currentPlayerSide)&&(identical(other.home, _this.home) || other.home == _this.home)&&(identical(other.away, _this.away) || other.away == _this.away)&&const DeepCollectionEquality().equals(other.allowedActions, _this.allowedActions)&&(identical(other.bestOf, _this.bestOf) || other.bestOf == _this.bestOf)&&(identical(other.chat, _this.chat) || other.chat == _this.chat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MatchSummary;
  return Object.hash(runtimeType,_this.id,_this.competitionId,_this.competitionName,_this.roundName,_this.scheduledAt,_this.checkInClosesAt,_this.lifecycle,_this.outcome,_this.currentPlayerSide,_this.home,_this.away,const DeepCollectionEquality().hash(_this.allowedActions),_this.bestOf,_this.chat);
}

@override
String toString() {
  final _this = this as MatchSummary;
  return 'MatchSummary(id: ${_this.id}, competitionId: ${_this.competitionId}, competitionName: ${_this.competitionName}, roundName: ${_this.roundName}, scheduledAt: ${_this.scheduledAt}, checkInClosesAt: ${_this.checkInClosesAt}, lifecycle: ${_this.lifecycle}, outcome: ${_this.outcome}, currentPlayerSide: ${_this.currentPlayerSide}, home: ${_this.home}, away: ${_this.away}, allowedActions: ${_this.allowedActions}, bestOf: ${_this.bestOf}, chat: ${_this.chat})';
}


}

/// @nodoc
abstract mixin class $MatchSummaryCopyWith<$Res>  {
  factory $MatchSummaryCopyWith(MatchSummary value, $Res Function(MatchSummary) _then) = _$MatchSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String competitionId, String competitionName, String roundName, DateTime? scheduledAt, DateTime? checkInClosesAt,@JsonKey(unknownEnumValue: MatchLifecycle.unknown) MatchLifecycle lifecycle,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) MatchOutcome? outcome, String currentPlayerSide, MatchParticipant? home, MatchParticipant? away, Set<String> allowedActions, int bestOf, ChatSummary? chat
});


$MatchParticipantCopyWith<$Res>? get home;$MatchParticipantCopyWith<$Res>? get away;$ChatSummaryCopyWith<$Res>? get chat;

}
/// @nodoc
class _$MatchSummaryCopyWithImpl<$Res>
    implements $MatchSummaryCopyWith<$Res> {
  _$MatchSummaryCopyWithImpl(this._self, this._then);

  final MatchSummary _self;
  final $Res Function(MatchSummary) _then;

/// Create a copy of MatchSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? competitionId = null,Object? competitionName = null,Object? roundName = null,Object? scheduledAt = freezed,Object? checkInClosesAt = freezed,Object? lifecycle = null,Object? outcome = freezed,Object? currentPlayerSide = null,Object? home = freezed,Object? away = freezed,Object? allowedActions = null,Object? bestOf = null,Object? chat = freezed,}) {
  return _then(MatchSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,competitionId: null == competitionId ? _self.competitionId : competitionId // ignore: cast_nullable_to_non_nullable
as String,competitionName: null == competitionName ? _self.competitionName : competitionName // ignore: cast_nullable_to_non_nullable
as String,roundName: null == roundName ? _self.roundName : roundName // ignore: cast_nullable_to_non_nullable
as String,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,checkInClosesAt: freezed == checkInClosesAt ? _self.checkInClosesAt : checkInClosesAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lifecycle: null == lifecycle ? _self.lifecycle : lifecycle // ignore: cast_nullable_to_non_nullable
as MatchLifecycle,outcome: freezed == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as MatchOutcome?,currentPlayerSide: null == currentPlayerSide ? _self.currentPlayerSide : currentPlayerSide // ignore: cast_nullable_to_non_nullable
as String,home: freezed == home ? _self.home : home // ignore: cast_nullable_to_non_nullable
as MatchParticipant?,away: freezed == away ? _self.away : away // ignore: cast_nullable_to_non_nullable
as MatchParticipant?,allowedActions: null == allowedActions ? _self.allowedActions : allowedActions // ignore: cast_nullable_to_non_nullable
as Set<String>,bestOf: null == bestOf ? _self.bestOf : bestOf // ignore: cast_nullable_to_non_nullable
as int,chat: freezed == chat ? _self.chat : chat // ignore: cast_nullable_to_non_nullable
as ChatSummary?,
  ));
}
/// Create a copy of MatchSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchParticipantCopyWith<$Res>? get home {
    if (_self.home == null) {
    return null;
  }

  return $MatchParticipantCopyWith<$Res>(_self.home!, (value) {
    return _then(_self.copyWith(home: value));
  });
}/// Create a copy of MatchSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchParticipantCopyWith<$Res>? get away {
    if (_self.away == null) {
    return null;
  }

  return $MatchParticipantCopyWith<$Res>(_self.away!, (value) {
    return _then(_self.copyWith(away: value));
  });
}/// Create a copy of MatchSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatSummaryCopyWith<$Res>? get chat {
    if (_self.chat == null) {
    return null;
  }

  return $ChatSummaryCopyWith<$Res>(_self.chat!, (value) {
    return _then(_self.copyWith(chat: value));
  });
}
}


/// Adds pattern-matching-related methods to [MatchSummary].
extension MatchSummaryPatterns on MatchSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchSummary value)  $default,){
final _that = this;
switch (_that) {
case _MatchSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchSummary value)?  $default,){
final _that = this;
switch (_that) {
case _MatchSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String competitionId,  String competitionName,  String roundName,  DateTime? scheduledAt,  DateTime? checkInClosesAt, @JsonKey(unknownEnumValue: MatchLifecycle.unknown)  MatchLifecycle lifecycle, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  MatchOutcome? outcome,  String currentPlayerSide,  MatchParticipant? home,  MatchParticipant? away,  Set<String> allowedActions,  int bestOf,  ChatSummary? chat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchSummary() when $default != null:
return $default(_that.id,_that.competitionId,_that.competitionName,_that.roundName,_that.scheduledAt,_that.checkInClosesAt,_that.lifecycle,_that.outcome,_that.currentPlayerSide,_that.home,_that.away,_that.allowedActions,_that.bestOf,_that.chat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String competitionId,  String competitionName,  String roundName,  DateTime? scheduledAt,  DateTime? checkInClosesAt, @JsonKey(unknownEnumValue: MatchLifecycle.unknown)  MatchLifecycle lifecycle, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  MatchOutcome? outcome,  String currentPlayerSide,  MatchParticipant? home,  MatchParticipant? away,  Set<String> allowedActions,  int bestOf,  ChatSummary? chat)  $default,) {final _that = this;
switch (_that) {
case _MatchSummary():
return $default(_that.id,_that.competitionId,_that.competitionName,_that.roundName,_that.scheduledAt,_that.checkInClosesAt,_that.lifecycle,_that.outcome,_that.currentPlayerSide,_that.home,_that.away,_that.allowedActions,_that.bestOf,_that.chat);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String competitionId,  String competitionName,  String roundName,  DateTime? scheduledAt,  DateTime? checkInClosesAt, @JsonKey(unknownEnumValue: MatchLifecycle.unknown)  MatchLifecycle lifecycle, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  MatchOutcome? outcome,  String currentPlayerSide,  MatchParticipant? home,  MatchParticipant? away,  Set<String> allowedActions,  int bestOf,  ChatSummary? chat)?  $default,) {final _that = this;
switch (_that) {
case _MatchSummary() when $default != null:
return $default(_that.id,_that.competitionId,_that.competitionName,_that.roundName,_that.scheduledAt,_that.checkInClosesAt,_that.lifecycle,_that.outcome,_that.currentPlayerSide,_that.home,_that.away,_that.allowedActions,_that.bestOf,_that.chat);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _MatchSummary extends MatchSummary {
  const _MatchSummary({required this.id, this.competitionId = '', required this.competitionName, required this.roundName, this.scheduledAt, this.checkInClosesAt, @JsonKey(unknownEnumValue: MatchLifecycle.unknown) required this.lifecycle, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.outcome, required this.currentPlayerSide, this.home, this.away,  Set<String> allowedActions = const <String>{}, this.bestOf = 1, this.chat}): _allowedActions = allowedActions,super._();
  factory _MatchSummary.fromJson(Map<String, dynamic> json) => _$MatchSummaryFromJson(json);

@override final  String id;
@override@JsonKey() final  String competitionId;
@override final  String competitionName;
@override final  String roundName;
@override final  DateTime? scheduledAt;
@override final  DateTime? checkInClosesAt;
@override@JsonKey(unknownEnumValue: MatchLifecycle.unknown) final  MatchLifecycle lifecycle;
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  MatchOutcome? outcome;
/// `home` or `away`: which side the signed-in player is on.
@override final  String currentPlayerSide;
@override final  MatchParticipant? home;
@override final  MatchParticipant? away;
 final  Set<String> _allowedActions;
@override@JsonKey() Set<String> get allowedActions {
  if (_allowedActions is EqualUnmodifiableSetView) return _allowedActions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_allowedActions);
}

/// 1, 3 or 5 games.
@override@JsonKey() final  int bestOf;
/// The match's chat, once both sides are known.
@override final  ChatSummary? chat;

/// Create a copy of MatchSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchSummaryCopyWith<_MatchSummary> get copyWith => __$MatchSummaryCopyWithImpl<_MatchSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.competitionId, competitionId) || other.competitionId == competitionId)&&(identical(other.competitionName, competitionName) || other.competitionName == competitionName)&&(identical(other.roundName, roundName) || other.roundName == roundName)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.checkInClosesAt, checkInClosesAt) || other.checkInClosesAt == checkInClosesAt)&&(identical(other.lifecycle, lifecycle) || other.lifecycle == lifecycle)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&(identical(other.currentPlayerSide, currentPlayerSide) || other.currentPlayerSide == currentPlayerSide)&&(identical(other.home, home) || other.home == home)&&(identical(other.away, away) || other.away == away)&&const DeepCollectionEquality().equals(other.allowedActions, _allowedActions)&&(identical(other.bestOf, bestOf) || other.bestOf == bestOf)&&(identical(other.chat, chat) || other.chat == chat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,competitionId,competitionName,roundName,scheduledAt,checkInClosesAt,lifecycle,outcome,currentPlayerSide,home,away,const DeepCollectionEquality().hash(_allowedActions),bestOf,chat);
}

@override
String toString() {
    return 'MatchSummary(id: $id, competitionId: $competitionId, competitionName: $competitionName, roundName: $roundName, scheduledAt: $scheduledAt, checkInClosesAt: $checkInClosesAt, lifecycle: $lifecycle, outcome: $outcome, currentPlayerSide: $currentPlayerSide, home: $home, away: $away, allowedActions: $allowedActions, bestOf: $bestOf, chat: $chat)';
}


}

/// @nodoc
abstract mixin class _$MatchSummaryCopyWith<$Res> implements $MatchSummaryCopyWith<$Res> {
  factory _$MatchSummaryCopyWith(_MatchSummary value, $Res Function(_MatchSummary) _then) = __$MatchSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String competitionId, String competitionName, String roundName, DateTime? scheduledAt, DateTime? checkInClosesAt,@JsonKey(unknownEnumValue: MatchLifecycle.unknown) MatchLifecycle lifecycle,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) MatchOutcome? outcome, String currentPlayerSide, MatchParticipant? home, MatchParticipant? away, Set<String> allowedActions, int bestOf, ChatSummary? chat
});


@override $MatchParticipantCopyWith<$Res>? get home;@override $MatchParticipantCopyWith<$Res>? get away;@override $ChatSummaryCopyWith<$Res>? get chat;

}
/// @nodoc
class __$MatchSummaryCopyWithImpl<$Res>
    implements _$MatchSummaryCopyWith<$Res> {
  __$MatchSummaryCopyWithImpl(this._self, this._then);

  final _MatchSummary _self;
  final $Res Function(_MatchSummary) _then;

/// Create a copy of MatchSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? competitionId = null,Object? competitionName = null,Object? roundName = null,Object? scheduledAt = freezed,Object? checkInClosesAt = freezed,Object? lifecycle = null,Object? outcome = freezed,Object? currentPlayerSide = null,Object? home = freezed,Object? away = freezed,Object? allowedActions = null,Object? bestOf = null,Object? chat = freezed,}) {
  return _then(_MatchSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,competitionId: null == competitionId ? _self.competitionId : competitionId // ignore: cast_nullable_to_non_nullable
as String,competitionName: null == competitionName ? _self.competitionName : competitionName // ignore: cast_nullable_to_non_nullable
as String,roundName: null == roundName ? _self.roundName : roundName // ignore: cast_nullable_to_non_nullable
as String,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,checkInClosesAt: freezed == checkInClosesAt ? _self.checkInClosesAt : checkInClosesAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lifecycle: null == lifecycle ? _self.lifecycle : lifecycle // ignore: cast_nullable_to_non_nullable
as MatchLifecycle,outcome: freezed == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as MatchOutcome?,currentPlayerSide: null == currentPlayerSide ? _self.currentPlayerSide : currentPlayerSide // ignore: cast_nullable_to_non_nullable
as String,home: freezed == home ? _self.home : home // ignore: cast_nullable_to_non_nullable
as MatchParticipant?,away: freezed == away ? _self.away : away // ignore: cast_nullable_to_non_nullable
as MatchParticipant?,allowedActions: null == allowedActions ? _self._allowedActions : allowedActions // ignore: cast_nullable_to_non_nullable
as Set<String>,bestOf: null == bestOf ? _self.bestOf : bestOf // ignore: cast_nullable_to_non_nullable
as int,chat: freezed == chat ? _self.chat : chat // ignore: cast_nullable_to_non_nullable
as ChatSummary?,
  ));
}

/// Create a copy of MatchSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchParticipantCopyWith<$Res>? get home {
    if (_self.home == null) {
    return null;
  }

  return $MatchParticipantCopyWith<$Res>(_self.home!, (value) {
    return _then(_self.copyWith(home: value));
  });
}/// Create a copy of MatchSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchParticipantCopyWith<$Res>? get away {
    if (_self.away == null) {
    return null;
  }

  return $MatchParticipantCopyWith<$Res>(_self.away!, (value) {
    return _then(_self.copyWith(away: value));
  });
}/// Create a copy of MatchSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatSummaryCopyWith<$Res>? get chat {
    if (_self.chat == null) {
    return null;
  }

  return $ChatSummaryCopyWith<$Res>(_self.chat!, (value) {
    return _then(_self.copyWith(chat: value));
  });
}
}


/// @nodoc
mixin _$ChatSummary {

/// Players can post while both sides are known and the match isn't
/// final.
 bool get open;/// The opponent's messages the player hasn't read.
 int get unread;/// The Friend Match room code a player pinned.
 String? get roomCode;/// The kick-off both players agreed. It moves no deadline.
 DateTime? get agreedStartAt;
/// Create a copy of ChatSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatSummaryCopyWith<ChatSummary> get copyWith => _$ChatSummaryCopyWithImpl<ChatSummary>(this as ChatSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatSummary&&(identical(other.open, _this.open) || other.open == _this.open)&&(identical(other.unread, _this.unread) || other.unread == _this.unread)&&(identical(other.roomCode, _this.roomCode) || other.roomCode == _this.roomCode)&&(identical(other.agreedStartAt, _this.agreedStartAt) || other.agreedStartAt == _this.agreedStartAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatSummary;
  return Object.hash(runtimeType,_this.open,_this.unread,_this.roomCode,_this.agreedStartAt);
}

@override
String toString() {
  final _this = this as ChatSummary;
  return 'ChatSummary(open: ${_this.open}, unread: ${_this.unread}, roomCode: ${_this.roomCode}, agreedStartAt: ${_this.agreedStartAt})';
}


}

/// @nodoc
abstract mixin class $ChatSummaryCopyWith<$Res>  {
  factory $ChatSummaryCopyWith(ChatSummary value, $Res Function(ChatSummary) _then) = _$ChatSummaryCopyWithImpl;
@useResult
$Res call({
 bool open, int unread, String? roomCode, DateTime? agreedStartAt
});




}
/// @nodoc
class _$ChatSummaryCopyWithImpl<$Res>
    implements $ChatSummaryCopyWith<$Res> {
  _$ChatSummaryCopyWithImpl(this._self, this._then);

  final ChatSummary _self;
  final $Res Function(ChatSummary) _then;

/// Create a copy of ChatSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? open = null,Object? unread = null,Object? roomCode = freezed,Object? agreedStartAt = freezed,}) {
  return _then(ChatSummary(
open: null == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as bool,unread: null == unread ? _self.unread : unread // ignore: cast_nullable_to_non_nullable
as int,roomCode: freezed == roomCode ? _self.roomCode : roomCode // ignore: cast_nullable_to_non_nullable
as String?,agreedStartAt: freezed == agreedStartAt ? _self.agreedStartAt : agreedStartAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatSummary].
extension ChatSummaryPatterns on ChatSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatSummary value)  $default,){
final _that = this;
switch (_that) {
case _ChatSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ChatSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool open,  int unread,  String? roomCode,  DateTime? agreedStartAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatSummary() when $default != null:
return $default(_that.open,_that.unread,_that.roomCode,_that.agreedStartAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool open,  int unread,  String? roomCode,  DateTime? agreedStartAt)  $default,) {final _that = this;
switch (_that) {
case _ChatSummary():
return $default(_that.open,_that.unread,_that.roomCode,_that.agreedStartAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool open,  int unread,  String? roomCode,  DateTime? agreedStartAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatSummary() when $default != null:
return $default(_that.open,_that.unread,_that.roomCode,_that.agreedStartAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _ChatSummary implements ChatSummary {
  const _ChatSummary({this.open = false, this.unread = 0, this.roomCode, this.agreedStartAt});
  factory _ChatSummary.fromJson(Map<String, dynamic> json) => _$ChatSummaryFromJson(json);

/// Players can post while both sides are known and the match isn't
/// final.
@override@JsonKey() final  bool open;
/// The opponent's messages the player hasn't read.
@override@JsonKey() final  int unread;
/// The Friend Match room code a player pinned.
@override final  String? roomCode;
/// The kick-off both players agreed. It moves no deadline.
@override final  DateTime? agreedStartAt;

/// Create a copy of ChatSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatSummaryCopyWith<_ChatSummary> get copyWith => __$ChatSummaryCopyWithImpl<_ChatSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatSummary&&(identical(other.open, open) || other.open == open)&&(identical(other.unread, unread) || other.unread == unread)&&(identical(other.roomCode, roomCode) || other.roomCode == roomCode)&&(identical(other.agreedStartAt, agreedStartAt) || other.agreedStartAt == agreedStartAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,open,unread,roomCode,agreedStartAt);
}

@override
String toString() {
    return 'ChatSummary(open: $open, unread: $unread, roomCode: $roomCode, agreedStartAt: $agreedStartAt)';
}


}

/// @nodoc
abstract mixin class _$ChatSummaryCopyWith<$Res> implements $ChatSummaryCopyWith<$Res> {
  factory _$ChatSummaryCopyWith(_ChatSummary value, $Res Function(_ChatSummary) _then) = __$ChatSummaryCopyWithImpl;
@override @useResult
$Res call({
 bool open, int unread, String? roomCode, DateTime? agreedStartAt
});




}
/// @nodoc
class __$ChatSummaryCopyWithImpl<$Res>
    implements _$ChatSummaryCopyWith<$Res> {
  __$ChatSummaryCopyWithImpl(this._self, this._then);

  final _ChatSummary _self;
  final $Res Function(_ChatSummary) _then;

/// Create a copy of ChatSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? open = null,Object? unread = null,Object? roomCode = freezed,Object? agreedStartAt = freezed,}) {
  return _then(_ChatSummary(
open: null == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as bool,unread: null == unread ? _self.unread : unread // ignore: cast_nullable_to_non_nullable
as int,roomCode: freezed == roomCode ? _self.roomCode : roomCode // ignore: cast_nullable_to_non_nullable
as String?,agreedStartAt: freezed == agreedStartAt ? _self.agreedStartAt : agreedStartAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$MatchParticipant {

 String get displayName; String get handle; String? get playerId; DateTime? get checkedInAt;/// The eFootball account this side plays with, for finding each other in
/// the game. Only the match's two players receive it.
 MatchGameAccount? get gameAccount;
/// Create a copy of MatchParticipant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchParticipantCopyWith<MatchParticipant> get copyWith => _$MatchParticipantCopyWithImpl<MatchParticipant>(this as MatchParticipant, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MatchParticipant;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchParticipant&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.handle, _this.handle) || other.handle == _this.handle)&&(identical(other.playerId, _this.playerId) || other.playerId == _this.playerId)&&(identical(other.checkedInAt, _this.checkedInAt) || other.checkedInAt == _this.checkedInAt)&&(identical(other.gameAccount, _this.gameAccount) || other.gameAccount == _this.gameAccount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MatchParticipant;
  return Object.hash(runtimeType,_this.displayName,_this.handle,_this.playerId,_this.checkedInAt,_this.gameAccount);
}

@override
String toString() {
  final _this = this as MatchParticipant;
  return 'MatchParticipant(displayName: ${_this.displayName}, handle: ${_this.handle}, playerId: ${_this.playerId}, checkedInAt: ${_this.checkedInAt}, gameAccount: ${_this.gameAccount})';
}


}

/// @nodoc
abstract mixin class $MatchParticipantCopyWith<$Res>  {
  factory $MatchParticipantCopyWith(MatchParticipant value, $Res Function(MatchParticipant) _then) = _$MatchParticipantCopyWithImpl;
@useResult
$Res call({
 String displayName, String handle, String? playerId, DateTime? checkedInAt, MatchGameAccount? gameAccount
});


$MatchGameAccountCopyWith<$Res>? get gameAccount;

}
/// @nodoc
class _$MatchParticipantCopyWithImpl<$Res>
    implements $MatchParticipantCopyWith<$Res> {
  _$MatchParticipantCopyWithImpl(this._self, this._then);

  final MatchParticipant _self;
  final $Res Function(MatchParticipant) _then;

/// Create a copy of MatchParticipant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? handle = null,Object? playerId = freezed,Object? checkedInAt = freezed,Object? gameAccount = freezed,}) {
  return _then(MatchParticipant(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String?,checkedInAt: freezed == checkedInAt ? _self.checkedInAt : checkedInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,gameAccount: freezed == gameAccount ? _self.gameAccount : gameAccount // ignore: cast_nullable_to_non_nullable
as MatchGameAccount?,
  ));
}
/// Create a copy of MatchParticipant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchGameAccountCopyWith<$Res>? get gameAccount {
    if (_self.gameAccount == null) {
    return null;
  }

  return $MatchGameAccountCopyWith<$Res>(_self.gameAccount!, (value) {
    return _then(_self.copyWith(gameAccount: value));
  });
}
}


/// Adds pattern-matching-related methods to [MatchParticipant].
extension MatchParticipantPatterns on MatchParticipant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchParticipant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchParticipant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchParticipant value)  $default,){
final _that = this;
switch (_that) {
case _MatchParticipant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchParticipant value)?  $default,){
final _that = this;
switch (_that) {
case _MatchParticipant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String displayName,  String handle,  String? playerId,  DateTime? checkedInAt,  MatchGameAccount? gameAccount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchParticipant() when $default != null:
return $default(_that.displayName,_that.handle,_that.playerId,_that.checkedInAt,_that.gameAccount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String displayName,  String handle,  String? playerId,  DateTime? checkedInAt,  MatchGameAccount? gameAccount)  $default,) {final _that = this;
switch (_that) {
case _MatchParticipant():
return $default(_that.displayName,_that.handle,_that.playerId,_that.checkedInAt,_that.gameAccount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String displayName,  String handle,  String? playerId,  DateTime? checkedInAt,  MatchGameAccount? gameAccount)?  $default,) {final _that = this;
switch (_that) {
case _MatchParticipant() when $default != null:
return $default(_that.displayName,_that.handle,_that.playerId,_that.checkedInAt,_that.gameAccount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _MatchParticipant extends MatchParticipant {
  const _MatchParticipant({required this.displayName, required this.handle, this.playerId, this.checkedInAt, this.gameAccount}): super._();
  factory _MatchParticipant.fromJson(Map<String, dynamic> json) => _$MatchParticipantFromJson(json);

@override final  String displayName;
@override final  String handle;
@override final  String? playerId;
@override final  DateTime? checkedInAt;
/// The eFootball account this side plays with, for finding each other in
/// the game. Only the match's two players receive it.
@override final  MatchGameAccount? gameAccount;

/// Create a copy of MatchParticipant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchParticipantCopyWith<_MatchParticipant> get copyWith => __$MatchParticipantCopyWithImpl<_MatchParticipant>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchParticipant&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.checkedInAt, checkedInAt) || other.checkedInAt == checkedInAt)&&(identical(other.gameAccount, gameAccount) || other.gameAccount == gameAccount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,displayName,handle,playerId,checkedInAt,gameAccount);
}

@override
String toString() {
    return 'MatchParticipant(displayName: $displayName, handle: $handle, playerId: $playerId, checkedInAt: $checkedInAt, gameAccount: $gameAccount)';
}


}

/// @nodoc
abstract mixin class _$MatchParticipantCopyWith<$Res> implements $MatchParticipantCopyWith<$Res> {
  factory _$MatchParticipantCopyWith(_MatchParticipant value, $Res Function(_MatchParticipant) _then) = __$MatchParticipantCopyWithImpl;
@override @useResult
$Res call({
 String displayName, String handle, String? playerId, DateTime? checkedInAt, MatchGameAccount? gameAccount
});


@override $MatchGameAccountCopyWith<$Res>? get gameAccount;

}
/// @nodoc
class __$MatchParticipantCopyWithImpl<$Res>
    implements _$MatchParticipantCopyWith<$Res> {
  __$MatchParticipantCopyWithImpl(this._self, this._then);

  final _MatchParticipant _self;
  final $Res Function(_MatchParticipant) _then;

/// Create a copy of MatchParticipant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? handle = null,Object? playerId = freezed,Object? checkedInAt = freezed,Object? gameAccount = freezed,}) {
  return _then(_MatchParticipant(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String?,checkedInAt: freezed == checkedInAt ? _self.checkedInAt : checkedInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,gameAccount: freezed == gameAccount ? _self.gameAccount : gameAccount // ignore: cast_nullable_to_non_nullable
as MatchGameAccount?,
  ));
}

/// Create a copy of MatchParticipant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchGameAccountCopyWith<$Res>? get gameAccount {
    if (_self.gameAccount == null) {
    return null;
  }

  return $MatchGameAccountCopyWith<$Res>(_self.gameAccount!, (value) {
    return _then(_self.copyWith(gameAccount: value));
  });
}
}


/// @nodoc
mixin _$MatchGameAccount {

/// The name shown in eFootball.
 String get inGameName;/// `android` or `ios`.
 String get platform;/// The eFootball User ID players add each other by; null when not added.
@JsonKey(name: 'publisherPlayerId') String? get userId;
/// Create a copy of MatchGameAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchGameAccountCopyWith<MatchGameAccount> get copyWith => _$MatchGameAccountCopyWithImpl<MatchGameAccount>(this as MatchGameAccount, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MatchGameAccount;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchGameAccount&&(identical(other.inGameName, _this.inGameName) || other.inGameName == _this.inGameName)&&(identical(other.platform, _this.platform) || other.platform == _this.platform)&&(identical(other.userId, _this.userId) || other.userId == _this.userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MatchGameAccount;
  return Object.hash(runtimeType,_this.inGameName,_this.platform,_this.userId);
}

@override
String toString() {
  final _this = this as MatchGameAccount;
  return 'MatchGameAccount(inGameName: ${_this.inGameName}, platform: ${_this.platform}, userId: ${_this.userId})';
}


}

/// @nodoc
abstract mixin class $MatchGameAccountCopyWith<$Res>  {
  factory $MatchGameAccountCopyWith(MatchGameAccount value, $Res Function(MatchGameAccount) _then) = _$MatchGameAccountCopyWithImpl;
@useResult
$Res call({
 String inGameName, String platform,@JsonKey(name: 'publisherPlayerId') String? userId
});




}
/// @nodoc
class _$MatchGameAccountCopyWithImpl<$Res>
    implements $MatchGameAccountCopyWith<$Res> {
  _$MatchGameAccountCopyWithImpl(this._self, this._then);

  final MatchGameAccount _self;
  final $Res Function(MatchGameAccount) _then;

/// Create a copy of MatchGameAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? inGameName = null,Object? platform = null,Object? userId = freezed,}) {
  return _then(MatchGameAccount(
inGameName: null == inGameName ? _self.inGameName : inGameName // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchGameAccount].
extension MatchGameAccountPatterns on MatchGameAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchGameAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchGameAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchGameAccount value)  $default,){
final _that = this;
switch (_that) {
case _MatchGameAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchGameAccount value)?  $default,){
final _that = this;
switch (_that) {
case _MatchGameAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String inGameName,  String platform, @JsonKey(name: 'publisherPlayerId')  String? userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchGameAccount() when $default != null:
return $default(_that.inGameName,_that.platform,_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String inGameName,  String platform, @JsonKey(name: 'publisherPlayerId')  String? userId)  $default,) {final _that = this;
switch (_that) {
case _MatchGameAccount():
return $default(_that.inGameName,_that.platform,_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String inGameName,  String platform, @JsonKey(name: 'publisherPlayerId')  String? userId)?  $default,) {final _that = this;
switch (_that) {
case _MatchGameAccount() when $default != null:
return $default(_that.inGameName,_that.platform,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _MatchGameAccount implements MatchGameAccount {
  const _MatchGameAccount({required this.inGameName, required this.platform, @JsonKey(name: 'publisherPlayerId') this.userId});
  factory _MatchGameAccount.fromJson(Map<String, dynamic> json) => _$MatchGameAccountFromJson(json);

/// The name shown in eFootball.
@override final  String inGameName;
/// `android` or `ios`.
@override final  String platform;
/// The eFootball User ID players add each other by; null when not added.
@override@JsonKey(name: 'publisherPlayerId') final  String? userId;

/// Create a copy of MatchGameAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchGameAccountCopyWith<_MatchGameAccount> get copyWith => __$MatchGameAccountCopyWithImpl<_MatchGameAccount>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchGameAccount&&(identical(other.inGameName, inGameName) || other.inGameName == inGameName)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,inGameName,platform,userId);
}

@override
String toString() {
    return 'MatchGameAccount(inGameName: $inGameName, platform: $platform, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$MatchGameAccountCopyWith<$Res> implements $MatchGameAccountCopyWith<$Res> {
  factory _$MatchGameAccountCopyWith(_MatchGameAccount value, $Res Function(_MatchGameAccount) _then) = __$MatchGameAccountCopyWithImpl;
@override @useResult
$Res call({
 String inGameName, String platform,@JsonKey(name: 'publisherPlayerId') String? userId
});




}
/// @nodoc
class __$MatchGameAccountCopyWithImpl<$Res>
    implements _$MatchGameAccountCopyWith<$Res> {
  __$MatchGameAccountCopyWithImpl(this._self, this._then);

  final _MatchGameAccount _self;
  final $Res Function(_MatchGameAccount) _then;

/// Create a copy of MatchGameAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? inGameName = null,Object? platform = null,Object? userId = freezed,}) {
  return _then(_MatchGameAccount(
inGameName: null == inGameName ? _self.inGameName : inGameName // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
