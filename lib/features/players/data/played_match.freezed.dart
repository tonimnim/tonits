// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'played_match.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlayedMatch {

 String get matchId; DateTime get playedAt;/// Null when the opponent's profile is no longer public.
@JsonKey(readValue: _opponentName) String? get opponentName;@JsonKey(readValue: _goalsFor) int get goalsFor;@JsonKey(readValue: _goalsAgainst) int get goalsAgainst;@JsonKey(name: 'outcome', unknownEnumValue: MatchResult.draw) MatchResult get result;@JsonKey(readValue: _competitionName) String get competitionName; String get stage;
/// Create a copy of PlayedMatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayedMatchCopyWith<PlayedMatch> get copyWith => _$PlayedMatchCopyWithImpl<PlayedMatch>(this as PlayedMatch, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PlayedMatch;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayedMatch&&(identical(other.matchId, _this.matchId) || other.matchId == _this.matchId)&&(identical(other.playedAt, _this.playedAt) || other.playedAt == _this.playedAt)&&(identical(other.opponentName, _this.opponentName) || other.opponentName == _this.opponentName)&&(identical(other.goalsFor, _this.goalsFor) || other.goalsFor == _this.goalsFor)&&(identical(other.goalsAgainst, _this.goalsAgainst) || other.goalsAgainst == _this.goalsAgainst)&&(identical(other.result, _this.result) || other.result == _this.result)&&(identical(other.competitionName, _this.competitionName) || other.competitionName == _this.competitionName)&&(identical(other.stage, _this.stage) || other.stage == _this.stage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlayedMatch;
  return Object.hash(runtimeType,_this.matchId,_this.playedAt,_this.opponentName,_this.goalsFor,_this.goalsAgainst,_this.result,_this.competitionName,_this.stage);
}

@override
String toString() {
  final _this = this as PlayedMatch;
  return 'PlayedMatch(matchId: ${_this.matchId}, playedAt: ${_this.playedAt}, opponentName: ${_this.opponentName}, goalsFor: ${_this.goalsFor}, goalsAgainst: ${_this.goalsAgainst}, result: ${_this.result}, competitionName: ${_this.competitionName}, stage: ${_this.stage})';
}


}

