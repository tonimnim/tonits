// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchRoom {

/// The summary fields, read from the same object.
@JsonKey(readValue: _whole) MatchSummary get summary;/// A short reference, such as "M-1042", for support.
 String get code;/// 1, 3 or 5 games; one point per game won.
 int get bestOf;/// Games a side needs to win; the series stops there.
@JsonKey(name: 'gamesToWin') int? get gamesToWinValue;/// Round-robin matches may end level; knockouts need penalties.
 bool get drawAllowed; DateTime? get checkInOpensAt;/// When a result must be in; with none by then, both entries are removed.
 DateTime? get resultDueAt;/// Why a finished match ended (`played`, `walkover`, ...).
 String? get completionReason;@JsonKey(name: 'friendMatchInstructions') List<FriendMatchInstruction> get instructions;@JsonKey(name: 'resultVerification') ResultVerification get verification;/// The final score, once the match is completed.
 ConfirmedResult? get result;@JsonKey(name: 'verificationPolicy') VerificationWindows get windows;
/// Create a copy of MatchRoom
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchRoomCopyWith<MatchRoom> get copyWith => _$MatchRoomCopyWithImpl<MatchRoom>(this as MatchRoom, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MatchRoom;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchRoom&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.bestOf, _this.bestOf) || other.bestOf == _this.bestOf)&&(identical(other.gamesToWinValue, _this.gamesToWinValue) || other.gamesToWinValue == _this.gamesToWinValue)&&(identical(other.drawAllowed, _this.drawAllowed) || other.drawAllowed == _this.drawAllowed)&&(identical(other.checkInOpensAt, _this.checkInOpensAt) || other.checkInOpensAt == _this.checkInOpensAt)&&(identical(other.resultDueAt, _this.resultDueAt) || other.resultDueAt == _this.resultDueAt)&&(identical(other.completionReason, _this.completionReason) || other.completionReason == _this.completionReason)&&const DeepCollectionEquality().equals(other.instructions, _this.instructions)&&(identical(other.verification, _this.verification) || other.verification == _this.verification)&&(identical(other.result, _this.result) || other.result == _this.result)&&(identical(other.windows, _this.windows) || other.windows == _this.windows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MatchRoom;
  return Object.hash(runtimeType,_this.summary,_this.code,_this.bestOf,_this.gamesToWinValue,_this.drawAllowed,_this.checkInOpensAt,_this.resultDueAt,_this.completionReason,const DeepCollectionEquality().hash(_this.instructions),_this.verification,_this.result,_this.windows);
}

@override
String toString() {
  final _this = this as MatchRoom;
  return 'MatchRoom(summary: ${_this.summary}, code: ${_this.code}, bestOf: ${_this.bestOf}, gamesToWinValue: ${_this.gamesToWinValue}, drawAllowed: ${_this.drawAllowed}, checkInOpensAt: ${_this.checkInOpensAt}, resultDueAt: ${_this.resultDueAt}, completionReason: ${_this.completionReason}, instructions: ${_this.instructions}, verification: ${_this.verification}, result: ${_this.result}, windows: ${_this.windows})';
}


}

/// @nodoc
abstract mixin class $MatchRoomCopyWith<$Res>  {
  factory $MatchRoomCopyWith(MatchRoom value, $Res Function(MatchRoom) _then) = _$MatchRoomCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _whole) MatchSummary summary, String code, int bestOf,@JsonKey(name: 'gamesToWin') int? gamesToWinValue, bool drawAllowed, DateTime? checkInOpensAt, DateTime? resultDueAt, String? completionReason,@JsonKey(name: 'friendMatchInstructions') List<FriendMatchInstruction> instructions,@JsonKey(name: 'resultVerification') ResultVerification verification, ConfirmedResult? result,@JsonKey(name: 'verificationPolicy') VerificationWindows windows
});


$MatchSummaryCopyWith<$Res> get summary;$ResultVerificationCopyWith<$Res> get verification;$ConfirmedResultCopyWith<$Res>? get result;$VerificationWindowsCopyWith<$Res> get windows;

}
/// @nodoc
class _$MatchRoomCopyWithImpl<$Res>
    implements $MatchRoomCopyWith<$Res> {
  _$MatchRoomCopyWithImpl(this._self, this._then);

  final MatchRoom _self;
  final $Res Function(MatchRoom) _then;

/// Create a copy of MatchRoom
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = null,Object? code = null,Object? bestOf = null,Object? gamesToWinValue = freezed,Object? drawAllowed = null,Object? checkInOpensAt = freezed,Object? resultDueAt = freezed,Object? completionReason = freezed,Object? instructions = null,Object? verification = null,Object? result = freezed,Object? windows = null,}) {
  return _then(MatchRoom(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as MatchSummary,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,bestOf: null == bestOf ? _self.bestOf : bestOf // ignore: cast_nullable_to_non_nullable
as int,gamesToWinValue: freezed == gamesToWinValue ? _self.gamesToWinValue : gamesToWinValue // ignore: cast_nullable_to_non_nullable
as int?,drawAllowed: null == drawAllowed ? _self.drawAllowed : drawAllowed // ignore: cast_nullable_to_non_nullable
as bool,checkInOpensAt: freezed == checkInOpensAt ? _self.checkInOpensAt : checkInOpensAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resultDueAt: freezed == resultDueAt ? _self.resultDueAt : resultDueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completionReason: freezed == completionReason ? _self.completionReason : completionReason // ignore: cast_nullable_to_non_nullable
as String?,instructions: null == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as List<FriendMatchInstruction>,verification: null == verification ? _self.verification : verification // ignore: cast_nullable_to_non_nullable
as ResultVerification,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as ConfirmedResult?,windows: null == windows ? _self.windows : windows // ignore: cast_nullable_to_non_nullable
as VerificationWindows,
  ));
}
/// Create a copy of MatchRoom
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchSummaryCopyWith<$Res> get summary {
  
  return $MatchSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of MatchRoom
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultVerificationCopyWith<$Res> get verification {
  
  return $ResultVerificationCopyWith<$Res>(_self.verification, (value) {
    return _then(_self.copyWith(verification: value));
  });
}/// Create a copy of MatchRoom
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConfirmedResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $ConfirmedResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}/// Create a copy of MatchRoom
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerificationWindowsCopyWith<$Res> get windows {
  
  return $VerificationWindowsCopyWith<$Res>(_self.windows, (value) {
    return _then(_self.copyWith(windows: value));
  });
}
}


