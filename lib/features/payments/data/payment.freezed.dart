// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Payment {

 String get id; String get competitionId; int get amountMinor; String get currency;/// As the API returns it, already masked.
@JsonKey(name: 'phoneNumber') String get maskedPhone;@JsonKey(unknownEnumValue: PaymentStatus.pending) PaymentStatus get status;@JsonKey(unknownEnumValue: RegistrationOutcome.pending) RegistrationOutcome get registrationStatus;/// M-Pesa's own words for a failed payment, such as "Request cancelled
/// by user".
@JsonKey(name: 'providerResultDescription') String? get providerMessage;@JsonKey(readValue: _refundReason) String? get refundReason;
/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentCopyWith<Payment> get copyWith => _$PaymentCopyWithImpl<Payment>(this as Payment, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Payment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payment&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.competitionId, _this.competitionId) || other.competitionId == _this.competitionId)&&(identical(other.amountMinor, _this.amountMinor) || other.amountMinor == _this.amountMinor)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.maskedPhone, _this.maskedPhone) || other.maskedPhone == _this.maskedPhone)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.registrationStatus, _this.registrationStatus) || other.registrationStatus == _this.registrationStatus)&&(identical(other.providerMessage, _this.providerMessage) || other.providerMessage == _this.providerMessage)&&(identical(other.refundReason, _this.refundReason) || other.refundReason == _this.refundReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Payment;
  return Object.hash(runtimeType,_this.id,_this.competitionId,_this.amountMinor,_this.currency,_this.maskedPhone,_this.status,_this.registrationStatus,_this.providerMessage,_this.refundReason);
}

@override
String toString() {
  final _this = this as Payment;
  return 'Payment(id: ${_this.id}, competitionId: ${_this.competitionId}, amountMinor: ${_this.amountMinor}, currency: ${_this.currency}, maskedPhone: ${_this.maskedPhone}, status: ${_this.status}, registrationStatus: ${_this.registrationStatus}, providerMessage: ${_this.providerMessage}, refundReason: ${_this.refundReason})';
}


}