/// @nodoc
abstract mixin class $PlayedMatchCopyWith<$Res>  {
  factory $PlayedMatchCopyWith(PlayedMatch value, $Res Function(PlayedMatch) _then) = _$PlayedMatchCopyWithImpl;
@useResult
$Res call({
 String matchId, DateTime playedAt,@JsonKey(readValue: _opponentName) String? opponentName,@JsonKey(readValue: _goalsFor) int goalsFor,@JsonKey(readValue: _goalsAgainst) int goalsAgainst,@JsonKey(name: 'outcome', unknownEnumValue: MatchResult.draw) MatchResult result,@JsonKey(readValue: _competitionName) String competitionName, String stage
});




}
/// @nodoc
class _$PlayedMatchCopyWithImpl<$Res>
    implements $PlayedMatchCopyWith<$Res> {
  _$PlayedMatchCopyWithImpl(this._self, this._then);

  final PlayedMatch _self;
  final $Res Function(PlayedMatch) _then;

/// Create a copy of PlayedMatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? matchId = null,Object? playedAt = null,Object? opponentName = freezed,Object? goalsFor = null,Object? goalsAgainst = null,Object? result = null,Object? competitionName = null,Object? stage = null,}) {
  return _then(PlayedMatch(
matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String,playedAt: null == playedAt ? _self.playedAt : playedAt // ignore: cast_nullable_to_non_nullable
as DateTime,opponentName: freezed == opponentName ? _self.opponentName : opponentName // ignore: cast_nullable_to_non_nullable
as String?,goalsFor: null == goalsFor ? _self.goalsFor : goalsFor // ignore: cast_nullable_to_non_nullable
as int,goalsAgainst: null == goalsAgainst ? _self.goalsAgainst : goalsAgainst // ignore: cast_nullable_to_non_nullable
as int,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as MatchResult,competitionName: null == competitionName ? _self.competitionName : competitionName // ignore: cast_nullable_to_non_nullable
as String,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayedMatch].
extension PlayedMatchPatterns on PlayedMatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayedMatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayedMatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayedMatch value)  $default,){
final _that = this;
switch (_that) {
case _PlayedMatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayedMatch value)?  $default,){
final _that = this;
switch (_that) {
case _PlayedMatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String matchId,  DateTime playedAt, @JsonKey(readValue: _opponentName)  String? opponentName, @JsonKey(readValue: _goalsFor)  int goalsFor, @JsonKey(readValue: _goalsAgainst)  int goalsAgainst, @JsonKey(name: 'outcome', unknownEnumValue: MatchResult.draw)  MatchResult result, @JsonKey(readValue: _competitionName)  String competitionName,  String stage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayedMatch() when $default != null:
return $default(_that.matchId,_that.playedAt,_that.opponentName,_that.goalsFor,_that.goalsAgainst,_that.result,_that.competitionName,_that.stage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String matchId,  DateTime playedAt, @JsonKey(readValue: _opponentName)  String? opponentName, @JsonKey(readValue: _goalsFor)  int goalsFor, @JsonKey(readValue: _goalsAgainst)  int goalsAgainst, @JsonKey(name: 'outcome', unknownEnumValue: MatchResult.draw)  MatchResult result, @JsonKey(readValue: _competitionName)  String competitionName,  String stage)  $default,) {final _that = this;
switch (_that) {
case _PlayedMatch():
return $default(_that.matchId,_that.playedAt,_that.opponentName,_that.goalsFor,_that.goalsAgainst,_that.result,_that.competitionName,_that.stage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String matchId,  DateTime playedAt, @JsonKey(readValue: _opponentName)  String? opponentName, @JsonKey(readValue: _goalsFor)  int goalsFor, @JsonKey(readValue: _goalsAgainst)  int goalsAgainst, @JsonKey(name: 'outcome', unknownEnumValue: MatchResult.draw)  MatchResult result, @JsonKey(readValue: _competitionName)  String competitionName,  String stage)?  $default,) {final _that = this;
switch (_that) {
case _PlayedMatch() when $default != null:
return $default(_that.matchId,_that.playedAt,_that.opponentName,_that.goalsFor,_that.goalsAgainst,_that.result,_that.competitionName,_that.stage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _PlayedMatch implements PlayedMatch {
  const _PlayedMatch({required this.matchId, required this.playedAt, @JsonKey(readValue: _opponentName) this.opponentName, @JsonKey(readValue: _goalsFor) required this.goalsFor, @JsonKey(readValue: _goalsAgainst) required this.goalsAgainst, @JsonKey(name: 'outcome', unknownEnumValue: MatchResult.draw) required this.result, @JsonKey(readValue: _competitionName) required this.competitionName, required this.stage});
  factory _PlayedMatch.fromJson(Map<String, dynamic> json) => _$PlayedMatchFromJson(json);

@override final  String matchId;
@override final  DateTime playedAt;
/// Null when the opponent's profile is no longer public.
@override@JsonKey(readValue: _opponentName) final  String? opponentName;
@override@JsonKey(readValue: _goalsFor) final  int goalsFor;
@override@JsonKey(readValue: _goalsAgainst) final  int goalsAgainst;
@override@JsonKey(name: 'outcome', unknownEnumValue: MatchResult.draw) final  MatchResult result;
@override@JsonKey(readValue: _competitionName) final  String competitionName;
@override final  String stage;

/// Create a copy of PlayedMatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayedMatchCopyWith<_PlayedMatch> get copyWith => __$PlayedMatchCopyWithImpl<_PlayedMatch>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayedMatch&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.playedAt, playedAt) || other.playedAt == playedAt)&&(identical(other.opponentName, opponentName) || other.opponentName == opponentName)&&(identical(other.goalsFor, goalsFor) || other.goalsFor == goalsFor)&&(identical(other.goalsAgainst, goalsAgainst) || other.goalsAgainst == goalsAgainst)&&(identical(other.result, result) || other.result == result)&&(identical(other.competitionName, competitionName) || other.competitionName == competitionName)&&(identical(other.stage, stage) || other.stage == stage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,matchId,playedAt,opponentName,goalsFor,goalsAgainst,result,competitionName,stage);
}

@override
String toString() {
    return 'PlayedMatch(matchId: $matchId, playedAt: $playedAt, opponentName: $opponentName, goalsFor: $goalsFor, goalsAgainst: $goalsAgainst, result: $result, competitionName: $competitionName, stage: $stage)';
}


}

/// @nodoc
abstract mixin class _$PlayedMatchCopyWith<$Res> implements $PlayedMatchCopyWith<$Res> {
  factory _$PlayedMatchCopyWith(_PlayedMatch value, $Res Function(_PlayedMatch) _then) = __$PlayedMatchCopyWithImpl;
@override @useResult
$Res call({
 String matchId, DateTime playedAt,@JsonKey(readValue: _opponentName) String? opponentName,@JsonKey(readValue: _goalsFor) int goalsFor,@JsonKey(readValue: _goalsAgainst) int goalsAgainst,@JsonKey(name: 'outcome', unknownEnumValue: MatchResult.draw) MatchResult result,@JsonKey(readValue: _competitionName) String competitionName, String stage
});




}
/// @nodoc
class __$PlayedMatchCopyWithImpl<$Res>
    implements _$PlayedMatchCopyWith<$Res> {
  __$PlayedMatchCopyWithImpl(this._self, this._then);

  final _PlayedMatch _self;
  final $Res Function(_PlayedMatch) _then;

/// Create a copy of PlayedMatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? matchId = null,Object? playedAt = null,Object? opponentName = freezed,Object? goalsFor = null,Object? goalsAgainst = null,Object? result = null,Object? competitionName = null,Object? stage = null,}) {
  return _then(_PlayedMatch(
matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String,playedAt: null == playedAt ? _self.playedAt : playedAt // ignore: cast_nullable_to_non_nullable
as DateTime,opponentName: freezed == opponentName ? _self.opponentName : opponentName // ignore: cast_nullable_to_non_nullable
as String?,goalsFor: null == goalsFor ? _self.goalsFor : goalsFor // ignore: cast_nullable_to_non_nullable
as int,goalsAgainst: null == goalsAgainst ? _self.goalsAgainst : goalsAgainst // ignore: cast_nullable_to_non_nullable
as int,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as MatchResult,competitionName: null == competitionName ? _self.competitionName : competitionName // ignore: cast_nullable_to_non_nullable
as String,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
