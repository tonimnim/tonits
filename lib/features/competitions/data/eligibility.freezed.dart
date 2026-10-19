// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eligibility.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Eligibility {

/// `eligible`, `ineligible` or `registered`.
 String get status; bool get eligible;@JsonKey(unknownEnumValue: RequiredAction.none) RequiredAction get requiredAction; int get entryFeeMinor; String get currency; List<EligibilityIssue> get issues;/// The player's latest payment for this competition. Whenever it is set,
/// its status decides what happens, whatever [requiredAction] says.
 String? get paymentId;
/// Create a copy of Eligibility
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EligibilityCopyWith<Eligibility> get copyWith => _$EligibilityCopyWithImpl<Eligibility>(this as Eligibility, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Eligibility;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Eligibility&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.eligible, _this.eligible) || other.eligible == _this.eligible)&&(identical(other.requiredAction, _this.requiredAction) || other.requiredAction == _this.requiredAction)&&(identical(other.entryFeeMinor, _this.entryFeeMinor) || other.entryFeeMinor == _this.entryFeeMinor)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&const DeepCollectionEquality().equals(other.issues, _this.issues)&&(identical(other.paymentId, _this.paymentId) || other.paymentId == _this.paymentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Eligibility;
  return Object.hash(runtimeType,_this.status,_this.eligible,_this.requiredAction,_this.entryFeeMinor,_this.currency,const DeepCollectionEquality().hash(_this.issues),_this.paymentId);
}

@override
String toString() {
  final _this = this as Eligibility;
  return 'Eligibility(status: ${_this.status}, eligible: ${_this.eligible}, requiredAction: ${_this.requiredAction}, entryFeeMinor: ${_this.entryFeeMinor}, currency: ${_this.currency}, issues: ${_this.issues}, paymentId: ${_this.paymentId})';
}


}

