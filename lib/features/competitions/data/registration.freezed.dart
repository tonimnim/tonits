// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Registration {

 String get id; String get competitionId; String get competitionName;@JsonKey(unknownEnumValue: EntryStatus.unknown) EntryStatus get status;@JsonKey(unknownEnumValue: CompetitionStatus.unknown) CompetitionStatus get competitionStatus; int get entryFeeMinor; String get currency; DateTime? get startsAt;
/// Create a copy of Registration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegistrationCopyWith<Registration> get copyWith => _$RegistrationCopyWithImpl<Registration>(this as Registration, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Registration;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Registration&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.competitionId, _this.competitionId) || other.competitionId == _this.competitionId)&&(identical(other.competitionName, _this.competitionName) || other.competitionName == _this.competitionName)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.competitionStatus, _this.competitionStatus) || other.competitionStatus == _this.competitionStatus)&&(identical(other.entryFeeMinor, _this.entryFeeMinor) || other.entryFeeMinor == _this.entryFeeMinor)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Registration;
  return Object.hash(runtimeType,_this.id,_this.competitionId,_this.competitionName,_this.status,_this.competitionStatus,_this.entryFeeMinor,_this.currency,_this.startsAt);
}

@override
String toString() {
  final _this = this as Registration;
  return 'Registration(id: ${_this.id}, competitionId: ${_this.competitionId}, competitionName: ${_this.competitionName}, status: ${_this.status}, competitionStatus: ${_this.competitionStatus}, entryFeeMinor: ${_this.entryFeeMinor}, currency: ${_this.currency}, startsAt: ${_this.startsAt})';
}


}