/// @nodoc
abstract mixin class $PaymentCopyWith<$Res>  {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) _then) = _$PaymentCopyWithImpl;
@useResult
$Res call({
 String id, String competitionId, int amountMinor, String currency,@JsonKey(name: 'phoneNumber') String maskedPhone,@JsonKey(unknownEnumValue: PaymentStatus.pending) PaymentStatus status,@JsonKey(unknownEnumValue: RegistrationOutcome.pending) RegistrationOutcome registrationStatus,@JsonKey(name: 'providerResultDescription') String? providerMessage,@JsonKey(readValue: _refundReason) String? refundReason
});




}
/// @nodoc
class _$PaymentCopyWithImpl<$Res>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._self, this._then);

  final Payment _self;
  final $Res Function(Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? competitionId = null,Object? amountMinor = null,Object? currency = null,Object? maskedPhone = null,Object? status = null,Object? registrationStatus = null,Object? providerMessage = freezed,Object? refundReason = freezed,}) {
  return _then(Payment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,competitionId: null == competitionId ? _self.competitionId : competitionId // ignore: cast_nullable_to_non_nullable
as String,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,maskedPhone: null == maskedPhone ? _self.maskedPhone : maskedPhone // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,registrationStatus: null == registrationStatus ? _self.registrationStatus : registrationStatus // ignore: cast_nullable_to_non_nullable
as RegistrationOutcome,providerMessage: freezed == providerMessage ? _self.providerMessage : providerMessage // ignore: cast_nullable_to_non_nullable
as String?,refundReason: freezed == refundReason ? _self.refundReason : refundReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Payment].
extension PaymentPatterns on Payment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Payment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Payment value)  $default,){
final _that = this;
switch (_that) {
case _Payment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Payment value)?  $default,){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String competitionId,  int amountMinor,  String currency, @JsonKey(name: 'phoneNumber')  String maskedPhone, @JsonKey(unknownEnumValue: PaymentStatus.pending)  PaymentStatus status, @JsonKey(unknownEnumValue: RegistrationOutcome.pending)  RegistrationOutcome registrationStatus, @JsonKey(name: 'providerResultDescription')  String? providerMessage, @JsonKey(readValue: _refundReason)  String? refundReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.id,_that.competitionId,_that.amountMinor,_that.currency,_that.maskedPhone,_that.status,_that.registrationStatus,_that.providerMessage,_that.refundReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String competitionId,  int amountMinor,  String currency, @JsonKey(name: 'phoneNumber')  String maskedPhone, @JsonKey(unknownEnumValue: PaymentStatus.pending)  PaymentStatus status, @JsonKey(unknownEnumValue: RegistrationOutcome.pending)  RegistrationOutcome registrationStatus, @JsonKey(name: 'providerResultDescription')  String? providerMessage, @JsonKey(readValue: _refundReason)  String? refundReason)  $default,) {final _that = this;
switch (_that) {
case _Payment():
return $default(_that.id,_that.competitionId,_that.amountMinor,_that.currency,_that.maskedPhone,_that.status,_that.registrationStatus,_that.providerMessage,_that.refundReason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String competitionId,  int amountMinor,  String currency, @JsonKey(name: 'phoneNumber')  String maskedPhone, @JsonKey(unknownEnumValue: PaymentStatus.pending)  PaymentStatus status, @JsonKey(unknownEnumValue: RegistrationOutcome.pending)  RegistrationOutcome registrationStatus, @JsonKey(name: 'providerResultDescription')  String? providerMessage, @JsonKey(readValue: _refundReason)  String? refundReason)?  $default,) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.id,_that.competitionId,_that.amountMinor,_that.currency,_that.maskedPhone,_that.status,_that.registrationStatus,_that.providerMessage,_that.refundReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _Payment extends Payment {
  const _Payment({required this.id, required this.competitionId, required this.amountMinor, required this.currency, @JsonKey(name: 'phoneNumber') this.maskedPhone = '', @JsonKey(unknownEnumValue: PaymentStatus.pending) required this.status, @JsonKey(unknownEnumValue: RegistrationOutcome.pending) required this.registrationStatus, @JsonKey(name: 'providerResultDescription') this.providerMessage, @JsonKey(readValue: _refundReason) this.refundReason}): super._();
  factory _Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

@override final  String id;
@override final  String competitionId;
@override final  int amountMinor;
@override final  String currency;
/// As the API returns it, already masked.
@override@JsonKey(name: 'phoneNumber') final  String maskedPhone;
@override@JsonKey(unknownEnumValue: PaymentStatus.pending) final  PaymentStatus status;
@override@JsonKey(unknownEnumValue: RegistrationOutcome.pending) final  RegistrationOutcome registrationStatus;
/// M-Pesa's own words for a failed payment, such as "Request cancelled
/// by user".
@override@JsonKey(name: 'providerResultDescription') final  String? providerMessage;
@override@JsonKey(readValue: _refundReason) final  String? refundReason;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentCopyWith<_Payment> get copyWith => __$PaymentCopyWithImpl<_Payment>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Payment&&(identical(other.id, id) || other.id == id)&&(identical(other.competitionId, competitionId) || other.competitionId == competitionId)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.maskedPhone, maskedPhone) || other.maskedPhone == maskedPhone)&&(identical(other.status, status) || other.status == status)&&(identical(other.registrationStatus, registrationStatus) || other.registrationStatus == registrationStatus)&&(identical(other.providerMessage, providerMessage) || other.providerMessage == providerMessage)&&(identical(other.refundReason, refundReason) || other.refundReason == refundReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,competitionId,amountMinor,currency,maskedPhone,status,registrationStatus,providerMessage,refundReason);
}

@override
String toString() {
    return 'Payment(id: $id, competitionId: $competitionId, amountMinor: $amountMinor, currency: $currency, maskedPhone: $maskedPhone, status: $status, registrationStatus: $registrationStatus, providerMessage: $providerMessage, refundReason: $refundReason)';
}


}

/// @nodoc
abstract mixin class _$PaymentCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$PaymentCopyWith(_Payment value, $Res Function(_Payment) _then) = __$PaymentCopyWithImpl;
@override @useResult
$Res call({
 String id, String competitionId, int amountMinor, String currency,@JsonKey(name: 'phoneNumber') String maskedPhone,@JsonKey(unknownEnumValue: PaymentStatus.pending) PaymentStatus status,@JsonKey(unknownEnumValue: RegistrationOutcome.pending) RegistrationOutcome registrationStatus,@JsonKey(name: 'providerResultDescription') String? providerMessage,@JsonKey(readValue: _refundReason) String? refundReason
});




}
/// @nodoc
class __$PaymentCopyWithImpl<$Res>
    implements _$PaymentCopyWith<$Res> {
  __$PaymentCopyWithImpl(this._self, this._then);

  final _Payment _self;
  final $Res Function(_Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? competitionId = null,Object? amountMinor = null,Object? currency = null,Object? maskedPhone = null,Object? status = null,Object? registrationStatus = null,Object? providerMessage = freezed,Object? refundReason = freezed,}) {
  return _then(_Payment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,competitionId: null == competitionId ? _self.competitionId : competitionId // ignore: cast_nullable_to_non_nullable
as String,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,maskedPhone: null == maskedPhone ? _self.maskedPhone : maskedPhone // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,registrationStatus: null == registrationStatus ? _self.registrationStatus : registrationStatus // ignore: cast_nullable_to_non_nullable
as RegistrationOutcome,providerMessage: freezed == providerMessage ? _self.providerMessage : providerMessage // ignore: cast_nullable_to_non_nullable
as String?,refundReason: freezed == refundReason ? _self.refundReason : refundReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