/// @nodoc
abstract mixin class $EligibilityCopyWith<$Res>  {
  factory $EligibilityCopyWith(Eligibility value, $Res Function(Eligibility) _then) = _$EligibilityCopyWithImpl;
@useResult
$Res call({
 String status, bool eligible,@JsonKey(unknownEnumValue: RequiredAction.none) RequiredAction requiredAction, int entryFeeMinor, String currency, List<EligibilityIssue> issues, String? paymentId
});




}
/// @nodoc
class _$EligibilityCopyWithImpl<$Res>
    implements $EligibilityCopyWith<$Res> {
  _$EligibilityCopyWithImpl(this._self, this._then);

  final Eligibility _self;
  final $Res Function(Eligibility) _then;

/// Create a copy of Eligibility
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? eligible = null,Object? requiredAction = null,Object? entryFeeMinor = null,Object? currency = null,Object? issues = null,Object? paymentId = freezed,}) {
  return _then(Eligibility(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,eligible: null == eligible ? _self.eligible : eligible // ignore: cast_nullable_to_non_nullable
as bool,requiredAction: null == requiredAction ? _self.requiredAction : requiredAction // ignore: cast_nullable_to_non_nullable
as RequiredAction,entryFeeMinor: null == entryFeeMinor ? _self.entryFeeMinor : entryFeeMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,issues: null == issues ? _self.issues : issues // ignore: cast_nullable_to_non_nullable
as List<EligibilityIssue>,paymentId: freezed == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Eligibility].
extension EligibilityPatterns on Eligibility {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Eligibility value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Eligibility() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Eligibility value)  $default,){
final _that = this;
switch (_that) {
case _Eligibility():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Eligibility value)?  $default,){
final _that = this;
switch (_that) {
case _Eligibility() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  bool eligible, @JsonKey(unknownEnumValue: RequiredAction.none)  RequiredAction requiredAction,  int entryFeeMinor,  String currency,  List<EligibilityIssue> issues,  String? paymentId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Eligibility() when $default != null:
return $default(_that.status,_that.eligible,_that.requiredAction,_that.entryFeeMinor,_that.currency,_that.issues,_that.paymentId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  bool eligible, @JsonKey(unknownEnumValue: RequiredAction.none)  RequiredAction requiredAction,  int entryFeeMinor,  String currency,  List<EligibilityIssue> issues,  String? paymentId)  $default,) {final _that = this;
switch (_that) {
case _Eligibility():
return $default(_that.status,_that.eligible,_that.requiredAction,_that.entryFeeMinor,_that.currency,_that.issues,_that.paymentId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  bool eligible, @JsonKey(unknownEnumValue: RequiredAction.none)  RequiredAction requiredAction,  int entryFeeMinor,  String currency,  List<EligibilityIssue> issues,  String? paymentId)?  $default,) {final _that = this;
switch (_that) {
case _Eligibility() when $default != null:
return $default(_that.status,_that.eligible,_that.requiredAction,_that.entryFeeMinor,_that.currency,_that.issues,_that.paymentId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _Eligibility extends Eligibility {
  const _Eligibility({required this.status, required this.eligible, @JsonKey(unknownEnumValue: RequiredAction.none) required this.requiredAction, this.entryFeeMinor = 0, required this.currency,  List<EligibilityIssue> issues = const <EligibilityIssue>[], this.paymentId}): _issues = issues,super._();
  factory _Eligibility.fromJson(Map<String, dynamic> json) => _$EligibilityFromJson(json);

/// `eligible`, `ineligible` or `registered`.
@override final  String status;
@override final  bool eligible;
@override@JsonKey(unknownEnumValue: RequiredAction.none) final  RequiredAction requiredAction;
@override@JsonKey() final  int entryFeeMinor;
@override final  String currency;
 final  List<EligibilityIssue> _issues;
@override@JsonKey() List<EligibilityIssue> get issues {
  if (_issues is EqualUnmodifiableListView) return _issues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_issues);
}

/// The player's latest payment for this competition. Whenever it is set,
/// its status decides what happens, whatever [requiredAction] says.
@override final  String? paymentId;

/// Create a copy of Eligibility
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EligibilityCopyWith<_Eligibility> get copyWith => __$EligibilityCopyWithImpl<_Eligibility>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Eligibility&&(identical(other.status, status) || other.status == status)&&(identical(other.eligible, eligible) || other.eligible == eligible)&&(identical(other.requiredAction, requiredAction) || other.requiredAction == requiredAction)&&(identical(other.entryFeeMinor, entryFeeMinor) || other.entryFeeMinor == entryFeeMinor)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other.issues, _issues)&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,eligible,requiredAction,entryFeeMinor,currency,const DeepCollectionEquality().hash(_issues),paymentId);
}

@override
String toString() {
    return 'Eligibility(status: $status, eligible: $eligible, requiredAction: $requiredAction, entryFeeMinor: $entryFeeMinor, currency: $currency, issues: $issues, paymentId: $paymentId)';
}


}

/// @nodoc
abstract mixin class _$EligibilityCopyWith<$Res> implements $EligibilityCopyWith<$Res> {
  factory _$EligibilityCopyWith(_Eligibility value, $Res Function(_Eligibility) _then) = __$EligibilityCopyWithImpl;
@override @useResult
$Res call({
 String status, bool eligible,@JsonKey(unknownEnumValue: RequiredAction.none) RequiredAction requiredAction, int entryFeeMinor, String currency, List<EligibilityIssue> issues, String? paymentId
});




}
/// @nodoc
class __$EligibilityCopyWithImpl<$Res>
    implements _$EligibilityCopyWith<$Res> {
  __$EligibilityCopyWithImpl(this._self, this._then);

  final _Eligibility _self;
  final $Res Function(_Eligibility) _then;

/// Create a copy of Eligibility
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? eligible = null,Object? requiredAction = null,Object? entryFeeMinor = null,Object? currency = null,Object? issues = null,Object? paymentId = freezed,}) {
  return _then(_Eligibility(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,eligible: null == eligible ? _self.eligible : eligible // ignore: cast_nullable_to_non_nullable
as bool,requiredAction: null == requiredAction ? _self.requiredAction : requiredAction // ignore: cast_nullable_to_non_nullable
as RequiredAction,entryFeeMinor: null == entryFeeMinor ? _self.entryFeeMinor : entryFeeMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,issues: null == issues ? _self._issues : issues // ignore: cast_nullable_to_non_nullable
as List<EligibilityIssue>,paymentId: freezed == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$EligibilityIssue {

/// Such as `country_not_allowed` or `competition_full`.
 String get code;/// `blocking` or `warning`.
 String get severity;/// Ready to show.
 String get message;
/// Create a copy of EligibilityIssue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EligibilityIssueCopyWith<EligibilityIssue> get copyWith => _$EligibilityIssueCopyWithImpl<EligibilityIssue>(this as EligibilityIssue, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EligibilityIssue;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EligibilityIssue&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.severity, _this.severity) || other.severity == _this.severity)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EligibilityIssue;
  return Object.hash(runtimeType,_this.code,_this.severity,_this.message);
}

@override
String toString() {
  final _this = this as EligibilityIssue;
  return 'EligibilityIssue(code: ${_this.code}, severity: ${_this.severity}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $EligibilityIssueCopyWith<$Res>  {
  factory $EligibilityIssueCopyWith(EligibilityIssue value, $Res Function(EligibilityIssue) _then) = _$EligibilityIssueCopyWithImpl;
@useResult
$Res call({
 String code, String severity, String message
});




}
/// @nodoc
class _$EligibilityIssueCopyWithImpl<$Res>
    implements $EligibilityIssueCopyWith<$Res> {
  _$EligibilityIssueCopyWithImpl(this._self, this._then);

  final EligibilityIssue _self;
  final $Res Function(EligibilityIssue) _then;

/// Create a copy of EligibilityIssue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? severity = null,Object? message = null,}) {
  return _then(EligibilityIssue(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EligibilityIssue].
extension EligibilityIssuePatterns on EligibilityIssue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EligibilityIssue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EligibilityIssue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EligibilityIssue value)  $default,){
final _that = this;
switch (_that) {
case _EligibilityIssue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EligibilityIssue value)?  $default,){
final _that = this;
switch (_that) {
case _EligibilityIssue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String severity,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EligibilityIssue() when $default != null:
return $default(_that.code,_that.severity,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String severity,  String message)  $default,) {final _that = this;
switch (_that) {
case _EligibilityIssue():
return $default(_that.code,_that.severity,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String severity,  String message)?  $default,) {final _that = this;
switch (_that) {
case _EligibilityIssue() when $default != null:
return $default(_that.code,_that.severity,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _EligibilityIssue extends EligibilityIssue {
  const _EligibilityIssue({required this.code, required this.severity, required this.message}): super._();
  factory _EligibilityIssue.fromJson(Map<String, dynamic> json) => _$EligibilityIssueFromJson(json);

/// Such as `country_not_allowed` or `competition_full`.
@override final  String code;
/// `blocking` or `warning`.
@override final  String severity;
/// Ready to show.
@override final  String message;

/// Create a copy of EligibilityIssue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EligibilityIssueCopyWith<_EligibilityIssue> get copyWith => __$EligibilityIssueCopyWithImpl<_EligibilityIssue>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EligibilityIssue&&(identical(other.code, code) || other.code == code)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,severity,message);
}

@override
String toString() {
    return 'EligibilityIssue(code: $code, severity: $severity, message: $message)';
}


}

/// @nodoc
abstract mixin class _$EligibilityIssueCopyWith<$Res> implements $EligibilityIssueCopyWith<$Res> {
  factory _$EligibilityIssueCopyWith(_EligibilityIssue value, $Res Function(_EligibilityIssue) _then) = __$EligibilityIssueCopyWithImpl;
@override @useResult
$Res call({
 String code, String severity, String message
});




}
/// @nodoc
class __$EligibilityIssueCopyWithImpl<$Res>
    implements _$EligibilityIssueCopyWith<$Res> {
  __$EligibilityIssueCopyWithImpl(this._self, this._then);

  final _EligibilityIssue _self;
  final $Res Function(_EligibilityIssue) _then;

/// Create a copy of EligibilityIssue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? severity = null,Object? message = null,}) {
  return _then(_EligibilityIssue(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