/// Adds pattern-matching-related methods to [MatchRoom].
extension MatchRoomPatterns on MatchRoom {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchRoom value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchRoom() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchRoom value)  $default,){
final _that = this;
switch (_that) {
case _MatchRoom():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchRoom value)?  $default,){
final _that = this;
switch (_that) {
case _MatchRoom() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _whole)  MatchSummary summary,  String code,  int bestOf, @JsonKey(name: 'gamesToWin')  int? gamesToWinValue,  bool drawAllowed,  DateTime? checkInOpensAt,  DateTime? resultDueAt,  String? completionReason, @JsonKey(name: 'friendMatchInstructions')  List<FriendMatchInstruction> instructions, @JsonKey(name: 'resultVerification')  ResultVerification verification,  ConfirmedResult? result, @JsonKey(name: 'verificationPolicy')  VerificationWindows windows)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchRoom() when $default != null:
return $default(_that.summary,_that.code,_that.bestOf,_that.gamesToWinValue,_that.drawAllowed,_that.checkInOpensAt,_that.resultDueAt,_that.completionReason,_that.instructions,_that.verification,_that.result,_that.windows);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _whole)  MatchSummary summary,  String code,  int bestOf, @JsonKey(name: 'gamesToWin')  int? gamesToWinValue,  bool drawAllowed,  DateTime? checkInOpensAt,  DateTime? resultDueAt,  String? completionReason, @JsonKey(name: 'friendMatchInstructions')  List<FriendMatchInstruction> instructions, @JsonKey(name: 'resultVerification')  ResultVerification verification,  ConfirmedResult? result, @JsonKey(name: 'verificationPolicy')  VerificationWindows windows)  $default,) {final _that = this;
switch (_that) {
case _MatchRoom():
return $default(_that.summary,_that.code,_that.bestOf,_that.gamesToWinValue,_that.drawAllowed,_that.checkInOpensAt,_that.resultDueAt,_that.completionReason,_that.instructions,_that.verification,_that.result,_that.windows);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _whole)  MatchSummary summary,  String code,  int bestOf, @JsonKey(name: 'gamesToWin')  int? gamesToWinValue,  bool drawAllowed,  DateTime? checkInOpensAt,  DateTime? resultDueAt,  String? completionReason, @JsonKey(name: 'friendMatchInstructions')  List<FriendMatchInstruction> instructions, @JsonKey(name: 'resultVerification')  ResultVerification verification,  ConfirmedResult? result, @JsonKey(name: 'verificationPolicy')  VerificationWindows windows)?  $default,) {final _that = this;
switch (_that) {
case _MatchRoom() when $default != null:
return $default(_that.summary,_that.code,_that.bestOf,_that.gamesToWinValue,_that.drawAllowed,_that.checkInOpensAt,_that.resultDueAt,_that.completionReason,_that.instructions,_that.verification,_that.result,_that.windows);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _MatchRoom extends MatchRoom {
  const _MatchRoom({@JsonKey(readValue: _whole) required this.summary, this.code = '', this.bestOf = 1, @JsonKey(name: 'gamesToWin') this.gamesToWinValue, this.drawAllowed = false, this.checkInOpensAt, this.resultDueAt, this.completionReason, @JsonKey(name: 'friendMatchInstructions')  List<FriendMatchInstruction> instructions = const <FriendMatchInstruction>[], @JsonKey(name: 'resultVerification') required this.verification, this.result, @JsonKey(name: 'verificationPolicy') this.windows = const VerificationWindows()}): _instructions = instructions,super._();
  factory _MatchRoom.fromJson(Map<String, dynamic> json) => _$MatchRoomFromJson(json);

/// The summary fields, read from the same object.
@override@JsonKey(readValue: _whole) final  MatchSummary summary;
/// A short reference, such as "M-1042", for support.
@override@JsonKey() final  String code;
/// 1, 3 or 5 games; one point per game won.
@override@JsonKey() final  int bestOf;
/// Games a side needs to win; the series stops there.
@override@JsonKey(name: 'gamesToWin') final  int? gamesToWinValue;
/// Round-robin matches may end level; knockouts need penalties.
@override@JsonKey() final  bool drawAllowed;
@override final  DateTime? checkInOpensAt;
/// When a result must be in; with none by then, both entries are removed.
@override final  DateTime? resultDueAt;
/// Why a finished match ended (`played`, `walkover`, ...).
@override final  String? completionReason;
 final  List<FriendMatchInstruction> _instructions;
@override@JsonKey(name: 'friendMatchInstructions') List<FriendMatchInstruction> get instructions {
  if (_instructions is EqualUnmodifiableListView) return _instructions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_instructions);
}

@override@JsonKey(name: 'resultVerification') final  ResultVerification verification;
/// The final score, once the match is completed.
@override final  ConfirmedResult? result;
@override@JsonKey(name: 'verificationPolicy') final  VerificationWindows windows;

/// Create a copy of MatchRoom
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchRoomCopyWith<_MatchRoom> get copyWith => __$MatchRoomCopyWithImpl<_MatchRoom>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchRoom&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.code, code) || other.code == code)&&(identical(other.bestOf, bestOf) || other.bestOf == bestOf)&&(identical(other.gamesToWinValue, gamesToWinValue) || other.gamesToWinValue == gamesToWinValue)&&(identical(other.drawAllowed, drawAllowed) || other.drawAllowed == drawAllowed)&&(identical(other.checkInOpensAt, checkInOpensAt) || other.checkInOpensAt == checkInOpensAt)&&(identical(other.resultDueAt, resultDueAt) || other.resultDueAt == resultDueAt)&&(identical(other.completionReason, completionReason) || other.completionReason == completionReason)&&const DeepCollectionEquality().equals(other.instructions, _instructions)&&(identical(other.verification, verification) || other.verification == verification)&&(identical(other.result, result) || other.result == result)&&(identical(other.windows, windows) || other.windows == windows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,summary,code,bestOf,gamesToWinValue,drawAllowed,checkInOpensAt,resultDueAt,completionReason,const DeepCollectionEquality().hash(_instructions),verification,result,windows);
}

@override
String toString() {
    return 'MatchRoom(summary: $summary, code: $code, bestOf: $bestOf, gamesToWinValue: $gamesToWinValue, drawAllowed: $drawAllowed, checkInOpensAt: $checkInOpensAt, resultDueAt: $resultDueAt, completionReason: $completionReason, instructions: $instructions, verification: $verification, result: $result, windows: $windows)';
}


}

/// @nodoc
abstract mixin class _$MatchRoomCopyWith<$Res> implements $MatchRoomCopyWith<$Res> {
  factory _$MatchRoomCopyWith(_MatchRoom value, $Res Function(_MatchRoom) _then) = __$MatchRoomCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _whole) MatchSummary summary, String code, int bestOf,@JsonKey(name: 'gamesToWin') int? gamesToWinValue, bool drawAllowed, DateTime? checkInOpensAt, DateTime? resultDueAt, String? completionReason,@JsonKey(name: 'friendMatchInstructions') List<FriendMatchInstruction> instructions,@JsonKey(name: 'resultVerification') ResultVerification verification, ConfirmedResult? result,@JsonKey(name: 'verificationPolicy') VerificationWindows windows
});


@override $MatchSummaryCopyWith<$Res> get summary;@override $ResultVerificationCopyWith<$Res> get verification;@override $ConfirmedResultCopyWith<$Res>? get result;@override $VerificationWindowsCopyWith<$Res> get windows;

}
/// @nodoc
class __$MatchRoomCopyWithImpl<$Res>
    implements _$MatchRoomCopyWith<$Res> {
  __$MatchRoomCopyWithImpl(this._self, this._then);

  final _MatchRoom _self;
  final $Res Function(_MatchRoom) _then;

/// Create a copy of MatchRoom
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = null,Object? code = null,Object? bestOf = null,Object? gamesToWinValue = freezed,Object? drawAllowed = null,Object? checkInOpensAt = freezed,Object? resultDueAt = freezed,Object? completionReason = freezed,Object? instructions = null,Object? verification = null,Object? result = freezed,Object? windows = null,}) {
  return _then(_MatchRoom(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as MatchSummary,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,bestOf: null == bestOf ? _self.bestOf : bestOf // ignore: cast_nullable_to_non_nullable
as int,gamesToWinValue: freezed == gamesToWinValue ? _self.gamesToWinValue : gamesToWinValue // ignore: cast_nullable_to_non_nullable
as int?,drawAllowed: null == drawAllowed ? _self.drawAllowed : drawAllowed // ignore: cast_nullable_to_non_nullable
as bool,checkInOpensAt: freezed == checkInOpensAt ? _self.checkInOpensAt : checkInOpensAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resultDueAt: freezed == resultDueAt ? _self.resultDueAt : resultDueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completionReason: freezed == completionReason ? _self.completionReason : completionReason // ignore: cast_nullable_to_non_nullable
as String?,instructions: null == instructions ? _self._instructions : instructions // ignore: cast_nullable_to_non_nullable
as List<FriendMatchInstruction>,verification: null == verification ? _self.verification : verification // ignore: cast_nullable_to_non_nullable
as ResultVerification,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as ConfirmedResult?,windows: null == windows ? _self.windows : windows // ignore: cast_nullable_to_non_nullable
as VerificationWindows,
  ));
}

