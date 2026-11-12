// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Competition {

 String get id; String get name; String get gameName; String get organizerName;@JsonKey(unknownEnumValue: CompetitionFormat.unknown) CompetitionFormat get format;@JsonKey(unknownEnumValue: CompetitionStatus.unknown) CompetitionStatus get status; int get maxEntries; int get entryCount;@JsonKey(unknownEnumValue: EntryType.free) EntryType get entryType;/// In the currency's minor units; zero for free entry.
 int get entryFeeMinor; String get currency;/// In minor units; zero when there is no prize.
 int get prizeAmountMinor; DateTime get startsAt;/// When entries open; for one still to open (`published`).
 DateTime? get registrationOpensAt; DateTime? get registrationClosesAt; String get description;/// Whether the signed-in player asked to be told when entries open.
/// Absent when the API doesn't offer reminders, or isn't asked signed
/// in; the app then offers none.
 bool? get reminderSet;/// Who won, once completed. Null for any other status, when first
/// place is shared, or from an API that doesn't name one.
 CompetitionWinner? get winner;/// How many games each round's matches are; only on the detail.
 MatchFormat? get matchFormat;
/// Create a copy of Competition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitionCopyWith<Competition> get copyWith => _$CompetitionCopyWithImpl<Competition>(this as Competition, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Competition;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Competition&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.gameName, _this.gameName) || other.gameName == _this.gameName)&&(identical(other.organizerName, _this.organizerName) || other.organizerName == _this.organizerName)&&(identical(other.format, _this.format) || other.format == _this.format)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.maxEntries, _this.maxEntries) || other.maxEntries == _this.maxEntries)&&(identical(other.entryCount, _this.entryCount) || other.entryCount == _this.entryCount)&&(identical(other.entryType, _this.entryType) || other.entryType == _this.entryType)&&(identical(other.entryFeeMinor, _this.entryFeeMinor) || other.entryFeeMinor == _this.entryFeeMinor)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.prizeAmountMinor, _this.prizeAmountMinor) || other.prizeAmountMinor == _this.prizeAmountMinor)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.registrationOpensAt, _this.registrationOpensAt) || other.registrationOpensAt == _this.registrationOpensAt)&&(identical(other.registrationClosesAt, _this.registrationClosesAt) || other.registrationClosesAt == _this.registrationClosesAt)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.reminderSet, _this.reminderSet) || other.reminderSet == _this.reminderSet)&&(identical(other.winner, _this.winner) || other.winner == _this.winner)&&(identical(other.matchFormat, _this.matchFormat) || other.matchFormat == _this.matchFormat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Competition;
  return Object.hashAll([runtimeType,_this.id,_this.name,_this.gameName,_this.organizerName,_this.format,_this.status,_this.maxEntries,_this.entryCount,_this.entryType,_this.entryFeeMinor,_this.currency,_this.prizeAmountMinor,_this.startsAt,_this.registrationOpensAt,_this.registrationClosesAt,_this.description,_this.reminderSet,_this.winner,_this.matchFormat]);
}

@override
String toString() {
  final _this = this as Competition;
  return 'Competition(id: ${_this.id}, name: ${_this.name}, gameName: ${_this.gameName}, organizerName: ${_this.organizerName}, format: ${_this.format}, status: ${_this.status}, maxEntries: ${_this.maxEntries}, entryCount: ${_this.entryCount}, entryType: ${_this.entryType}, entryFeeMinor: ${_this.entryFeeMinor}, currency: ${_this.currency}, prizeAmountMinor: ${_this.prizeAmountMinor}, startsAt: ${_this.startsAt}, registrationOpensAt: ${_this.registrationOpensAt}, registrationClosesAt: ${_this.registrationClosesAt}, description: ${_this.description}, reminderSet: ${_this.reminderSet}, winner: ${_this.winner}, matchFormat: ${_this.matchFormat})';
}


}

