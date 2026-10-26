// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlayerProfile {

 String get playerId; String get displayName; String get countryCode; MatchRecord get record; List<GameRating> get ratings; DateTime? get joinedAt;
/// Create a copy of PlayerProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerProfileCopyWith<PlayerProfile> get copyWith => _$PlayerProfileCopyWithImpl<PlayerProfile>(this as PlayerProfile, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PlayerProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerProfile&&(identical(other.playerId, _this.playerId) || other.playerId == _this.playerId)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.countryCode, _this.countryCode) || other.countryCode == _this.countryCode)&&(identical(other.record, _this.record) || other.record == _this.record)&&const DeepCollectionEquality().equals(other.ratings, _this.ratings)&&(identical(other.joinedAt, _this.joinedAt) || other.joinedAt == _this.joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlayerProfile;
  return Object.hash(runtimeType,_this.playerId,_this.displayName,_this.countryCode,_this.record,const DeepCollectionEquality().hash(_this.ratings),_this.joinedAt);
}

@override
String toString() {
  final _this = this as PlayerProfile;
  return 'PlayerProfile(playerId: ${_this.playerId}, displayName: ${_this.displayName}, countryCode: ${_this.countryCode}, record: ${_this.record}, ratings: ${_this.ratings}, joinedAt: ${_this.joinedAt})';
}


}