/// Create a copy of MatchRoom
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchSummaryCopyWith<$Res> get summary {
  
  return $MatchSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of MatchRoom
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultVerificationCopyWith<$Res> get verification {
  
  return $ResultVerificationCopyWith<$Res>(_self.verification, (value) {
    return _then(_self.copyWith(verification: value));
  });
}/// Create a copy of MatchRoom
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConfirmedResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $ConfirmedResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}/// Create a copy of MatchRoom
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerificationWindowsCopyWith<$Res> get windows {
  
  return $VerificationWindowsCopyWith<$Res>(_self.windows, (value) {
    return _then(_self.copyWith(windows: value));
  });
}
}


/// @nodoc
mixin _$FriendMatchInstruction {

 String get title; String get detail;
/// Create a copy of FriendMatchInstruction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendMatchInstructionCopyWith<FriendMatchInstruction> get copyWith => _$FriendMatchInstructionCopyWithImpl<FriendMatchInstruction>(this as FriendMatchInstruction, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FriendMatchInstruction;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendMatchInstruction&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.detail, _this.detail) || other.detail == _this.detail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FriendMatchInstruction;
  return Object.hash(runtimeType,_this.title,_this.detail);
}

@override
String toString() {
  final _this = this as FriendMatchInstruction;
  return 'FriendMatchInstruction(title: ${_this.title}, detail: ${_this.detail})';
}


}