/// @nodoc
abstract mixin class $CompetitionCopyWith<$Res>  {
  factory $CompetitionCopyWith(Competition value, $Res Function(Competition) _then) = _$CompetitionCopyWithImpl;
@useResult
$Res call({
 String id, String name, String gameName, String organizerName,@JsonKey(unknownEnumValue: CompetitionFormat.unknown) CompetitionFormat format,@JsonKey(unknownEnumValue: CompetitionStatus.unknown) CompetitionStatus status, int maxEntries, int entryCount,@JsonKey(unknownEnumValue: EntryType.free) EntryType entryType, int entryFeeMinor, String currency, int prizeAmountMinor, DateTime startsAt, DateTime? registrationOpensAt, DateTime? registrationClosesAt, String description, bool? reminderSet, CompetitionWinner? winner, MatchFormat? matchFormat
});


$CompetitionWinnerCopyWith<$Res>? get winner;$MatchFormatCopyWith<$Res>? get matchFormat;

}
/// @nodoc
class _$CompetitionCopyWithImpl<$Res>
    implements $CompetitionCopyWith<$Res> {
  _$CompetitionCopyWithImpl(this._self, this._then);

  final Competition _self;
  final $Res Function(Competition) _then;

/// Create a copy of Competition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? gameName = null,Object? organizerName = null,Object? format = null,Object? status = null,Object? maxEntries = null,Object? entryCount = null,Object? entryType = null,Object? entryFeeMinor = null,Object? currency = null,Object? prizeAmountMinor = null,Object? startsAt = null,Object? registrationOpensAt = freezed,Object? registrationClosesAt = freezed,Object? description = null,Object? reminderSet = freezed,Object? winner = freezed,Object? matchFormat = freezed,}) {
  return _then(Competition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,gameName: null == gameName ? _self.gameName : gameName // ignore: cast_nullable_to_non_nullable
as String,organizerName: null == organizerName ? _self.organizerName : organizerName // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as CompetitionFormat,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CompetitionStatus,maxEntries: null == maxEntries ? _self.maxEntries : maxEntries // ignore: cast_nullable_to_non_nullable
as int,entryCount: null == entryCount ? _self.entryCount : entryCount // ignore: cast_nullable_to_non_nullable
as int,entryType: null == entryType ? _self.entryType : entryType // ignore: cast_nullable_to_non_nullable
as EntryType,entryFeeMinor: null == entryFeeMinor ? _self.entryFeeMinor : entryFeeMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,prizeAmountMinor: null == prizeAmountMinor ? _self.prizeAmountMinor : prizeAmountMinor // ignore: cast_nullable_to_non_nullable
as int,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,registrationOpensAt: freezed == registrationOpensAt ? _self.registrationOpensAt : registrationOpensAt // ignore: cast_nullable_to_non_nullable
as DateTime?,registrationClosesAt: freezed == registrationClosesAt ? _self.registrationClosesAt : registrationClosesAt // ignore: cast_nullable_to_non_nullable
as DateTime?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,reminderSet: freezed == reminderSet ? _self.reminderSet : reminderSet // ignore: cast_nullable_to_non_nullable
as bool?,winner: freezed == winner ? _self.winner : winner // ignore: cast_nullable_to_non_nullable
as CompetitionWinner?,matchFormat: freezed == matchFormat ? _self.matchFormat : matchFormat // ignore: cast_nullable_to_non_nullable
as MatchFormat?,
  ));
}
/// Create a copy of Competition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompetitionWinnerCopyWith<$Res>? get winner {
    if (_self.winner == null) {
    return null;
  }

  return $CompetitionWinnerCopyWith<$Res>(_self.winner!, (value) {
    return _then(_self.copyWith(winner: value));
  });
}/// Create a copy of Competition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchFormatCopyWith<$Res>? get matchFormat {
    if (_self.matchFormat == null) {
    return null;
  }

  return $MatchFormatCopyWith<$Res>(_self.matchFormat!, (value) {
    return _then(_self.copyWith(matchFormat: value));
  });
}
}