/// @nodoc
abstract mixin class $PlayerProfileCopyWith<$Res>  {
  factory $PlayerProfileCopyWith(PlayerProfile value, $Res Function(PlayerProfile) _then) = _$PlayerProfileCopyWithImpl;
@useResult
$Res call({
 String playerId, String displayName, String countryCode, MatchRecord record, List<GameRating> ratings, DateTime? joinedAt
});


$MatchRecordCopyWith<$Res> get record;

}
/// @nodoc
class _$PlayerProfileCopyWithImpl<$Res>
    implements $PlayerProfileCopyWith<$Res> {
  _$PlayerProfileCopyWithImpl(this._self, this._then);

  final PlayerProfile _self;
  final $Res Function(PlayerProfile) _then;

/// Create a copy of PlayerProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? displayName = null,Object? countryCode = null,Object? record = null,Object? ratings = null,Object? joinedAt = freezed,}) {
  return _then(PlayerProfile(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,record: null == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as MatchRecord,ratings: null == ratings ? _self.ratings : ratings // ignore: cast_nullable_to_non_nullable
as List<GameRating>,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of PlayerProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchRecordCopyWith<$Res> get record {
  
  return $MatchRecordCopyWith<$Res>(_self.record, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlayerProfile].
extension PlayerProfilePatterns on PlayerProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerProfile value)  $default,){
final _that = this;
switch (_that) {
case _PlayerProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerProfile value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId,  String displayName,  String countryCode,  MatchRecord record,  List<GameRating> ratings,  DateTime? joinedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerProfile() when $default != null:
return $default(_that.playerId,_that.displayName,_that.countryCode,_that.record,_that.ratings,_that.joinedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId,  String displayName,  String countryCode,  MatchRecord record,  List<GameRating> ratings,  DateTime? joinedAt)  $default,) {final _that = this;
switch (_that) {
case _PlayerProfile():
return $default(_that.playerId,_that.displayName,_that.countryCode,_that.record,_that.ratings,_that.joinedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId,  String displayName,  String countryCode,  MatchRecord record,  List<GameRating> ratings,  DateTime? joinedAt)?  $default,) {final _that = this;
switch (_that) {
case _PlayerProfile() when $default != null:
return $default(_that.playerId,_that.displayName,_that.countryCode,_that.record,_that.ratings,_that.joinedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _PlayerProfile extends PlayerProfile {
  const _PlayerProfile({required this.playerId, required this.displayName, required this.countryCode, required this.record,  List<GameRating> ratings = const <GameRating>[], this.joinedAt}): _ratings = ratings,super._();
  factory _PlayerProfile.fromJson(Map<String, dynamic> json) => _$PlayerProfileFromJson(json);

@override final  String playerId;
@override final  String displayName;
@override final  String countryCode;
@override final  MatchRecord record;
 final  List<GameRating> _ratings;
@override@JsonKey() List<GameRating> get ratings {
  if (_ratings is EqualUnmodifiableListView) return _ratings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ratings);
}

@override final  DateTime? joinedAt;

/// Create a copy of PlayerProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerProfileCopyWith<_PlayerProfile> get copyWith => __$PlayerProfileCopyWithImpl<_PlayerProfile>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerProfile&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.record, record) || other.record == record)&&const DeepCollectionEquality().equals(other.ratings, _ratings)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,playerId,displayName,countryCode,record,const DeepCollectionEquality().hash(_ratings),joinedAt);
}

@override
String toString() {
    return 'PlayerProfile(playerId: $playerId, displayName: $displayName, countryCode: $countryCode, record: $record, ratings: $ratings, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class _$PlayerProfileCopyWith<$Res> implements $PlayerProfileCopyWith<$Res> {
  factory _$PlayerProfileCopyWith(_PlayerProfile value, $Res Function(_PlayerProfile) _then) = __$PlayerProfileCopyWithImpl;
@override @useResult
$Res call({
 String playerId, String displayName, String countryCode, MatchRecord record, List<GameRating> ratings, DateTime? joinedAt
});


@override $MatchRecordCopyWith<$Res> get record;

}
/// @nodoc
class __$PlayerProfileCopyWithImpl<$Res>
    implements _$PlayerProfileCopyWith<$Res> {
  __$PlayerProfileCopyWithImpl(this._self, this._then);

  final _PlayerProfile _self;
  final $Res Function(_PlayerProfile) _then;

/// Create a copy of PlayerProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? displayName = null,Object? countryCode = null,Object? record = null,Object? ratings = null,Object? joinedAt = freezed,}) {
  return _then(_PlayerProfile(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,record: null == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as MatchRecord,ratings: null == ratings ? _self._ratings : ratings // ignore: cast_nullable_to_non_nullable
as List<GameRating>,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of PlayerProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchRecordCopyWith<$Res> get record {
  
  return $MatchRecordCopyWith<$Res>(_self.record, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}


/// @nodoc
mixin _$MatchRecord {

 int get matchesPlayed; int get wins; int get draws; int get losses;
/// Create a copy of MatchRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchRecordCopyWith<MatchRecord> get copyWith => _$MatchRecordCopyWithImpl<MatchRecord>(this as MatchRecord, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MatchRecord;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchRecord&&(identical(other.matchesPlayed, _this.matchesPlayed) || other.matchesPlayed == _this.matchesPlayed)&&(identical(other.wins, _this.wins) || other.wins == _this.wins)&&(identical(other.draws, _this.draws) || other.draws == _this.draws)&&(identical(other.losses, _this.losses) || other.losses == _this.losses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MatchRecord;
  return Object.hash(runtimeType,_this.matchesPlayed,_this.wins,_this.draws,_this.losses);
}

@override
String toString() {
  final _this = this as MatchRecord;
  return 'MatchRecord(matchesPlayed: ${_this.matchesPlayed}, wins: ${_this.wins}, draws: ${_this.draws}, losses: ${_this.losses})';
}


}

/// @nodoc
abstract mixin class $MatchRecordCopyWith<$Res>  {
  factory $MatchRecordCopyWith(MatchRecord value, $Res Function(MatchRecord) _then) = _$MatchRecordCopyWithImpl;
@useResult
$Res call({
 int matchesPlayed, int wins, int draws, int losses
});




}
/// @nodoc
class _$MatchRecordCopyWithImpl<$Res>
    implements $MatchRecordCopyWith<$Res> {
  _$MatchRecordCopyWithImpl(this._self, this._then);

  final MatchRecord _self;
  final $Res Function(MatchRecord) _then;

/// Create a copy of MatchRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? matchesPlayed = null,Object? wins = null,Object? draws = null,Object? losses = null,}) {
  return _then(MatchRecord(
matchesPlayed: null == matchesPlayed ? _self.matchesPlayed : matchesPlayed // ignore: cast_nullable_to_non_nullable
as int,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,draws: null == draws ? _self.draws : draws // ignore: cast_nullable_to_non_nullable
as int,losses: null == losses ? _self.losses : losses // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchRecord].
extension MatchRecordPatterns on MatchRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchRecord value)  $default,){
final _that = this;
switch (_that) {
case _MatchRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchRecord value)?  $default,){
final _that = this;
switch (_that) {
case _MatchRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int matchesPlayed,  int wins,  int draws,  int losses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchRecord() when $default != null:
return $default(_that.matchesPlayed,_that.wins,_that.draws,_that.losses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int matchesPlayed,  int wins,  int draws,  int losses)  $default,) {final _that = this;
switch (_that) {
case _MatchRecord():
return $default(_that.matchesPlayed,_that.wins,_that.draws,_that.losses);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int matchesPlayed,  int wins,  int draws,  int losses)?  $default,) {final _that = this;
switch (_that) {
case _MatchRecord() when $default != null:
return $default(_that.matchesPlayed,_that.wins,_that.draws,_that.losses);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _MatchRecord extends MatchRecord {
  const _MatchRecord({required this.matchesPlayed, required this.wins, required this.draws, required this.losses}): super._();
  factory _MatchRecord.fromJson(Map<String, dynamic> json) => _$MatchRecordFromJson(json);

@override final  int matchesPlayed;
@override final  int wins;
@override final  int draws;
@override final  int losses;

/// Create a copy of MatchRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchRecordCopyWith<_MatchRecord> get copyWith => __$MatchRecordCopyWithImpl<_MatchRecord>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchRecord&&(identical(other.matchesPlayed, matchesPlayed) || other.matchesPlayed == matchesPlayed)&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.draws, draws) || other.draws == draws)&&(identical(other.losses, losses) || other.losses == losses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,matchesPlayed,wins,draws,losses);
}

@override
String toString() {
    return 'MatchRecord(matchesPlayed: $matchesPlayed, wins: $wins, draws: $draws, losses: $losses)';
}


}

/// @nodoc
abstract mixin class _$MatchRecordCopyWith<$Res> implements $MatchRecordCopyWith<$Res> {
  factory _$MatchRecordCopyWith(_MatchRecord value, $Res Function(_MatchRecord) _then) = __$MatchRecordCopyWithImpl;
@override @useResult
$Res call({
 int matchesPlayed, int wins, int draws, int losses
});




}
/// @nodoc
class __$MatchRecordCopyWithImpl<$Res>
    implements _$MatchRecordCopyWith<$Res> {
  __$MatchRecordCopyWithImpl(this._self, this._then);

  final _MatchRecord _self;
  final $Res Function(_MatchRecord) _then;

/// Create a copy of MatchRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? matchesPlayed = null,Object? wins = null,Object? draws = null,Object? losses = null,}) {
  return _then(_MatchRecord(
matchesPlayed: null == matchesPlayed ? _self.matchesPlayed : matchesPlayed // ignore: cast_nullable_to_non_nullable
as int,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,draws: null == draws ? _self.draws : draws // ignore: cast_nullable_to_non_nullable
as int,losses: null == losses ? _self.losses : losses // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$GameRating {

 String get gameId; int get rating;/// The rating's named band. Null from servers from before levels.
@JsonKey(unknownEnumValue: RatingLevel.unknown) RatingLevel? get level;/// Null while provisional.
 int? get globalRank; int? get countryRank;/// Places gained (positive) or lost since the previous snapshot.
 int? get rankMovement;
/// Create a copy of GameRating
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameRatingCopyWith<GameRating> get copyWith => _$GameRatingCopyWithImpl<GameRating>(this as GameRating, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GameRating;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameRating&&(identical(other.gameId, _this.gameId) || other.gameId == _this.gameId)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.level, _this.level) || other.level == _this.level)&&(identical(other.globalRank, _this.globalRank) || other.globalRank == _this.globalRank)&&(identical(other.countryRank, _this.countryRank) || other.countryRank == _this.countryRank)&&(identical(other.rankMovement, _this.rankMovement) || other.rankMovement == _this.rankMovement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as GameRating;
  return Object.hash(runtimeType,_this.gameId,_this.rating,_this.level,_this.globalRank,_this.countryRank,_this.rankMovement);
}

@override
String toString() {
  final _this = this as GameRating;
  return 'GameRating(gameId: ${_this.gameId}, rating: ${_this.rating}, level: ${_this.level}, globalRank: ${_this.globalRank}, countryRank: ${_this.countryRank}, rankMovement: ${_this.rankMovement})';
}


}

/// @nodoc
abstract mixin class $GameRatingCopyWith<$Res>  {
  factory $GameRatingCopyWith(GameRating value, $Res Function(GameRating) _then) = _$GameRatingCopyWithImpl;
@useResult
$Res call({
 String gameId, int rating,@JsonKey(unknownEnumValue: RatingLevel.unknown) RatingLevel? level, int? globalRank, int? countryRank, int? rankMovement
});




}
/// @nodoc
class _$GameRatingCopyWithImpl<$Res>
    implements $GameRatingCopyWith<$Res> {
  _$GameRatingCopyWithImpl(this._self, this._then);

  final GameRating _self;
  final $Res Function(GameRating) _then;

/// Create a copy of GameRating
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gameId = null,Object? rating = null,Object? level = freezed,Object? globalRank = freezed,Object? countryRank = freezed,Object? rankMovement = freezed,}) {
  return _then(GameRating(
gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as RatingLevel?,globalRank: freezed == globalRank ? _self.globalRank : globalRank // ignore: cast_nullable_to_non_nullable
as int?,countryRank: freezed == countryRank ? _self.countryRank : countryRank // ignore: cast_nullable_to_non_nullable
as int?,rankMovement: freezed == rankMovement ? _self.rankMovement : rankMovement // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [GameRating].
extension GameRatingPatterns on GameRating {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameRating value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameRating() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameRating value)  $default,){
final _that = this;
switch (_that) {
case _GameRating():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameRating value)?  $default,){
final _that = this;
switch (_that) {
case _GameRating() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String gameId,  int rating, @JsonKey(unknownEnumValue: RatingLevel.unknown)  RatingLevel? level,  int? globalRank,  int? countryRank,  int? rankMovement)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameRating() when $default != null:
return $default(_that.gameId,_that.rating,_that.level,_that.globalRank,_that.countryRank,_that.rankMovement);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String gameId,  int rating, @JsonKey(unknownEnumValue: RatingLevel.unknown)  RatingLevel? level,  int? globalRank,  int? countryRank,  int? rankMovement)  $default,) {final _that = this;
switch (_that) {
case _GameRating():
return $default(_that.gameId,_that.rating,_that.level,_that.globalRank,_that.countryRank,_that.rankMovement);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String gameId,  int rating, @JsonKey(unknownEnumValue: RatingLevel.unknown)  RatingLevel? level,  int? globalRank,  int? countryRank,  int? rankMovement)?  $default,) {final _that = this;
switch (_that) {
case _GameRating() when $default != null:
return $default(_that.gameId,_that.rating,_that.level,_that.globalRank,_that.countryRank,_that.rankMovement);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _GameRating implements GameRating {
  const _GameRating({required this.gameId, required this.rating, @JsonKey(unknownEnumValue: RatingLevel.unknown) this.level, this.globalRank, this.countryRank, this.rankMovement});
  factory _GameRating.fromJson(Map<String, dynamic> json) => _$GameRatingFromJson(json);

@override final  String gameId;
@override final  int rating;
/// The rating's named band. Null from servers from before levels.
@override@JsonKey(unknownEnumValue: RatingLevel.unknown) final  RatingLevel? level;
/// Null while provisional.
@override final  int? globalRank;
@override final  int? countryRank;
/// Places gained (positive) or lost since the previous snapshot.
@override final  int? rankMovement;

/// Create a copy of GameRating
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameRatingCopyWith<_GameRating> get copyWith => __$GameRatingCopyWithImpl<_GameRating>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameRating&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.level, level) || other.level == level)&&(identical(other.globalRank, globalRank) || other.globalRank == globalRank)&&(identical(other.countryRank, countryRank) || other.countryRank == countryRank)&&(identical(other.rankMovement, rankMovement) || other.rankMovement == rankMovement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,gameId,rating,level,globalRank,countryRank,rankMovement);
}

@override
String toString() {
    return 'GameRating(gameId: $gameId, rating: $rating, level: $level, globalRank: $globalRank, countryRank: $countryRank, rankMovement: $rankMovement)';
}


}

/// @nodoc
abstract mixin class _$GameRatingCopyWith<$Res> implements $GameRatingCopyWith<$Res> {
  factory _$GameRatingCopyWith(_GameRating value, $Res Function(_GameRating) _then) = __$GameRatingCopyWithImpl;
@override @useResult
$Res call({
 String gameId, int rating,@JsonKey(unknownEnumValue: RatingLevel.unknown) RatingLevel? level, int? globalRank, int? countryRank, int? rankMovement
});




}
/// @nodoc
class __$GameRatingCopyWithImpl<$Res>
    implements _$GameRatingCopyWith<$Res> {
  __$GameRatingCopyWithImpl(this._self, this._then);

  final _GameRating _self;
  final $Res Function(_GameRating) _then;

/// Create a copy of GameRating
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gameId = null,Object? rating = null,Object? level = freezed,Object? globalRank = freezed,Object? countryRank = freezed,Object? rankMovement = freezed,}) {
  return _then(_GameRating(
gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as RatingLevel?,globalRank: freezed == globalRank ? _self.globalRank : globalRank // ignore: cast_nullable_to_non_nullable
as int?,countryRank: freezed == countryRank ? _self.countryRank : countryRank // ignore: cast_nullable_to_non_nullable
as int?,rankMovement: freezed == rankMovement ? _self.rankMovement : rankMovement // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