/// @nodoc
abstract mixin class $FriendMatchInstructionCopyWith<$Res>  {
  factory $FriendMatchInstructionCopyWith(FriendMatchInstruction value, $Res Function(FriendMatchInstruction) _then) = _$FriendMatchInstructionCopyWithImpl;
@useResult
$Res call({
 String title, String detail
});




}
/// @nodoc
class _$FriendMatchInstructionCopyWithImpl<$Res>
    implements $FriendMatchInstructionCopyWith<$Res> {
  _$FriendMatchInstructionCopyWithImpl(this._self, this._then);

  final FriendMatchInstruction _self;
  final $Res Function(FriendMatchInstruction) _then;

/// Create a copy of FriendMatchInstruction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? detail = null,}) {
  return _then(FriendMatchInstruction(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendMatchInstruction].
extension FriendMatchInstructionPatterns on FriendMatchInstruction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendMatchInstruction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendMatchInstruction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendMatchInstruction value)  $default,){
final _that = this;
switch (_that) {
case _FriendMatchInstruction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendMatchInstruction value)?  $default,){
final _that = this;
switch (_that) {
case _FriendMatchInstruction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String detail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendMatchInstruction() when $default != null:
return $default(_that.title,_that.detail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String detail)  $default,) {final _that = this;
switch (_that) {
case _FriendMatchInstruction():
return $default(_that.title,_that.detail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String detail)?  $default,) {final _that = this;
switch (_that) {
case _FriendMatchInstruction() when $default != null:
return $default(_that.title,_that.detail);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _FriendMatchInstruction implements FriendMatchInstruction {
  const _FriendMatchInstruction({required this.title, required this.detail});
  factory _FriendMatchInstruction.fromJson(Map<String, dynamic> json) => _$FriendMatchInstructionFromJson(json);

@override final  String title;
@override final  String detail;

/// Create a copy of FriendMatchInstruction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendMatchInstructionCopyWith<_FriendMatchInstruction> get copyWith => __$FriendMatchInstructionCopyWithImpl<_FriendMatchInstruction>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendMatchInstruction&&(identical(other.title, title) || other.title == title)&&(identical(other.detail, detail) || other.detail == detail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,title,detail);
}

@override
String toString() {
    return 'FriendMatchInstruction(title: $title, detail: $detail)';
}


}

/// @nodoc
abstract mixin class _$FriendMatchInstructionCopyWith<$Res> implements $FriendMatchInstructionCopyWith<$Res> {
  factory _$FriendMatchInstructionCopyWith(_FriendMatchInstruction value, $Res Function(_FriendMatchInstruction) _then) = __$FriendMatchInstructionCopyWithImpl;
@override @useResult
$Res call({
 String title, String detail
});




}
/// @nodoc
class __$FriendMatchInstructionCopyWithImpl<$Res>
    implements _$FriendMatchInstructionCopyWith<$Res> {
  __$FriendMatchInstructionCopyWithImpl(this._self, this._then);

  final _FriendMatchInstruction _self;
  final $Res Function(_FriendMatchInstruction) _then;

/// Create a copy of FriendMatchInstruction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? detail = null,}) {
  return _then(_FriendMatchInstruction(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ResultVerification {

@JsonKey(unknownEnumValue: VerificationPhase.notStarted) VerificationPhase get phase;@JsonKey(name: 'submittedResult') SubmittedResult? get submitted;@JsonKey(name: 'myScreenshot', readValue: _present) bool get myScreenshotSent;/// The screenshots this player sent, in game order.
 List<ResultScreenshot> get myScreenshots;@JsonKey(name: 'opponentScreenshotSubmitted') bool get opponentScreenshotSent; DateTime? get confirmationDeadline; DateTime? get screenshotDeadline;/// `agreed`, `confirmation_timeout`, `response_timeout`, ...
 String? get resolution;/// True only on the match that removed this player's entry.
 bool get entryRemoved;
/// Create a copy of ResultVerification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResultVerificationCopyWith<ResultVerification> get copyWith => _$ResultVerificationCopyWithImpl<ResultVerification>(this as ResultVerification, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ResultVerification;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResultVerification&&(identical(other.phase, _this.phase) || other.phase == _this.phase)&&(identical(other.submitted, _this.submitted) || other.submitted == _this.submitted)&&(identical(other.myScreenshotSent, _this.myScreenshotSent) || other.myScreenshotSent == _this.myScreenshotSent)&&const DeepCollectionEquality().equals(other.myScreenshots, _this.myScreenshots)&&(identical(other.opponentScreenshotSent, _this.opponentScreenshotSent) || other.opponentScreenshotSent == _this.opponentScreenshotSent)&&(identical(other.confirmationDeadline, _this.confirmationDeadline) || other.confirmationDeadline == _this.confirmationDeadline)&&(identical(other.screenshotDeadline, _this.screenshotDeadline) || other.screenshotDeadline == _this.screenshotDeadline)&&(identical(other.resolution, _this.resolution) || other.resolution == _this.resolution)&&(identical(other.entryRemoved, _this.entryRemoved) || other.entryRemoved == _this.entryRemoved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ResultVerification;
  return Object.hash(runtimeType,_this.phase,_this.submitted,_this.myScreenshotSent,const DeepCollectionEquality().hash(_this.myScreenshots),_this.opponentScreenshotSent,_this.confirmationDeadline,_this.screenshotDeadline,_this.resolution,_this.entryRemoved);
}

@override
String toString() {
  final _this = this as ResultVerification;
  return 'ResultVerification(phase: ${_this.phase}, submitted: ${_this.submitted}, myScreenshotSent: ${_this.myScreenshotSent}, myScreenshots: ${_this.myScreenshots}, opponentScreenshotSent: ${_this.opponentScreenshotSent}, confirmationDeadline: ${_this.confirmationDeadline}, screenshotDeadline: ${_this.screenshotDeadline}, resolution: ${_this.resolution}, entryRemoved: ${_this.entryRemoved})';
}


}

/// @nodoc
abstract mixin class $ResultVerificationCopyWith<$Res>  {
  factory $ResultVerificationCopyWith(ResultVerification value, $Res Function(ResultVerification) _then) = _$ResultVerificationCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: VerificationPhase.notStarted) VerificationPhase phase,@JsonKey(name: 'submittedResult') SubmittedResult? submitted,@JsonKey(name: 'myScreenshot', readValue: _present) bool myScreenshotSent, List<ResultScreenshot> myScreenshots,@JsonKey(name: 'opponentScreenshotSubmitted') bool opponentScreenshotSent, DateTime? confirmationDeadline, DateTime? screenshotDeadline, String? resolution, bool entryRemoved
});


$SubmittedResultCopyWith<$Res>? get submitted;

}
/// @nodoc
class _$ResultVerificationCopyWithImpl<$Res>
    implements $ResultVerificationCopyWith<$Res> {
  _$ResultVerificationCopyWithImpl(this._self, this._then);

  final ResultVerification _self;
  final $Res Function(ResultVerification) _then;

/// Create a copy of ResultVerification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? submitted = freezed,Object? myScreenshotSent = null,Object? myScreenshots = null,Object? opponentScreenshotSent = null,Object? confirmationDeadline = freezed,Object? screenshotDeadline = freezed,Object? resolution = freezed,Object? entryRemoved = null,}) {
  return _then(ResultVerification(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as VerificationPhase,submitted: freezed == submitted ? _self.submitted : submitted // ignore: cast_nullable_to_non_nullable
as SubmittedResult?,myScreenshotSent: null == myScreenshotSent ? _self.myScreenshotSent : myScreenshotSent // ignore: cast_nullable_to_non_nullable
as bool,myScreenshots: null == myScreenshots ? _self.myScreenshots : myScreenshots // ignore: cast_nullable_to_non_nullable
as List<ResultScreenshot>,opponentScreenshotSent: null == opponentScreenshotSent ? _self.opponentScreenshotSent : opponentScreenshotSent // ignore: cast_nullable_to_non_nullable
as bool,confirmationDeadline: freezed == confirmationDeadline ? _self.confirmationDeadline : confirmationDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,screenshotDeadline: freezed == screenshotDeadline ? _self.screenshotDeadline : screenshotDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,resolution: freezed == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as String?,entryRemoved: null == entryRemoved ? _self.entryRemoved : entryRemoved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ResultVerification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubmittedResultCopyWith<$Res>? get submitted {
    if (_self.submitted == null) {
    return null;
  }

  return $SubmittedResultCopyWith<$Res>(_self.submitted!, (value) {
    return _then(_self.copyWith(submitted: value));
  });
}
}


/// Adds pattern-matching-related methods to [ResultVerification].
extension ResultVerificationPatterns on ResultVerification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResultVerification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResultVerification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResultVerification value)  $default,){
final _that = this;
switch (_that) {
case _ResultVerification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResultVerification value)?  $default,){
final _that = this;
switch (_that) {
case _ResultVerification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: VerificationPhase.notStarted)  VerificationPhase phase, @JsonKey(name: 'submittedResult')  SubmittedResult? submitted, @JsonKey(name: 'myScreenshot', readValue: _present)  bool myScreenshotSent,  List<ResultScreenshot> myScreenshots, @JsonKey(name: 'opponentScreenshotSubmitted')  bool opponentScreenshotSent,  DateTime? confirmationDeadline,  DateTime? screenshotDeadline,  String? resolution,  bool entryRemoved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResultVerification() when $default != null:
return $default(_that.phase,_that.submitted,_that.myScreenshotSent,_that.myScreenshots,_that.opponentScreenshotSent,_that.confirmationDeadline,_that.screenshotDeadline,_that.resolution,_that.entryRemoved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: VerificationPhase.notStarted)  VerificationPhase phase, @JsonKey(name: 'submittedResult')  SubmittedResult? submitted, @JsonKey(name: 'myScreenshot', readValue: _present)  bool myScreenshotSent,  List<ResultScreenshot> myScreenshots, @JsonKey(name: 'opponentScreenshotSubmitted')  bool opponentScreenshotSent,  DateTime? confirmationDeadline,  DateTime? screenshotDeadline,  String? resolution,  bool entryRemoved)  $default,) {final _that = this;
switch (_that) {
case _ResultVerification():
return $default(_that.phase,_that.submitted,_that.myScreenshotSent,_that.myScreenshots,_that.opponentScreenshotSent,_that.confirmationDeadline,_that.screenshotDeadline,_that.resolution,_that.entryRemoved);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: VerificationPhase.notStarted)  VerificationPhase phase, @JsonKey(name: 'submittedResult')  SubmittedResult? submitted, @JsonKey(name: 'myScreenshot', readValue: _present)  bool myScreenshotSent,  List<ResultScreenshot> myScreenshots, @JsonKey(name: 'opponentScreenshotSubmitted')  bool opponentScreenshotSent,  DateTime? confirmationDeadline,  DateTime? screenshotDeadline,  String? resolution,  bool entryRemoved)?  $default,) {final _that = this;
switch (_that) {
case _ResultVerification() when $default != null:
return $default(_that.phase,_that.submitted,_that.myScreenshotSent,_that.myScreenshots,_that.opponentScreenshotSent,_that.confirmationDeadline,_that.screenshotDeadline,_that.resolution,_that.entryRemoved);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _ResultVerification implements ResultVerification {
  const _ResultVerification({@JsonKey(unknownEnumValue: VerificationPhase.notStarted) this.phase = VerificationPhase.notStarted, @JsonKey(name: 'submittedResult') this.submitted, @JsonKey(name: 'myScreenshot', readValue: _present) this.myScreenshotSent = false,  List<ResultScreenshot> myScreenshots = const <ResultScreenshot>[], @JsonKey(name: 'opponentScreenshotSubmitted') this.opponentScreenshotSent = false, this.confirmationDeadline, this.screenshotDeadline, this.resolution, this.entryRemoved = false}): _myScreenshots = myScreenshots;
  factory _ResultVerification.fromJson(Map<String, dynamic> json) => _$ResultVerificationFromJson(json);

@override@JsonKey(unknownEnumValue: VerificationPhase.notStarted) final  VerificationPhase phase;
@override@JsonKey(name: 'submittedResult') final  SubmittedResult? submitted;
@override@JsonKey(name: 'myScreenshot', readValue: _present) final  bool myScreenshotSent;
/// The screenshots this player sent, in game order.
 final  List<ResultScreenshot> _myScreenshots;
/// The screenshots this player sent, in game order.
@override@JsonKey() List<ResultScreenshot> get myScreenshots {
  if (_myScreenshots is EqualUnmodifiableListView) return _myScreenshots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_myScreenshots);
}

@override@JsonKey(name: 'opponentScreenshotSubmitted') final  bool opponentScreenshotSent;
@override final  DateTime? confirmationDeadline;
@override final  DateTime? screenshotDeadline;
/// `agreed`, `confirmation_timeout`, `response_timeout`, ...
@override final  String? resolution;
/// True only on the match that removed this player's entry.
@override@JsonKey() final  bool entryRemoved;

/// Create a copy of ResultVerification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResultVerificationCopyWith<_ResultVerification> get copyWith => __$ResultVerificationCopyWithImpl<_ResultVerification>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResultVerification&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.submitted, submitted) || other.submitted == submitted)&&(identical(other.myScreenshotSent, myScreenshotSent) || other.myScreenshotSent == myScreenshotSent)&&const DeepCollectionEquality().equals(other.myScreenshots, _myScreenshots)&&(identical(other.opponentScreenshotSent, opponentScreenshotSent) || other.opponentScreenshotSent == opponentScreenshotSent)&&(identical(other.confirmationDeadline, confirmationDeadline) || other.confirmationDeadline == confirmationDeadline)&&(identical(other.screenshotDeadline, screenshotDeadline) || other.screenshotDeadline == screenshotDeadline)&&(identical(other.resolution, resolution) || other.resolution == resolution)&&(identical(other.entryRemoved, entryRemoved) || other.entryRemoved == entryRemoved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,phase,submitted,myScreenshotSent,const DeepCollectionEquality().hash(_myScreenshots),opponentScreenshotSent,confirmationDeadline,screenshotDeadline,resolution,entryRemoved);
}

@override
String toString() {
    return 'ResultVerification(phase: $phase, submitted: $submitted, myScreenshotSent: $myScreenshotSent, myScreenshots: $myScreenshots, opponentScreenshotSent: $opponentScreenshotSent, confirmationDeadline: $confirmationDeadline, screenshotDeadline: $screenshotDeadline, resolution: $resolution, entryRemoved: $entryRemoved)';
}


}