/// Adds pattern-matching-related methods to [Competition].
extension CompetitionPatterns on Competition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Competition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Competition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Competition value)  $default,){
final _that = this;
switch (_that) {
case _Competition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Competition value)?  $default,){
final _that = this;
switch (_that) {
case _Competition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String gameName,  String organizerName, @JsonKey(unknownEnumValue: CompetitionFormat.unknown)  CompetitionFormat format, @JsonKey(unknownEnumValue: CompetitionStatus.unknown)  CompetitionStatus status,  int maxEntries,  int entryCount, @JsonKey(unknownEnumValue: EntryType.free)  EntryType entryType,  int entryFeeMinor,  String currency,  int prizeAmountMinor,  DateTime startsAt,  DateTime? registrationOpensAt,  DateTime? registrationClosesAt,  String description,  bool? reminderSet,  CompetitionWinner? winner,  MatchFormat? matchFormat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Competition() when $default != null:
return $default(_that.id,_that.name,_that.gameName,_that.organizerName,_that.format,_that.status,_that.maxEntries,_that.entryCount,_that.entryType,_that.entryFeeMinor,_that.currency,_that.prizeAmountMinor,_that.startsAt,_that.registrationOpensAt,_that.registrationClosesAt,_that.description,_that.reminderSet,_that.winner,_that.matchFormat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String gameName,  String organizerName, @JsonKey(unknownEnumValue: CompetitionFormat.unknown)  CompetitionFormat format, @JsonKey(unknownEnumValue: CompetitionStatus.unknown)  CompetitionStatus status,  int maxEntries,  int entryCount, @JsonKey(unknownEnumValue: EntryType.free)  EntryType entryType,  int entryFeeMinor,  String currency,  int prizeAmountMinor,  DateTime startsAt,  DateTime? registrationOpensAt,  DateTime? registrationClosesAt,  String description,  bool? reminderSet,  CompetitionWinner? winner,  MatchFormat? matchFormat)  $default,) {final _that = this;
switch (_that) {
case _Competition():
return $default(_that.id,_that.name,_that.gameName,_that.organizerName,_that.format,_that.status,_that.maxEntries,_that.entryCount,_that.entryType,_that.entryFeeMinor,_that.currency,_that.prizeAmountMinor,_that.startsAt,_that.registrationOpensAt,_that.registrationClosesAt,_that.description,_that.reminderSet,_that.winner,_that.matchFormat);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String gameName,  String organizerName, @JsonKey(unknownEnumValue: CompetitionFormat.unknown)  CompetitionFormat format, @JsonKey(unknownEnumValue: CompetitionStatus.unknown)  CompetitionStatus status,  int maxEntries,  int entryCount, @JsonKey(unknownEnumValue: EntryType.free)  EntryType entryType,  int entryFeeMinor,  String currency,  int prizeAmountMinor,  DateTime startsAt,  DateTime? registrationOpensAt,  DateTime? registrationClosesAt,  String description,  bool? reminderSet,  CompetitionWinner? winner,  MatchFormat? matchFormat)?  $default,) {final _that = this;
switch (_that) {
case _Competition() when $default != null:
return $default(_that.id,_that.name,_that.gameName,_that.organizerName,_that.format,_that.status,_that.maxEntries,_that.entryCount,_that.entryType,_that.entryFeeMinor,_that.currency,_that.prizeAmountMinor,_that.startsAt,_that.registrationOpensAt,_that.registrationClosesAt,_that.description,_that.reminderSet,_that.winner,_that.matchFormat);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _Competition extends Competition {
  const _Competition({required this.id, required this.name, required this.gameName, required this.organizerName, @JsonKey(unknownEnumValue: CompetitionFormat.unknown) required this.format, @JsonKey(unknownEnumValue: CompetitionStatus.unknown) required this.status, required this.maxEntries, required this.entryCount, @JsonKey(unknownEnumValue: EntryType.free) required this.entryType, this.entryFeeMinor = 0, required this.currency, this.prizeAmountMinor = 0, required this.startsAt, this.registrationOpensAt, this.registrationClosesAt, this.description = '', this.reminderSet, this.winner, this.matchFormat}): super._();
  factory _Competition.fromJson(Map<String, dynamic> json) => _$CompetitionFromJson(json);

@override final  String id;
@override final  String name;
@override final  String gameName;
@override final  String organizerName;
@override@JsonKey(unknownEnumValue: CompetitionFormat.unknown) final  CompetitionFormat format;
@override@JsonKey(unknownEnumValue: CompetitionStatus.unknown) final  CompetitionStatus status;
@override final  int maxEntries;
@override final  int entryCount;
@override@JsonKey(unknownEnumValue: EntryType.free) final  EntryType entryType;
/// In the currency's minor units; zero for free entry.
@override@JsonKey() final  int entryFeeMinor;
@override final  String currency;
/// In minor units; zero when there is no prize.
@override@JsonKey() final  int prizeAmountMinor;
@override final  DateTime startsAt;
/// When entries open; for one still to open (`published`).
@override final  DateTime? registrationOpensAt;
@override final  DateTime? registrationClosesAt;
@override@JsonKey() final  String description;
/// Whether the signed-in player asked to be told when entries open.
/// Absent when the API doesn't offer reminders, or isn't asked signed
/// in; the app then offers none.
@override final  bool? reminderSet;
/// Who won, once completed. Null for any other status, when first
/// place is shared, or from an API that doesn't name one.
@override final  CompetitionWinner? winner;
/// How many games each round's matches are; only on the detail.
@override final  MatchFormat? matchFormat;

/// Create a copy of Competition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitionCopyWith<_Competition> get copyWith => __$CompetitionCopyWithImpl<_Competition>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Competition&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.gameName, gameName) || other.gameName == gameName)&&(identical(other.organizerName, organizerName) || other.organizerName == organizerName)&&(identical(other.format, format) || other.format == format)&&(identical(other.status, status) || other.status == status)&&(identical(other.maxEntries, maxEntries) || other.maxEntries == maxEntries)&&(identical(other.entryCount, entryCount) || other.entryCount == entryCount)&&(identical(other.entryType, entryType) || other.entryType == entryType)&&(identical(other.entryFeeMinor, entryFeeMinor) || other.entryFeeMinor == entryFeeMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.prizeAmountMinor, prizeAmountMinor) || other.prizeAmountMinor == prizeAmountMinor)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.registrationOpensAt, registrationOpensAt) || other.registrationOpensAt == registrationOpensAt)&&(identical(other.registrationClosesAt, registrationClosesAt) || other.registrationClosesAt == registrationClosesAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.reminderSet, reminderSet) || other.reminderSet == reminderSet)&&(identical(other.winner, winner) || other.winner == winner)&&(identical(other.matchFormat, matchFormat) || other.matchFormat == matchFormat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,name,gameName,organizerName,format,status,maxEntries,entryCount,entryType,entryFeeMinor,currency,prizeAmountMinor,startsAt,registrationOpensAt,registrationClosesAt,description,reminderSet,winner,matchFormat]);
}

@override
String toString() {
    return 'Competition(id: $id, name: $name, gameName: $gameName, organizerName: $organizerName, format: $format, status: $status, maxEntries: $maxEntries, entryCount: $entryCount, entryType: $entryType, entryFeeMinor: $entryFeeMinor, currency: $currency, prizeAmountMinor: $prizeAmountMinor, startsAt: $startsAt, registrationOpensAt: $registrationOpensAt, registrationClosesAt: $registrationClosesAt, description: $description, reminderSet: $reminderSet, winner: $winner, matchFormat: $matchFormat)';
}


}

/// @nodoc
abstract mixin class _$CompetitionCopyWith<$Res> implements $CompetitionCopyWith<$Res> {
  factory _$CompetitionCopyWith(_Competition value, $Res Function(_Competition) _then) = __$CompetitionCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String gameName, String organizerName,@JsonKey(unknownEnumValue: CompetitionFormat.unknown) CompetitionFormat format,@JsonKey(unknownEnumValue: CompetitionStatus.unknown) CompetitionStatus status, int maxEntries, int entryCount,@JsonKey(unknownEnumValue: EntryType.free) EntryType entryType, int entryFeeMinor, String currency, int prizeAmountMinor, DateTime startsAt, DateTime? registrationOpensAt, DateTime? registrationClosesAt, String description, bool? reminderSet, CompetitionWinner? winner, MatchFormat? matchFormat
});


@override $CompetitionWinnerCopyWith<$Res>? get winner;@override $MatchFormatCopyWith<$Res>? get matchFormat;

}
/// @nodoc
class __$CompetitionCopyWithImpl<$Res>
    implements _$CompetitionCopyWith<$Res> {
  __$CompetitionCopyWithImpl(this._self, this._then);

  final _Competition _self;
  final $Res Function(_Competition) _then;

/// Create a copy of Competition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? gameName = null,Object? organizerName = null,Object? format = null,Object? status = null,Object? maxEntries = null,Object? entryCount = null,Object? entryType = null,Object? entryFeeMinor = null,Object? currency = null,Object? prizeAmountMinor = null,Object? startsAt = null,Object? registrationOpensAt = freezed,Object? registrationClosesAt = freezed,Object? description = null,Object? reminderSet = freezed,Object? winner = freezed,Object? matchFormat = freezed,}) {
  return _then(_Competition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,gameName: null == gameName ? _self.gameName : gameName // ignore: cast_nullable_to_non_nullable
as String,organizerName: null == organizerName ? _self.organizerName : organizerName // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as CompetitionFormat,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CompetitionStatus,maxEntries: null == maxEntries ? _self.maxEntries : maxEntries // ignore: cast_nullable_to_non_nullable
as int,entryCount: null == entryCount ? _self.entryCount : entryCount // ignore: cast_nullable_to_non_nullable
as int,entryType: null == entryType ? _self.entryType : entryType // ignore: cast_nullable_to_non_nullable
as EntryType,entryFeeMinor: null == entryFeeMinor ? _self.entryFeeMinor : entryFeeMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,prizeAmountMinor: null == prizeAmountMinor ? _self.prizeAmountMinor : prizeAmountMinor // ignore: cast_nullable_to_non_nullable
as int,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,registrationOpensAt: freezed == registrationOpensAt ? _self.registrationOpensAt : registrationOpensAt // ignore: cast_nullable_to_non_nullable
as DateTime?,registrationClosesAt: freezed == registrationClosesAt ? _self.registrationClosesAt : registrationClosesAt // ignore: cast_nullable_to_non_nullable
as DateTime?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,reminderSet: freezed == reminderSet ? _self.reminderSet : reminderSet // ignore: cast_nullable_to_non_nullable
as bool?,winner: freezed == winner ? _self.winner : winner // ignore: cast_nullable_to_non_nullable
as CompetitionWinner?,matchFormat: freezed == matchFormat ? _self.matchFormat : matchFormat // ignore: cast_nullable_to_non_nullable
as MatchFormat?,
  ));
}