/// @nodoc
abstract mixin class $RegistrationCopyWith<$Res>  {
  factory $RegistrationCopyWith(Registration value, $Res Function(Registration) _then) = _$RegistrationCopyWithImpl;
@useResult
$Res call({
 String id, String competitionId, String competitionName,@JsonKey(unknownEnumValue: EntryStatus.unknown) EntryStatus status,@JsonKey(unknownEnumValue: CompetitionStatus.unknown) CompetitionStatus competitionStatus, int entryFeeMinor, String currency, DateTime? startsAt
});




}
/// @nodoc
class _$RegistrationCopyWithImpl<$Res>
    implements $RegistrationCopyWith<$Res> {
  _$RegistrationCopyWithImpl(this._self, this._then);

  final Registration _self;
  final $Res Function(Registration) _then;

/// Create a copy of Registration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? competitionId = null,Object? competitionName = null,Object? status = null,Object? competitionStatus = null,Object? entryFeeMinor = null,Object? currency = null,Object? startsAt = freezed,}) {
  return _then(Registration(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,competitionId: null == competitionId ? _self.competitionId : competitionId // ignore: cast_nullable_to_non_nullable
as String,competitionName: null == competitionName ? _self.competitionName : competitionName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EntryStatus,competitionStatus: null == competitionStatus ? _self.competitionStatus : competitionStatus // ignore: cast_nullable_to_non_nullable
as CompetitionStatus,entryFeeMinor: null == entryFeeMinor ? _self.entryFeeMinor : entryFeeMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Registration].
extension RegistrationPatterns on Registration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Registration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Registration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Registration value)  $default,){
final _that = this;
switch (_that) {
case _Registration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Registration value)?  $default,){
final _that = this;
switch (_that) {
case _Registration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String competitionId,  String competitionName, @JsonKey(unknownEnumValue: EntryStatus.unknown)  EntryStatus status, @JsonKey(unknownEnumValue: CompetitionStatus.unknown)  CompetitionStatus competitionStatus,  int entryFeeMinor,  String currency,  DateTime? startsAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Registration() when $default != null:
return $default(_that.id,_that.competitionId,_that.competitionName,_that.status,_that.competitionStatus,_that.entryFeeMinor,_that.currency,_that.startsAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String competitionId,  String competitionName, @JsonKey(unknownEnumValue: EntryStatus.unknown)  EntryStatus status, @JsonKey(unknownEnumValue: CompetitionStatus.unknown)  CompetitionStatus competitionStatus,  int entryFeeMinor,  String currency,  DateTime? startsAt)  $default,) {final _that = this;
switch (_that) {
case _Registration():
return $default(_that.id,_that.competitionId,_that.competitionName,_that.status,_that.competitionStatus,_that.entryFeeMinor,_that.currency,_that.startsAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String competitionId,  String competitionName, @JsonKey(unknownEnumValue: EntryStatus.unknown)  EntryStatus status, @JsonKey(unknownEnumValue: CompetitionStatus.unknown)  CompetitionStatus competitionStatus,  int entryFeeMinor,  String currency,  DateTime? startsAt)?  $default,) {final _that = this;
switch (_that) {
case _Registration() when $default != null:
return $default(_that.id,_that.competitionId,_that.competitionName,_that.status,_that.competitionStatus,_that.entryFeeMinor,_that.currency,_that.startsAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _Registration extends Registration {
  const _Registration({required this.id, required this.competitionId, this.competitionName = '', @JsonKey(unknownEnumValue: EntryStatus.unknown) required this.status, @JsonKey(unknownEnumValue: CompetitionStatus.unknown) this.competitionStatus = CompetitionStatus.unknown, this.entryFeeMinor = 0, this.currency = 'KES', this.startsAt}): super._();
  factory _Registration.fromJson(Map<String, dynamic> json) => _$RegistrationFromJson(json);

@override final  String id;
@override final  String competitionId;
@override@JsonKey() final  String competitionName;
@override@JsonKey(unknownEnumValue: EntryStatus.unknown) final  EntryStatus status;
@override@JsonKey(unknownEnumValue: CompetitionStatus.unknown) final  CompetitionStatus competitionStatus;
@override@JsonKey() final  int entryFeeMinor;
@override@JsonKey() final  String currency;
@override final  DateTime? startsAt;

/// Create a copy of Registration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegistrationCopyWith<_Registration> get copyWith => __$RegistrationCopyWithImpl<_Registration>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Registration&&(identical(other.id, id) || other.id == id)&&(identical(other.competitionId, competitionId) || other.competitionId == competitionId)&&(identical(other.competitionName, competitionName) || other.competitionName == competitionName)&&(identical(other.status, status) || other.status == status)&&(identical(other.competitionStatus, competitionStatus) || other.competitionStatus == competitionStatus)&&(identical(other.entryFeeMinor, entryFeeMinor) || other.entryFeeMinor == entryFeeMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,competitionId,competitionName,status,competitionStatus,entryFeeMinor,currency,startsAt);
}

@override
String toString() {
    return 'Registration(id: $id, competitionId: $competitionId, competitionName: $competitionName, status: $status, competitionStatus: $competitionStatus, entryFeeMinor: $entryFeeMinor, currency: $currency, startsAt: $startsAt)';
}


}

/// @nodoc
abstract mixin class _$RegistrationCopyWith<$Res> implements $RegistrationCopyWith<$Res> {
  factory _$RegistrationCopyWith(_Registration value, $Res Function(_Registration) _then) = __$RegistrationCopyWithImpl;
@override @useResult
$Res call({
 String id, String competitionId, String competitionName,@JsonKey(unknownEnumValue: EntryStatus.unknown) EntryStatus status,@JsonKey(unknownEnumValue: CompetitionStatus.unknown) CompetitionStatus competitionStatus, int entryFeeMinor, String currency, DateTime? startsAt
});




}
/// @nodoc
class __$RegistrationCopyWithImpl<$Res>
    implements _$RegistrationCopyWith<$Res> {
  __$RegistrationCopyWithImpl(this._self, this._then);

  final _Registration _self;
  final $Res Function(_Registration) _then;

/// Create a copy of Registration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? competitionId = null,Object? competitionName = null,Object? status = null,Object? competitionStatus = null,Object? entryFeeMinor = null,Object? currency = null,Object? startsAt = freezed,}) {
  return _then(_Registration(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,competitionId: null == competitionId ? _self.competitionId : competitionId // ignore: cast_nullable_to_non_nullable
as String,competitionName: null == competitionName ? _self.competitionName : competitionName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EntryStatus,competitionStatus: null == competitionStatus ? _self.competitionStatus : competitionStatus // ignore: cast_nullable_to_non_nullable
as CompetitionStatus,entryFeeMinor: null == entryFeeMinor ? _self.entryFeeMinor : entryFeeMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