/// @nodoc
abstract mixin class _$ResultVerificationCopyWith<$Res> implements $ResultVerificationCopyWith<$Res> {
  factory _$ResultVerificationCopyWith(_ResultVerification value, $Res Function(_ResultVerification) _then) = __$ResultVerificationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: VerificationPhase.notStarted) VerificationPhase phase,@JsonKey(name: 'submittedResult') SubmittedResult? submitted,@JsonKey(name: 'myScreenshot', readValue: _present) bool myScreenshotSent, List<ResultScreenshot> myScreenshots,@JsonKey(name: 'opponentScreenshotSubmitted') bool opponentScreenshotSent, DateTime? confirmationDeadline, DateTime? screenshotDeadline, String? resolution, bool entryRemoved
});


@override $SubmittedResultCopyWith<$Res>? get submitted;

}
/// @nodoc
class __$ResultVerificationCopyWithImpl<$Res>
    implements _$ResultVerificationCopyWith<$Res> {
  __$ResultVerificationCopyWithImpl(this._self, this._then);

  final _ResultVerification _self;
  final $Res Function(_ResultVerification) _then;

/// Create a copy of ResultVerification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? submitted = freezed,Object? myScreenshotSent = null,Object? myScreenshots = null,Object? opponentScreenshotSent = null,Object? confirmationDeadline = freezed,Object? screenshotDeadline = freezed,Object? resolution = freezed,Object? entryRemoved = null,}) {
  return _then(_ResultVerification(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as VerificationPhase,submitted: freezed == submitted ? _self.submitted : submitted // ignore: cast_nullable_to_non_nullable
as SubmittedResult?,myScreenshotSent: null == myScreenshotSent ? _self.myScreenshotSent : myScreenshotSent // ignore: cast_nullable_to_non_nullable
as bool,myScreenshots: null == myScreenshots ? _self._myScreenshots : myScreenshots // ignore: cast_nullable_to_non_nullable
as List<ResultScreenshot>,opponentScreenshotSent: null == opponentScreenshotSent ? _self.opponentScreenshotSent : opponentScreenshotSent // ignore: cast_nullable_to_non_nullable
as bool,confirmationDeadline: freezed == confirmationDeadline ? _self.confirmationDeadline : confirmationDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,screenshotDeadline: freezed == screenshotDeadline ? _self.screenshotDeadline : screenshotDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,resolution: freezed == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as String?,entryRemoved: null == entryRemoved ? _self.entryRemoved : entryRemoved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ResultVerification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubmittedResultCopyWith<$Res>? get submitted {
    if (_self.submitted == null) {
    return null;
  }

  return $SubmittedResultCopyWith<$Res>(_self.submitted!, (value) {
    return _then(_self.copyWith(submitted: value));
  });
}
}


/// @nodoc
mixin _$ResultScreenshot {

/// The game it shows; 1 for a best of 1.
 int get game; String get evidenceId;
/// Create a copy of ResultScreenshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResultScreenshotCopyWith<ResultScreenshot> get copyWith => _$ResultScreenshotCopyWithImpl<ResultScreenshot>(this as ResultScreenshot, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ResultScreenshot;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResultScreenshot&&(identical(other.game, _this.game) || other.game == _this.game)&&(identical(other.evidenceId, _this.evidenceId) || other.evidenceId == _this.evidenceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ResultScreenshot;
  return Object.hash(runtimeType,_this.game,_this.evidenceId);
}

@override
String toString() {
  final _this = this as ResultScreenshot;
  return 'ResultScreenshot(game: ${_this.game}, evidenceId: ${_this.evidenceId})';
}


}

/// @nodoc
abstract mixin class $ResultScreenshotCopyWith<$Res>  {
  factory $ResultScreenshotCopyWith(ResultScreenshot value, $Res Function(ResultScreenshot) _then) = _$ResultScreenshotCopyWithImpl;
@useResult
$Res call({
 int game, String evidenceId
});




}
/// @nodoc
class _$ResultScreenshotCopyWithImpl<$Res>
    implements $ResultScreenshotCopyWith<$Res> {
  _$ResultScreenshotCopyWithImpl(this._self, this._then);

  final ResultScreenshot _self;
  final $Res Function(ResultScreenshot) _then;

/// Create a copy of ResultScreenshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? game = null,Object? evidenceId = null,}) {
  return _then(ResultScreenshot(
game: null == game ? _self.game : game // ignore: cast_nullable_to_non_nullable
as int,evidenceId: null == evidenceId ? _self.evidenceId : evidenceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ResultScreenshot].
extension ResultScreenshotPatterns on ResultScreenshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResultScreenshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResultScreenshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResultScreenshot value)  $default,){
final _that = this;
switch (_that) {
case _ResultScreenshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResultScreenshot value)?  $default,){
final _that = this;
switch (_that) {
case _ResultScreenshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int game,  String evidenceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResultScreenshot() when $default != null:
return $default(_that.game,_that.evidenceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int game,  String evidenceId)  $default,) {final _that = this;
switch (_that) {
case _ResultScreenshot():
return $default(_that.game,_that.evidenceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int game,  String evidenceId)?  $default,) {final _that = this;
switch (_that) {
case _ResultScreenshot() when $default != null:
return $default(_that.game,_that.evidenceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _ResultScreenshot implements ResultScreenshot {
  const _ResultScreenshot({this.game = 1, required this.evidenceId});
  factory _ResultScreenshot.fromJson(Map<String, dynamic> json) => _$ResultScreenshotFromJson(json);

/// The game it shows; 1 for a best of 1.
@override@JsonKey() final  int game;
@override final  String evidenceId;

/// Create a copy of ResultScreenshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResultScreenshotCopyWith<_ResultScreenshot> get copyWith => __$ResultScreenshotCopyWithImpl<_ResultScreenshot>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResultScreenshot&&(identical(other.game, game) || other.game == game)&&(identical(other.evidenceId, evidenceId) || other.evidenceId == evidenceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,game,evidenceId);
}

@override
String toString() {
    return 'ResultScreenshot(game: $game, evidenceId: $evidenceId)';
}


}

/// @nodoc
abstract mixin class _$ResultScreenshotCopyWith<$Res> implements $ResultScreenshotCopyWith<$Res> {
  factory _$ResultScreenshotCopyWith(_ResultScreenshot value, $Res Function(_ResultScreenshot) _then) = __$ResultScreenshotCopyWithImpl;
@override @useResult
$Res call({
 int game, String evidenceId
});




}
/// @nodoc
class __$ResultScreenshotCopyWithImpl<$Res>
    implements _$ResultScreenshotCopyWith<$Res> {
  __$ResultScreenshotCopyWithImpl(this._self, this._then);

  final _ResultScreenshot _self;
  final $Res Function(_ResultScreenshot) _then;

/// Create a copy of ResultScreenshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? game = null,Object? evidenceId = null,}) {
  return _then(_ResultScreenshot(
game: null == game ? _self.game : game // ignore: cast_nullable_to_non_nullable
as int,evidenceId: null == evidenceId ? _self.evidenceId : evidenceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Score {

@JsonKey(name: 'homeScore') int get home;@JsonKey(name: 'awayScore') int get away;@JsonKey(name: 'tiebreak') Score? get penalties;
/// Create a copy of Score
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoreCopyWith<Score> get copyWith => _$ScoreCopyWithImpl<Score>(this as Score, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Score;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Score&&(identical(other.home, _this.home) || other.home == _this.home)&&(identical(other.away, _this.away) || other.away == _this.away)&&(identical(other.penalties, _this.penalties) || other.penalties == _this.penalties));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Score;
  return Object.hash(runtimeType,_this.home,_this.away,_this.penalties);
}

@override
String toString() {
  final _this = this as Score;
  return 'Score(home: ${_this.home}, away: ${_this.away}, penalties: ${_this.penalties})';
}


}

/// @nodoc
abstract mixin class $ScoreCopyWith<$Res>  {
  factory $ScoreCopyWith(Score value, $Res Function(Score) _then) = _$ScoreCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'homeScore') int home,@JsonKey(name: 'awayScore') int away,@JsonKey(name: 'tiebreak') Score? penalties
});


$ScoreCopyWith<$Res>? get penalties;

}
/// @nodoc
class _$ScoreCopyWithImpl<$Res>
    implements $ScoreCopyWith<$Res> {
  _$ScoreCopyWithImpl(this._self, this._then);

  final Score _self;
  final $Res Function(Score) _then;

/// Create a copy of Score
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? home = null,Object? away = null,Object? penalties = freezed,}) {
  return _then(Score(
null == home ? _self.home : home // ignore: cast_nullable_to_non_nullable
as int,null == away ? _self.away : away // ignore: cast_nullable_to_non_nullable
as int,penalties: freezed == penalties ? _self.penalties : penalties // ignore: cast_nullable_to_non_nullable
as Score?,
  ));
}
/// Create a copy of Score
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoreCopyWith<$Res>? get penalties {
    if (_self.penalties == null) {
    return null;
  }

  return $ScoreCopyWith<$Res>(_self.penalties!, (value) {
    return _then(_self.copyWith(penalties: value));
  });
}
}


/// Adds pattern-matching-related methods to [Score].
extension ScorePatterns on Score {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Score value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Score() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Score value)  $default,){
final _that = this;
switch (_that) {
case _Score():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Score value)?  $default,){
final _that = this;
switch (_that) {
case _Score() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'homeScore')  int home, @JsonKey(name: 'awayScore')  int away, @JsonKey(name: 'tiebreak')  Score? penalties)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Score() when $default != null:
return $default(_that.home,_that.away,_that.penalties);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'homeScore')  int home, @JsonKey(name: 'awayScore')  int away, @JsonKey(name: 'tiebreak')  Score? penalties)  $default,) {final _that = this;
switch (_that) {
case _Score():
return $default(_that.home,_that.away,_that.penalties);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'homeScore')  int home, @JsonKey(name: 'awayScore')  int away, @JsonKey(name: 'tiebreak')  Score? penalties)?  $default,) {final _that = this;
switch (_that) {
case _Score() when $default != null:
return $default(_that.home,_that.away,_that.penalties);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _Score extends Score {
  const _Score(@JsonKey(name: 'homeScore') this.home, @JsonKey(name: 'awayScore') this.away, {@JsonKey(name: 'tiebreak') this.penalties}): super._();
  factory _Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);

@override@JsonKey(name: 'homeScore') final  int home;
@override@JsonKey(name: 'awayScore') final  int away;
@override@JsonKey(name: 'tiebreak') final  Score? penalties;

/// Create a copy of Score
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoreCopyWith<_Score> get copyWith => __$ScoreCopyWithImpl<_Score>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Score&&(identical(other.home, home) || other.home == home)&&(identical(other.away, away) || other.away == away)&&(identical(other.penalties, penalties) || other.penalties == penalties));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,home,away,penalties);
}

