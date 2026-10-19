// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ranked_player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RankedPlayer {

 String get playerId;/// Null while the player is still provisional.
 int? get rank; String get handle; String get displayName; String get countryCode; int? get rating; int get matchesPlayed;/// Places gained (positive) or lost since the previous snapshot.
 int? get rankMovement;
/// Create a copy of RankedPlayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankedPlayerCopyWith<RankedPlayer> get copyWith => _$RankedPlayerCopyWithImpl<RankedPlayer>(this as RankedPlayer, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RankedPlayer;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankedPlayer&&(identical(other.playerId, _this.playerId) || other.playerId == _this.playerId)&&(identical(other.rank, _this.rank) || other.rank == _this.rank)&&(identical(other.handle, _this.handle) || other.handle == _this.handle)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.countryCode, _this.countryCode) || other.countryCode == _this.countryCode)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.matchesPlayed, _this.matchesPlayed) || other.matchesPlayed == _this.matchesPlayed)&&(identical(other.rankMovement, _this.rankMovement) || other.rankMovement == _this.rankMovement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RankedPlayer;
  return Object.hash(runtimeType,_this.playerId,_this.rank,_this.handle,_this.displayName,_this.countryCode,_this.rating,_this.matchesPlayed,_this.rankMovement);
}

@override
String toString() {
  final _this = this as RankedPlayer;
  return 'RankedPlayer(playerId: ${_this.playerId}, rank: ${_this.rank}, handle: ${_this.handle}, displayName: ${_this.displayName}, countryCode: ${_this.countryCode}, rating: ${_this.rating}, matchesPlayed: ${_this.matchesPlayed}, rankMovement: ${_this.rankMovement})';
}


}

/// @nodoc
abstract mixin class $RankedPlayerCopyWith<$Res>  {
  factory $RankedPlayerCopyWith(RankedPlayer value, $Res Function(RankedPlayer) _then) = _$RankedPlayerCopyWithImpl;
@useResult
$Res call({
 String playerId, int? rank, String handle, String displayName, String countryCode, int? rating, int matchesPlayed, int? rankMovement
});




}
/// @nodoc
class _$RankedPlayerCopyWithImpl<$Res>
    implements $RankedPlayerCopyWith<$Res> {
  _$RankedPlayerCopyWithImpl(this._self, this._then);

  final RankedPlayer _self;
  final $Res Function(RankedPlayer) _then;

/// Create a copy of RankedPlayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? rank = freezed,Object? handle = null,Object? displayName = null,Object? countryCode = null,Object? rating = freezed,Object? matchesPlayed = null,Object? rankMovement = freezed,}) {
  return _then(RankedPlayer(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int?,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int?,matchesPlayed: null == matchesPlayed ? _self.matchesPlayed : matchesPlayed // ignore: cast_nullable_to_non_nullable
as int,rankMovement: freezed == rankMovement ? _self.rankMovement : rankMovement // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [RankedPlayer].
extension RankedPlayerPatterns on RankedPlayer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankedPlayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankedPlayer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankedPlayer value)  $default,){
final _that = this;
switch (_that) {
case _RankedPlayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankedPlayer value)?  $default,){
final _that = this;
switch (_that) {
case _RankedPlayer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId,  int? rank,  String handle,  String displayName,  String countryCode,  int? rating,  int matchesPlayed,  int? rankMovement)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankedPlayer() when $default != null:
return $default(_that.playerId,_that.rank,_that.handle,_that.displayName,_that.countryCode,_that.rating,_that.matchesPlayed,_that.rankMovement);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId,  int? rank,  String handle,  String displayName,  String countryCode,  int? rating,  int matchesPlayed,  int? rankMovement)  $default,) {final _that = this;
switch (_that) {
case _RankedPlayer():
return $default(_that.playerId,_that.rank,_that.handle,_that.displayName,_that.countryCode,_that.rating,_that.matchesPlayed,_that.rankMovement);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId,  int? rank,  String handle,  String displayName,  String countryCode,  int? rating,  int matchesPlayed,  int? rankMovement)?  $default,) {final _that = this;
switch (_that) {
case _RankedPlayer() when $default != null:
return $default(_that.playerId,_that.rank,_that.handle,_that.displayName,_that.countryCode,_that.rating,_that.matchesPlayed,_that.rankMovement);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _RankedPlayer implements RankedPlayer {
  const _RankedPlayer({required this.playerId, this.rank, required this.handle, required this.displayName, required this.countryCode, this.rating, required this.matchesPlayed, this.rankMovement});
  factory _RankedPlayer.fromJson(Map<String, dynamic> json) => _$RankedPlayerFromJson(json);

@override final  String playerId;
/// Null while the player is still provisional.
@override final  int? rank;
@override final  String handle;
@override final  String displayName;
@override final  String countryCode;
@override final  int? rating;
@override final  int matchesPlayed;
/// Places gained (positive) or lost since the previous snapshot.
@override final  int? rankMovement;

/// Create a copy of RankedPlayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankedPlayerCopyWith<_RankedPlayer> get copyWith => __$RankedPlayerCopyWithImpl<_RankedPlayer>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankedPlayer&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.matchesPlayed, matchesPlayed) || other.matchesPlayed == matchesPlayed)&&(identical(other.rankMovement, rankMovement) || other.rankMovement == rankMovement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,playerId,rank,handle,displayName,countryCode,rating,matchesPlayed,rankMovement);
}

@override
String toString() {
    return 'RankedPlayer(playerId: $playerId, rank: $rank, handle: $handle, displayName: $displayName, countryCode: $countryCode, rating: $rating, matchesPlayed: $matchesPlayed, rankMovement: $rankMovement)';
}


}

/// @nodoc
abstract mixin class _$RankedPlayerCopyWith<$Res> implements $RankedPlayerCopyWith<$Res> {
  factory _$RankedPlayerCopyWith(_RankedPlayer value, $Res Function(_RankedPlayer) _then) = __$RankedPlayerCopyWithImpl;
@override @useResult
$Res call({
 String playerId, int? rank, String handle, String displayName, String countryCode, int? rating, int matchesPlayed, int? rankMovement
});




}
/// @nodoc
class __$RankedPlayerCopyWithImpl<$Res>
    implements _$RankedPlayerCopyWith<$Res> {
  __$RankedPlayerCopyWithImpl(this._self, this._then);

  final _RankedPlayer _self;
  final $Res Function(_RankedPlayer) _then;

/// Create a copy of RankedPlayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? rank = freezed,Object? handle = null,Object? displayName = null,Object? countryCode = null,Object? rating = freezed,Object? matchesPlayed = null,Object? rankMovement = freezed,}) {
  return _then(_RankedPlayer(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int?,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int?,matchesPlayed: null == matchesPlayed ? _self.matchesPlayed : matchesPlayed // ignore: cast_nullable_to_non_nullable
as int,rankMovement: freezed == rankMovement ? _self.rankMovement : rankMovement // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
