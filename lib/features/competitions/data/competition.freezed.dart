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
 int get prizeAmountMinor; DateTime get startsAt; DateTime? get registrationClosesAt; String get description;
/// Create a copy of Competition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitionCopyWith<Competition> get copyWith => _$CompetitionCopyWithImpl<Competition>(this as Competition, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Competition;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Competition&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.gameName, _this.gameName) || other.gameName == _this.gameName)&&(identical(other.organizerName, _this.organizerName) || other.organizerName == _this.organizerName)&&(identical(other.format, _this.format) || other.format == _this.format)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.maxEntries, _this.maxEntries) || other.maxEntries == _this.maxEntries)&&(identical(other.entryCount, _this.entryCount) || other.entryCount == _this.entryCount)&&(identical(other.entryType, _this.entryType) || other.entryType == _this.entryType)&&(identical(other.entryFeeMinor, _this.entryFeeMinor) || other.entryFeeMinor == _this.entryFeeMinor)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.prizeAmountMinor, _this.prizeAmountMinor) || other.prizeAmountMinor == _this.prizeAmountMinor)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.registrationClosesAt, _this.registrationClosesAt) || other.registrationClosesAt == _this.registrationClosesAt)&&(identical(other.description, _this.description) || other.description == _this.description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Competition;
  return Object.hash(runtimeType,_this.id,_this.name,_this.gameName,_this.organizerName,_this.format,_this.status,_this.maxEntries,_this.entryCount,_this.entryType,_this.entryFeeMinor,_this.currency,_this.prizeAmountMinor,_this.startsAt,_this.registrationClosesAt,_this.description);
}

@override
String toString() {
  final _this = this as Competition;
  return 'Competition(id: ${_this.id}, name: ${_this.name}, gameName: ${_this.gameName}, organizerName: ${_this.organizerName}, format: ${_this.format}, status: ${_this.status}, maxEntries: ${_this.maxEntries}, entryCount: ${_this.entryCount}, entryType: ${_this.entryType}, entryFeeMinor: ${_this.entryFeeMinor}, currency: ${_this.currency}, prizeAmountMinor: ${_this.prizeAmountMinor}, startsAt: ${_this.startsAt}, registrationClosesAt: ${_this.registrationClosesAt}, description: ${_this.description})';
}


}