@override
String toString() {
    return 'Score(home: $home, away: $away, penalties: $penalties)';
}


}

/// @nodoc
abstract mixin class _$ScoreCopyWith<$Res> implements $ScoreCopyWith<$Res> {
  factory _$ScoreCopyWith(_Score value, $Res Function(_Score) _then) = __$ScoreCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'homeScore') int home,@JsonKey(name: 'awayScore') int away,@JsonKey(name: 'tiebreak') Score? penalties
});


@override $ScoreCopyWith<$Res>? get penalties;

}
/// @nodoc
class __$ScoreCopyWithImpl<$Res>
    implements _$ScoreCopyWith<$Res> {
  __$ScoreCopyWithImpl(this._self, this._then);

  final _Score _self;
  final $Res Function(_Score) _then;

/// Create a copy of Score
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? home = null,Object? away = null,Object? penalties = freezed,}) {
  return _then(_Score(
null == home ? _self.home : home // ignore: cast_nullable_to_non_nullable
as int,null == away ? _self.away : away // ignore: cast_nullable_to_non_nullable
as int,penalties: freezed == penalties ? _self.penalties : penalties // ignore: cast_nullable_to_non_nullable
as Score?,
  ));
}

/// Create a copy of Score
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoreCopyWith<$Res>? get penalties {
    if (_self.penalties == null) {
    return null;
  }

  return $ScoreCopyWith<$Res>(_self.penalties!, (value) {
    return _then(_self.copyWith(penalties: value));
  });
}
}


/// @nodoc
mixin _$SubmittedResult {

@JsonKey(readValue: _whole) Score get score;/// Every game of a series, in order; empty for a best of 1.
 List<Score> get games;@JsonKey(name: 'submittedByMe') bool get byMe;@JsonKey(name: 'submittedAt') DateTime get at;
/// Create a copy of SubmittedResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmittedResultCopyWith<SubmittedResult> get copyWith => _$SubmittedResultCopyWithImpl<SubmittedResult>(this as SubmittedResult, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SubmittedResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmittedResult&&(identical(other.score, _this.score) || other.score == _this.score)&&const DeepCollectionEquality().equals(other.games, _this.games)&&(identical(other.byMe, _this.byMe) || other.byMe == _this.byMe)&&(identical(other.at, _this.at) || other.at == _this.at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubmittedResult;
  return Object.hash(runtimeType,_this.score,const DeepCollectionEquality().hash(_this.games),_this.byMe,_this.at);
}

@override
String toString() {
  final _this = this as SubmittedResult;
  return 'SubmittedResult(score: ${_this.score}, games: ${_this.games}, byMe: ${_this.byMe}, at: ${_this.at})';
}


}

/// @nodoc
abstract mixin class $SubmittedResultCopyWith<$Res>  {
  factory $SubmittedResultCopyWith(SubmittedResult value, $Res Function(SubmittedResult) _then) = _$SubmittedResultCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _whole) Score score, List<Score> games,@JsonKey(name: 'submittedByMe') bool byMe,@JsonKey(name: 'submittedAt') DateTime at
});


$ScoreCopyWith<$Res> get score;

}
/// @nodoc
class _$SubmittedResultCopyWithImpl<$Res>
    implements $SubmittedResultCopyWith<$Res> {
  _$SubmittedResultCopyWithImpl(this._self, this._then);

  final SubmittedResult _self;
  final $Res Function(SubmittedResult) _then;

/// Create a copy of SubmittedResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? score = null,Object? games = null,Object? byMe = null,Object? at = null,}) {
  return _then(SubmittedResult(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as Score,games: null == games ? _self.games : games // ignore: cast_nullable_to_non_nullable
as List<Score>,byMe: null == byMe ? _self.byMe : byMe // ignore: cast_nullable_to_non_nullable
as bool,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of SubmittedResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoreCopyWith<$Res> get score {
  
  return $ScoreCopyWith<$Res>(_self.score, (value) {
    return _then(_self.copyWith(score: value));
  });
}
}


/// Adds pattern-matching-related methods to [SubmittedResult].
extension SubmittedResultPatterns on SubmittedResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubmittedResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubmittedResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubmittedResult value)  $default,){
final _that = this;
switch (_that) {
case _SubmittedResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubmittedResult value)?  $default,){
final _that = this;
switch (_that) {
case _SubmittedResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _whole)  Score score,  List<Score> games, @JsonKey(name: 'submittedByMe')  bool byMe, @JsonKey(name: 'submittedAt')  DateTime at)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubmittedResult() when $default != null:
return $default(_that.score,_that.games,_that.byMe,_that.at);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _whole)  Score score,  List<Score> games, @JsonKey(name: 'submittedByMe')  bool byMe, @JsonKey(name: 'submittedAt')  DateTime at)  $default,) {final _that = this;
switch (_that) {
case _SubmittedResult():
return $default(_that.score,_that.games,_that.byMe,_that.at);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _whole)  Score score,  List<Score> games, @JsonKey(name: 'submittedByMe')  bool byMe, @JsonKey(name: 'submittedAt')  DateTime at)?  $default,) {final _that = this;
switch (_that) {
case _SubmittedResult() when $default != null:
return $default(_that.score,_that.games,_that.byMe,_that.at);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _SubmittedResult implements SubmittedResult {
  const _SubmittedResult({@JsonKey(readValue: _whole) required this.score,  List<Score> games = const <Score>[], @JsonKey(name: 'submittedByMe') required this.byMe, @JsonKey(name: 'submittedAt') required this.at}): _games = games;
  factory _SubmittedResult.fromJson(Map<String, dynamic> json) => _$SubmittedResultFromJson(json);

@override@JsonKey(readValue: _whole) final  Score score;
/// Every game of a series, in order; empty for a best of 1.
 final  List<Score> _games;
/// Every game of a series, in order; empty for a best of 1.
@override@JsonKey() List<Score> get games {
  if (_games is EqualUnmodifiableListView) return _games;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_games);
}

@override@JsonKey(name: 'submittedByMe') final  bool byMe;
@override@JsonKey(name: 'submittedAt') final  DateTime at;

/// Create a copy of SubmittedResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmittedResultCopyWith<_SubmittedResult> get copyWith => __$SubmittedResultCopyWithImpl<_SubmittedResult>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmittedResult&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other.games, _games)&&(identical(other.byMe, byMe) || other.byMe == byMe)&&(identical(other.at, at) || other.at == at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,score,const DeepCollectionEquality().hash(_games),byMe,at);
}

@override
String toString() {
    return 'SubmittedResult(score: $score, games: $games, byMe: $byMe, at: $at)';
}


}