/// Create a copy of Competition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompetitionWinnerCopyWith<$Res>? get winner {
    if (_self.winner == null) {
    return null;
  }

  return $CompetitionWinnerCopyWith<$Res>(_self.winner!, (value) {
    return _then(_self.copyWith(winner: value));
  });
}/// Create a copy of Competition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchFormatCopyWith<$Res>? get matchFormat {
    if (_self.matchFormat == null) {
    return null;
  }

  return $MatchFormatCopyWith<$Res>(_self.matchFormat!, (value) {
    return _then(_self.copyWith(matchFormat: value));
  });
}
}


/// @nodoc
mixin _$CompetitionWinner {

 String? get playerId; String get displayName; String? get avatarUrl;
/// Create a copy of CompetitionWinner
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitionWinnerCopyWith<CompetitionWinner> get copyWith => _$CompetitionWinnerCopyWithImpl<CompetitionWinner>(this as CompetitionWinner, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CompetitionWinner;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitionWinner&&(identical(other.playerId, _this.playerId) || other.playerId == _this.playerId)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CompetitionWinner;
  return Object.hash(runtimeType,_this.playerId,_this.displayName,_this.avatarUrl);
}

@override
String toString() {
  final _this = this as CompetitionWinner;
  return 'CompetitionWinner(playerId: ${_this.playerId}, displayName: ${_this.displayName}, avatarUrl: ${_this.avatarUrl})';
}


}