/// @nodoc
abstract mixin class $CompetitionCopyWith<$Res>  {
  factory $CompetitionCopyWith(Competition value, $Res Function(Competition) _then) = _$CompetitionCopyWithImpl;
@useResult
$Res call({
 String id, String name, String gameName, String organizerName,@JsonKey(unknownEnumValue: CompetitionFormat.unknown) CompetitionFormat format,@JsonKey(unknownEnumValue: CompetitionStatus.unknown) CompetitionStatus status, int maxEntries, int entryCount,@JsonKey(unknownEnumValue: EntryType.free) EntryType entryType, int entryFeeMinor, String currency, int prizeAmountMinor, DateTime startsAt, DateTime? registrationClosesAt, String description
});




}
/// @nodoc
class _$CompetitionCopyWithImpl<$Res>
    implements $CompetitionCopyWith<$Res> {
  _$CompetitionCopyWithImpl(this._self, this._then);

  final Competition _self;
  final $Res Function(Competition) _then;

/// Create a copy of Competition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? gameName = null,Object? organizerName = null,Object? format = null,Object? status = null,Object? maxEntries = null,Object? entryCount = null,Object? entryType = null,Object? entryFeeMinor = null,Object? currency = null,Object? prizeAmountMinor = null,Object? startsAt = null,Object? registrationClosesAt = freezed,Object? description = null,}) {
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
as DateTime,registrationClosesAt: freezed == registrationClosesAt ? _self.registrationClosesAt : registrationClosesAt // ignore: cast_nullable_to_non_nullable
as DateTime?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String gameName,  String organizerName, @JsonKey(unknownEnumValue: CompetitionFormat.unknown)  CompetitionFormat format, @JsonKey(unknownEnumValue: CompetitionStatus.unknown)  CompetitionStatus status,  int maxEntries,  int entryCount, @JsonKey(unknownEnumValue: EntryType.free)  EntryType entryType,  int entryFeeMinor,  String currency,  int prizeAmountMinor,  DateTime startsAt,  DateTime? registrationClosesAt,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Competition() when $default != null:
return $default(_that.id,_that.name,_that.gameName,_that.organizerName,_that.format,_that.status,_that.maxEntries,_that.entryCount,_that.entryType,_that.entryFeeMinor,_that.currency,_that.prizeAmountMinor,_that.startsAt,_that.registrationClosesAt,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String gameName,  String organizerName, @JsonKey(unknownEnumValue: CompetitionFormat.unknown)  CompetitionFormat format, @JsonKey(unknownEnumValue: CompetitionStatus.unknown)  CompetitionStatus status,  int maxEntries,  int entryCount, @JsonKey(unknownEnumValue: EntryType.free)  EntryType entryType,  int entryFeeMinor,  String currency,  int prizeAmountMinor,  DateTime startsAt,  DateTime? registrationClosesAt,  String description)  $default,) {final _that = this;
switch (_that) {
case _Competition():
return $default(_that.id,_that.name,_that.gameName,_that.organizerName,_that.format,_that.status,_that.maxEntries,_that.entryCount,_that.entryType,_that.entryFeeMinor,_that.currency,_that.prizeAmountMinor,_that.startsAt,_that.registrationClosesAt,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String gameName,  String organizerName, @JsonKey(unknownEnumValue: CompetitionFormat.unknown)  CompetitionFormat format, @JsonKey(unknownEnumValue: CompetitionStatus.unknown)  CompetitionStatus status,  int maxEntries,  int entryCount, @JsonKey(unknownEnumValue: EntryType.free)  EntryType entryType,  int entryFeeMinor,  String currency,  int prizeAmountMinor,  DateTime startsAt,  DateTime? registrationClosesAt,  String description)?  $default,) {final _that = this;
switch (_that) {
case _Competition() when $default != null:
return $default(_that.id,_that.name,_that.gameName,_that.organizerName,_that.format,_that.status,_that.maxEntries,_that.entryCount,_that.entryType,_that.entryFeeMinor,_that.currency,_that.prizeAmountMinor,_that.startsAt,_that.registrationClosesAt,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _Competition extends Competition {
  const _Competition({required this.id, required this.name, required this.gameName, required this.organizerName, @JsonKey(unknownEnumValue: CompetitionFormat.unknown) required this.format, @JsonKey(unknownEnumValue: CompetitionStatus.unknown) required this.status, required this.maxEntries, required this.entryCount, @JsonKey(unknownEnumValue: EntryType.free) required this.entryType, this.entryFeeMinor = 0, required this.currency, this.prizeAmountMinor = 0, required this.startsAt, this.registrationClosesAt, this.description = ''}): super._();
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
@override final  DateTime? registrationClosesAt;
@override@JsonKey() final  String description;

/// Create a copy of Competition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitionCopyWith<_Competition> get copyWith => __$CompetitionCopyWithImpl<_Competition>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Competition&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.gameName, gameName) || other.gameName == gameName)&&(identical(other.organizerName, organizerName) || other.organizerName == organizerName)&&(identical(other.format, format) || other.format == format)&&(identical(other.status, status) || other.status == status)&&(identical(other.maxEntries, maxEntries) || other.maxEntries == maxEntries)&&(identical(other.entryCount, entryCount) || other.entryCount == entryCount)&&(identical(other.entryType, entryType) || other.entryType == entryType)&&(identical(other.entryFeeMinor, entryFeeMinor) || other.entryFeeMinor == entryFeeMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.prizeAmountMinor, prizeAmountMinor) || other.prizeAmountMinor == prizeAmountMinor)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.registrationClosesAt, registrationClosesAt) || other.registrationClosesAt == registrationClosesAt)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,gameName,organizerName,format,status,maxEntries,entryCount,entryType,entryFeeMinor,currency,prizeAmountMinor,startsAt,registrationClosesAt,description);
}

@override
String toString() {
    return 'Competition(id: $id, name: $name, gameName: $gameName, organizerName: $organizerName, format: $format, status: $status, maxEntries: $maxEntries, entryCount: $entryCount, entryType: $entryType, entryFeeMinor: $entryFeeMinor, currency: $currency, prizeAmountMinor: $prizeAmountMinor, startsAt: $startsAt, registrationClosesAt: $registrationClosesAt, description: $description)';
}


}

/// @nodoc
abstract mixin class _$CompetitionCopyWith<$Res> implements $CompetitionCopyWith<$Res> {
  factory _$CompetitionCopyWith(_Competition value, $Res Function(_Competition) _then) = __$CompetitionCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String gameName, String organizerName,@JsonKey(unknownEnumValue: CompetitionFormat.unknown) CompetitionFormat format,@JsonKey(unknownEnumValue: CompetitionStatus.unknown) CompetitionStatus status, int maxEntries, int entryCount,@JsonKey(unknownEnumValue: EntryType.free) EntryType entryType, int entryFeeMinor, String currency, int prizeAmountMinor, DateTime startsAt, DateTime? registrationClosesAt, String description
});




}
/// @nodoc
class __$CompetitionCopyWithImpl<$Res>
    implements _$CompetitionCopyWith<$Res> {
  __$CompetitionCopyWithImpl(this._self, this._then);

  final _Competition _self;
  final $Res Function(_Competition) _then;

/// Create a copy of Competition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? gameName = null,Object? organizerName = null,Object? format = null,Object? status = null,Object? maxEntries = null,Object? entryCount = null,Object? entryType = null,Object? entryFeeMinor = null,Object? currency = null,Object? prizeAmountMinor = null,Object? startsAt = null,Object? registrationClosesAt = freezed,Object? description = null,}) {
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
as DateTime,registrationClosesAt: freezed == registrationClosesAt ? _self.registrationClosesAt : registrationClosesAt // ignore: cast_nullable_to_non_nullable
as DateTime?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