/// @nodoc
abstract mixin class _$SubmittedResultCopyWith<$Res> implements $SubmittedResultCopyWith<$Res> {
  factory _$SubmittedResultCopyWith(_SubmittedResult value, $Res Function(_SubmittedResult) _then) = __$SubmittedResultCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _whole) Score score, List<Score> games,@JsonKey(name: 'submittedByMe') bool byMe,@JsonKey(name: 'submittedAt') DateTime at
});


@override $ScoreCopyWith<$Res> get score;

}
/// @nodoc
class __$SubmittedResultCopyWithImpl<$Res>
    implements _$SubmittedResultCopyWith<$Res> {
  __$SubmittedResultCopyWithImpl(this._self, this._then);

  final _SubmittedResult _self;
  final $Res Function(_SubmittedResult) _then;

/// Create a copy of SubmittedResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? score = null,Object? games = null,Object? byMe = null,Object? at = null,}) {
  return _then(_SubmittedResult(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as Score,games: null == games ? _self._games : games // ignore: cast_nullable_to_non_nullable
as List<Score>,byMe: null == byMe ? _self.byMe : byMe // ignore: cast_nullable_to_non_nullable
as bool,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of SubmittedResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoreCopyWith<$Res> get score {
  
  return $ScoreCopyWith<$Res>(_self.score, (value) {
    return _then(_self.copyWith(score: value));
  });
}
}


/// @nodoc
mixin _$ConfirmedResult {

@JsonKey(readValue: _whole) Score get score;/// Every game of a series, in order; empty for a best of 1.
 List<Score> get games;/// `agreed_reports`, `unanswered`, `platform_review` or `legacy`.
 String get origin;
/// Create a copy of ConfirmedResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfirmedResultCopyWith<ConfirmedResult> get copyWith => _$ConfirmedResultCopyWithImpl<ConfirmedResult>(this as ConfirmedResult, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ConfirmedResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfirmedResult&&(identical(other.score, _this.score) || other.score == _this.score)&&const DeepCollectionEquality().equals(other.games, _this.games)&&(identical(other.origin, _this.origin) || other.origin == _this.origin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ConfirmedResult;
  return Object.hash(runtimeType,_this.score,const DeepCollectionEquality().hash(_this.games),_this.origin);
}

@override
String toString() {
  final _this = this as ConfirmedResult;
  return 'ConfirmedResult(score: ${_this.score}, games: ${_this.games}, origin: ${_this.origin})';
}


}

/// @nodoc
abstract mixin class $ConfirmedResultCopyWith<$Res>  {
  factory $ConfirmedResultCopyWith(ConfirmedResult value, $Res Function(ConfirmedResult) _then) = _$ConfirmedResultCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _whole) Score score, List<Score> games, String origin
});


$ScoreCopyWith<$Res> get score;

}
/// @nodoc
class _$ConfirmedResultCopyWithImpl<$Res>
    implements $ConfirmedResultCopyWith<$Res> {
  _$ConfirmedResultCopyWithImpl(this._self, this._then);

  final ConfirmedResult _self;
  final $Res Function(ConfirmedResult) _then;

/// Create a copy of ConfirmedResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? score = null,Object? games = null,Object? origin = null,}) {
  return _then(ConfirmedResult(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as Score,games: null == games ? _self.games : games // ignore: cast_nullable_to_non_nullable
as List<Score>,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of ConfirmedResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoreCopyWith<$Res> get score {
  
  return $ScoreCopyWith<$Res>(_self.score, (value) {
    return _then(_self.copyWith(score: value));
  });
}
}


/// Adds pattern-matching-related methods to [ConfirmedResult].
extension ConfirmedResultPatterns on ConfirmedResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConfirmedResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConfirmedResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConfirmedResult value)  $default,){
final _that = this;
switch (_that) {
case _ConfirmedResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConfirmedResult value)?  $default,){
final _that = this;
switch (_that) {
case _ConfirmedResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _whole)  Score score,  List<Score> games,  String origin)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConfirmedResult() when $default != null:
return $default(_that.score,_that.games,_that.origin);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _whole)  Score score,  List<Score> games,  String origin)  $default,) {final _that = this;
switch (_that) {
case _ConfirmedResult():
return $default(_that.score,_that.games,_that.origin);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _whole)  Score score,  List<Score> games,  String origin)?  $default,) {final _that = this;
switch (_that) {
case _ConfirmedResult() when $default != null:
return $default(_that.score,_that.games,_that.origin);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _ConfirmedResult implements ConfirmedResult {
  const _ConfirmedResult({@JsonKey(readValue: _whole) required this.score,  List<Score> games = const <Score>[], required this.origin}): _games = games;
  factory _ConfirmedResult.fromJson(Map<String, dynamic> json) => _$ConfirmedResultFromJson(json);

@override@JsonKey(readValue: _whole) final  Score score;
/// Every game of a series, in order; empty for a best of 1.
 final  List<Score> _games;
/// Every game of a series, in order; empty for a best of 1.
@override@JsonKey() List<Score> get games {
  if (_games is EqualUnmodifiableListView) return _games;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_games);
}

/// `agreed_reports`, `unanswered`, `platform_review` or `legacy`.
@override final  String origin;

/// Create a copy of ConfirmedResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfirmedResultCopyWith<_ConfirmedResult> get copyWith => __$ConfirmedResultCopyWithImpl<_ConfirmedResult>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmedResult&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other.games, _games)&&(identical(other.origin, origin) || other.origin == origin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,score,const DeepCollectionEquality().hash(_games),origin);
}

@override
String toString() {
    return 'ConfirmedResult(score: $score, games: $games, origin: $origin)';
}


}

/// @nodoc
abstract mixin class _$ConfirmedResultCopyWith<$Res> implements $ConfirmedResultCopyWith<$Res> {
  factory _$ConfirmedResultCopyWith(_ConfirmedResult value, $Res Function(_ConfirmedResult) _then) = __$ConfirmedResultCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _whole) Score score, List<Score> games, String origin
});