/// @nodoc
abstract mixin class $CompetitionWinnerCopyWith<$Res>  {
  factory $CompetitionWinnerCopyWith(CompetitionWinner value, $Res Function(CompetitionWinner) _then) = _$CompetitionWinnerCopyWithImpl;
@useResult
$Res call({
 String? playerId, String displayName, String? avatarUrl
});




}
/// @nodoc
class _$CompetitionWinnerCopyWithImpl<$Res>
    implements $CompetitionWinnerCopyWith<$Res> {
  _$CompetitionWinnerCopyWithImpl(this._self, this._then);

  final CompetitionWinner _self;
  final $Res Function(CompetitionWinner) _then;

/// Create a copy of CompetitionWinner
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = freezed,Object? displayName = null,Object? avatarUrl = freezed,}) {
  return _then(CompetitionWinner(
playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String?,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CompetitionWinner].
extension CompetitionWinnerPatterns on CompetitionWinner {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitionWinner value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitionWinner() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitionWinner value)  $default,){
final _that = this;
switch (_that) {
case _CompetitionWinner():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitionWinner value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitionWinner() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? playerId,  String displayName,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitionWinner() when $default != null:
return $default(_that.playerId,_that.displayName,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? playerId,  String displayName,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _CompetitionWinner():
return $default(_that.playerId,_that.displayName,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? playerId,  String displayName,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _CompetitionWinner() when $default != null:
return $default(_that.playerId,_that.displayName,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _CompetitionWinner implements CompetitionWinner {
  const _CompetitionWinner({this.playerId, required this.displayName, this.avatarUrl});
  factory _CompetitionWinner.fromJson(Map<String, dynamic> json) => _$CompetitionWinnerFromJson(json);

@override final  String? playerId;
@override final  String displayName;
@override final  String? avatarUrl;

/// Create a copy of CompetitionWinner
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitionWinnerCopyWith<_CompetitionWinner> get copyWith => __$CompetitionWinnerCopyWithImpl<_CompetitionWinner>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitionWinner&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,playerId,displayName,avatarUrl);
}

@override
String toString() {
    return 'CompetitionWinner(playerId: $playerId, displayName: $displayName, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$CompetitionWinnerCopyWith<$Res> implements $CompetitionWinnerCopyWith<$Res> {
  factory _$CompetitionWinnerCopyWith(_CompetitionWinner value, $Res Function(_CompetitionWinner) _then) = __$CompetitionWinnerCopyWithImpl;
@override @useResult
$Res call({
 String? playerId, String displayName, String? avatarUrl
});




}
/// @nodoc
class __$CompetitionWinnerCopyWithImpl<$Res>
    implements _$CompetitionWinnerCopyWith<$Res> {
  __$CompetitionWinnerCopyWithImpl(this._self, this._then);

  final _CompetitionWinner _self;
  final $Res Function(_CompetitionWinner) _then;

/// Create a copy of CompetitionWinner
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = freezed,Object? displayName = null,Object? avatarUrl = freezed,}) {
  return _then(_CompetitionWinner(
playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String?,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MatchFormat {

 int get bestOf; Map<String, int> get rounds;
/// Create a copy of MatchFormat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchFormatCopyWith<MatchFormat> get copyWith => _$MatchFormatCopyWithImpl<MatchFormat>(this as MatchFormat, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MatchFormat;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchFormat&&(identical(other.bestOf, _this.bestOf) || other.bestOf == _this.bestOf)&&const DeepCollectionEquality().equals(other.rounds, _this.rounds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MatchFormat;
  return Object.hash(runtimeType,_this.bestOf,const DeepCollectionEquality().hash(_this.rounds));
}

@override
String toString() {
  final _this = this as MatchFormat;
  return 'MatchFormat(bestOf: ${_this.bestOf}, rounds: ${_this.rounds})';
}


}

/// @nodoc
abstract mixin class $MatchFormatCopyWith<$Res>  {
  factory $MatchFormatCopyWith(MatchFormat value, $Res Function(MatchFormat) _then) = _$MatchFormatCopyWithImpl;
@useResult
$Res call({
 int bestOf, Map<String, int> rounds
});




}
/// @nodoc
class _$MatchFormatCopyWithImpl<$Res>
    implements $MatchFormatCopyWith<$Res> {
  _$MatchFormatCopyWithImpl(this._self, this._then);

  final MatchFormat _self;
  final $Res Function(MatchFormat) _then;

/// Create a copy of MatchFormat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bestOf = null,Object? rounds = null,}) {
  return _then(MatchFormat(
bestOf: null == bestOf ? _self.bestOf : bestOf // ignore: cast_nullable_to_non_nullable
as int,rounds: null == rounds ? _self.rounds : rounds // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchFormat].
extension MatchFormatPatterns on MatchFormat {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchFormat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchFormat() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchFormat value)  $default,){
final _that = this;
switch (_that) {
case _MatchFormat():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchFormat value)?  $default,){
final _that = this;
switch (_that) {
case _MatchFormat() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int bestOf,  Map<String, int> rounds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchFormat() when $default != null:
return $default(_that.bestOf,_that.rounds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int bestOf,  Map<String, int> rounds)  $default,) {final _that = this;
switch (_that) {
case _MatchFormat():
return $default(_that.bestOf,_that.rounds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int bestOf,  Map<String, int> rounds)?  $default,) {final _that = this;
switch (_that) {
case _MatchFormat() when $default != null:
return $default(_that.bestOf,_that.rounds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _MatchFormat extends MatchFormat {
  const _MatchFormat({this.bestOf = 1,  Map<String, int> rounds = const <String, int>{}}): _rounds = rounds,super._();
  factory _MatchFormat.fromJson(Map<String, dynamic> json) => _$MatchFormatFromJson(json);

@override@JsonKey() final  int bestOf;
 final  Map<String, int> _rounds;
@override@JsonKey() Map<String, int> get rounds {
  if (_rounds is EqualUnmodifiableMapView) return _rounds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_rounds);
}


/// Create a copy of MatchFormat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchFormatCopyWith<_MatchFormat> get copyWith => __$MatchFormatCopyWithImpl<_MatchFormat>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchFormat&&(identical(other.bestOf, bestOf) || other.bestOf == bestOf)&&const DeepCollectionEquality().equals(other.rounds, _rounds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,bestOf,const DeepCollectionEquality().hash(_rounds));
}

@override
String toString() {
    return 'MatchFormat(bestOf: $bestOf, rounds: $rounds)';
}


}

/// @nodoc
abstract mixin class _$MatchFormatCopyWith<$Res> implements $MatchFormatCopyWith<$Res> {
  factory _$MatchFormatCopyWith(_MatchFormat value, $Res Function(_MatchFormat) _then) = __$MatchFormatCopyWithImpl;
@override @useResult
$Res call({
 int bestOf, Map<String, int> rounds
});




}
/// @nodoc
class __$MatchFormatCopyWithImpl<$Res>
    implements _$MatchFormatCopyWith<$Res> {
  __$MatchFormatCopyWithImpl(this._self, this._then);

  final _MatchFormat _self;
  final $Res Function(_MatchFormat) _then;

/// Create a copy of MatchFormat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bestOf = null,Object? rounds = null,}) {
  return _then(_MatchFormat(
bestOf: null == bestOf ? _self.bestOf : bestOf // ignore: cast_nullable_to_non_nullable
as int,rounds: null == rounds ? _self._rounds : rounds // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}

// dart format on