@override $ScoreCopyWith<$Res> get score;

}
/// @nodoc
class __$ConfirmedResultCopyWithImpl<$Res>
    implements _$ConfirmedResultCopyWith<$Res> {
  __$ConfirmedResultCopyWithImpl(this._self, this._then);

  final _ConfirmedResult _self;
  final $Res Function(_ConfirmedResult) _then;

/// Create a copy of ConfirmedResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? score = null,Object? games = null,Object? origin = null,}) {
  return _then(_ConfirmedResult(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as Score,games: null == games ? _self._games : games // ignore: cast_nullable_to_non_nullable
as List<Score>,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of ConfirmedResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoreCopyWith<$Res> get score {
  
  return $ScoreCopyWith<$Res>(_self.score, (value) {
    return _then(_self.copyWith(score: value));
  });
}
}


/// @nodoc
mixin _$VerificationWindows {

/// The opponent's time to confirm or reject a submitted result.
@JsonKey(name: 'reportWindowSeconds', fromJson: _seconds) Duration get confirm;/// Each side's time to send its screenshots after a rejection.
@JsonKey(name: 'responseWindowSeconds', fromJson: _seconds) Duration get screenshot;/// A series' dispute takes one screenshot per game, numbered by game.
@JsonKey(name: 'screenshotEvidence', readValue: _perGame) bool get perGameScreenshots;
/// Create a copy of VerificationWindows
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerificationWindowsCopyWith<VerificationWindows> get copyWith => _$VerificationWindowsCopyWithImpl<VerificationWindows>(this as VerificationWindows, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as VerificationWindows;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerificationWindows&&(identical(other.confirm, _this.confirm) || other.confirm == _this.confirm)&&(identical(other.screenshot, _this.screenshot) || other.screenshot == _this.screenshot)&&(identical(other.perGameScreenshots, _this.perGameScreenshots) || other.perGameScreenshots == _this.perGameScreenshots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VerificationWindows;
  return Object.hash(runtimeType,_this.confirm,_this.screenshot,_this.perGameScreenshots);
}

@override
String toString() {
  final _this = this as VerificationWindows;
  return 'VerificationWindows(confirm: ${_this.confirm}, screenshot: ${_this.screenshot}, perGameScreenshots: ${_this.perGameScreenshots})';
}


}

/// @nodoc
abstract mixin class $VerificationWindowsCopyWith<$Res>  {
  factory $VerificationWindowsCopyWith(VerificationWindows value, $Res Function(VerificationWindows) _then) = _$VerificationWindowsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'reportWindowSeconds', fromJson: _seconds) Duration confirm,@JsonKey(name: 'responseWindowSeconds', fromJson: _seconds) Duration screenshot,@JsonKey(name: 'screenshotEvidence', readValue: _perGame) bool perGameScreenshots
});




}
/// @nodoc
class _$VerificationWindowsCopyWithImpl<$Res>
    implements $VerificationWindowsCopyWith<$Res> {
  _$VerificationWindowsCopyWithImpl(this._self, this._then);

  final VerificationWindows _self;
  final $Res Function(VerificationWindows) _then;

/// Create a copy of VerificationWindows
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? confirm = null,Object? screenshot = null,Object? perGameScreenshots = null,}) {
  return _then(VerificationWindows(
confirm: null == confirm ? _self.confirm : confirm // ignore: cast_nullable_to_non_nullable
as Duration,screenshot: null == screenshot ? _self.screenshot : screenshot // ignore: cast_nullable_to_non_nullable
as Duration,perGameScreenshots: null == perGameScreenshots ? _self.perGameScreenshots : perGameScreenshots // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VerificationWindows].
extension VerificationWindowsPatterns on VerificationWindows {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerificationWindows value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerificationWindows() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerificationWindows value)  $default,){
final _that = this;
switch (_that) {
case _VerificationWindows():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerificationWindows value)?  $default,){
final _that = this;
switch (_that) {
case _VerificationWindows() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'reportWindowSeconds', fromJson: _seconds)  Duration confirm, @JsonKey(name: 'responseWindowSeconds', fromJson: _seconds)  Duration screenshot, @JsonKey(name: 'screenshotEvidence', readValue: _perGame)  bool perGameScreenshots)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerificationWindows() when $default != null:
return $default(_that.confirm,_that.screenshot,_that.perGameScreenshots);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'reportWindowSeconds', fromJson: _seconds)  Duration confirm, @JsonKey(name: 'responseWindowSeconds', fromJson: _seconds)  Duration screenshot, @JsonKey(name: 'screenshotEvidence', readValue: _perGame)  bool perGameScreenshots)  $default,) {final _that = this;
switch (_that) {
case _VerificationWindows():
return $default(_that.confirm,_that.screenshot,_that.perGameScreenshots);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'reportWindowSeconds', fromJson: _seconds)  Duration confirm, @JsonKey(name: 'responseWindowSeconds', fromJson: _seconds)  Duration screenshot, @JsonKey(name: 'screenshotEvidence', readValue: _perGame)  bool perGameScreenshots)?  $default,) {final _that = this;
switch (_that) {
case _VerificationWindows() when $default != null:
return $default(_that.confirm,_that.screenshot,_that.perGameScreenshots);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _VerificationWindows implements VerificationWindows {
  const _VerificationWindows({@JsonKey(name: 'reportWindowSeconds', fromJson: _seconds) this.confirm = const Duration(minutes: 10), @JsonKey(name: 'responseWindowSeconds', fromJson: _seconds) this.screenshot = const Duration(minutes: 10), @JsonKey(name: 'screenshotEvidence', readValue: _perGame) this.perGameScreenshots = false});
  factory _VerificationWindows.fromJson(Map<String, dynamic> json) => _$VerificationWindowsFromJson(json);

/// The opponent's time to confirm or reject a submitted result.
@override@JsonKey(name: 'reportWindowSeconds', fromJson: _seconds) final  Duration confirm;
/// Each side's time to send its screenshots after a rejection.
@override@JsonKey(name: 'responseWindowSeconds', fromJson: _seconds) final  Duration screenshot;
/// A series' dispute takes one screenshot per game, numbered by game.
@override@JsonKey(name: 'screenshotEvidence', readValue: _perGame) final  bool perGameScreenshots;

/// Create a copy of VerificationWindows
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerificationWindowsCopyWith<_VerificationWindows> get copyWith => __$VerificationWindowsCopyWithImpl<_VerificationWindows>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerificationWindows&&(identical(other.confirm, confirm) || other.confirm == confirm)&&(identical(other.screenshot, screenshot) || other.screenshot == screenshot)&&(identical(other.perGameScreenshots, perGameScreenshots) || other.perGameScreenshots == perGameScreenshots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,confirm,screenshot,perGameScreenshots);
}

@override
String toString() {
    return 'VerificationWindows(confirm: $confirm, screenshot: $screenshot, perGameScreenshots: $perGameScreenshots)';
}


}

/// @nodoc
abstract mixin class _$VerificationWindowsCopyWith<$Res> implements $VerificationWindowsCopyWith<$Res> {
  factory _$VerificationWindowsCopyWith(_VerificationWindows value, $Res Function(_VerificationWindows) _then) = __$VerificationWindowsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'reportWindowSeconds', fromJson: _seconds) Duration confirm,@JsonKey(name: 'responseWindowSeconds', fromJson: _seconds) Duration screenshot,@JsonKey(name: 'screenshotEvidence', readValue: _perGame) bool perGameScreenshots
});




}
/// @nodoc
class __$VerificationWindowsCopyWithImpl<$Res>
    implements _$VerificationWindowsCopyWith<$Res> {
  __$VerificationWindowsCopyWithImpl(this._self, this._then);

  final _VerificationWindows _self;
  final $Res Function(_VerificationWindows) _then;

/// Create a copy of VerificationWindows
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? confirm = null,Object? screenshot = null,Object? perGameScreenshots = null,}) {
  return _then(_VerificationWindows(
confirm: null == confirm ? _self.confirm : confirm // ignore: cast_nullable_to_non_nullable
as Duration,screenshot: null == screenshot ? _self.screenshot : screenshot // ignore: cast_nullable_to_non_nullable
as Duration,perGameScreenshots: null == perGameScreenshots ? _self.perGameScreenshots : perGameScreenshots // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
