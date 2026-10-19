// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'evidence.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Evidence {

 String get id;/// `pending`, `processing`, `completed`, `failed`, `rejected` or
/// `expired`.
 String get status;/// Verified and ready to attach.
 bool get ready;@JsonKey(name: 'processingErrorCode') String? get errorCode;
/// Create a copy of Evidence
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvidenceCopyWith<Evidence> get copyWith => _$EvidenceCopyWithImpl<Evidence>(this as Evidence, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Evidence;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Evidence&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.ready, _this.ready) || other.ready == _this.ready)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Evidence;
  return Object.hash(runtimeType,_this.id,_this.status,_this.ready,_this.errorCode);
}

@override
String toString() {
  final _this = this as Evidence;
  return 'Evidence(id: ${_this.id}, status: ${_this.status}, ready: ${_this.ready}, errorCode: ${_this.errorCode})';
}


}

/// @nodoc
abstract mixin class $EvidenceCopyWith<$Res>  {
  factory $EvidenceCopyWith(Evidence value, $Res Function(Evidence) _then) = _$EvidenceCopyWithImpl;
@useResult
$Res call({
 String id, String status, bool ready,@JsonKey(name: 'processingErrorCode') String? errorCode
});




}
/// @nodoc
class _$EvidenceCopyWithImpl<$Res>
    implements $EvidenceCopyWith<$Res> {
  _$EvidenceCopyWithImpl(this._self, this._then);

  final Evidence _self;
  final $Res Function(Evidence) _then;

/// Create a copy of Evidence
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? ready = null,Object? errorCode = freezed,}) {
  return _then(Evidence(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,ready: null == ready ? _self.ready : ready // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Evidence].
extension EvidencePatterns on Evidence {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Evidence value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Evidence() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Evidence value)  $default,){
final _that = this;
switch (_that) {
case _Evidence():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Evidence value)?  $default,){
final _that = this;
switch (_that) {
case _Evidence() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String status,  bool ready, @JsonKey(name: 'processingErrorCode')  String? errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Evidence() when $default != null:
return $default(_that.id,_that.status,_that.ready,_that.errorCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String status,  bool ready, @JsonKey(name: 'processingErrorCode')  String? errorCode)  $default,) {final _that = this;
switch (_that) {
case _Evidence():
return $default(_that.id,_that.status,_that.ready,_that.errorCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String status,  bool ready, @JsonKey(name: 'processingErrorCode')  String? errorCode)?  $default,) {final _that = this;
switch (_that) {
case _Evidence() when $default != null:
return $default(_that.id,_that.status,_that.ready,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _Evidence extends Evidence {
  const _Evidence({required this.id, required this.status, this.ready = false, @JsonKey(name: 'processingErrorCode') this.errorCode}): super._();
  factory _Evidence.fromJson(Map<String, dynamic> json) => _$EvidenceFromJson(json);

@override final  String id;
/// `pending`, `processing`, `completed`, `failed`, `rejected` or
/// `expired`.
@override final  String status;
/// Verified and ready to attach.
@override@JsonKey() final  bool ready;
@override@JsonKey(name: 'processingErrorCode') final  String? errorCode;

/// Create a copy of Evidence
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvidenceCopyWith<_Evidence> get copyWith => __$EvidenceCopyWithImpl<_Evidence>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Evidence&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.ready, ready) || other.ready == ready)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,status,ready,errorCode);
}

@override
String toString() {
    return 'Evidence(id: $id, status: $status, ready: $ready, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$EvidenceCopyWith<$Res> implements $EvidenceCopyWith<$Res> {
  factory _$EvidenceCopyWith(_Evidence value, $Res Function(_Evidence) _then) = __$EvidenceCopyWithImpl;
@override @useResult
$Res call({
 String id, String status, bool ready,@JsonKey(name: 'processingErrorCode') String? errorCode
});




}
/// @nodoc
class __$EvidenceCopyWithImpl<$Res>
    implements _$EvidenceCopyWith<$Res> {
  __$EvidenceCopyWithImpl(this._self, this._then);

  final _Evidence _self;
  final $Res Function(_Evidence) _then;

/// Create a copy of Evidence
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? ready = null,Object? errorCode = freezed,}) {
  return _then(_Evidence(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,ready: null == ready ? _self.ready : ready // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UploadIntent {

 String get id;@JsonKey(name: 'uploadUrl') Uri get url;/// Must be sent unchanged: the signature covers them.
@JsonKey(name: 'requiredHeaders') Map<String, String> get headers;
/// Create a copy of UploadIntent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadIntentCopyWith<UploadIntent> get copyWith => _$UploadIntentCopyWithImpl<UploadIntent>(this as UploadIntent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UploadIntent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadIntent&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.url, _this.url) || other.url == _this.url)&&const DeepCollectionEquality().equals(other.headers, _this.headers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UploadIntent;
  return Object.hash(runtimeType,_this.id,_this.url,const DeepCollectionEquality().hash(_this.headers));
}

@override
String toString() {
  final _this = this as UploadIntent;
  return 'UploadIntent(id: ${_this.id}, url: ${_this.url}, headers: ${_this.headers})';
}


}

/// @nodoc
abstract mixin class $UploadIntentCopyWith<$Res>  {
  factory $UploadIntentCopyWith(UploadIntent value, $Res Function(UploadIntent) _then) = _$UploadIntentCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'uploadUrl') Uri url,@JsonKey(name: 'requiredHeaders') Map<String, String> headers
});




}
/// @nodoc
class _$UploadIntentCopyWithImpl<$Res>
    implements $UploadIntentCopyWith<$Res> {
  _$UploadIntentCopyWithImpl(this._self, this._then);

  final UploadIntent _self;
  final $Res Function(UploadIntent) _then;

/// Create a copy of UploadIntent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? url = null,Object? headers = null,}) {
  return _then(UploadIntent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as Uri,headers: null == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [UploadIntent].
extension UploadIntentPatterns on UploadIntent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UploadIntent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UploadIntent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UploadIntent value)  $default,){
final _that = this;
switch (_that) {
case _UploadIntent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UploadIntent value)?  $default,){
final _that = this;
switch (_that) {
case _UploadIntent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'uploadUrl')  Uri url, @JsonKey(name: 'requiredHeaders')  Map<String, String> headers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UploadIntent() when $default != null:
return $default(_that.id,_that.url,_that.headers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'uploadUrl')  Uri url, @JsonKey(name: 'requiredHeaders')  Map<String, String> headers)  $default,) {final _that = this;
switch (_that) {
case _UploadIntent():
return $default(_that.id,_that.url,_that.headers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'uploadUrl')  Uri url, @JsonKey(name: 'requiredHeaders')  Map<String, String> headers)?  $default,) {final _that = this;
switch (_that) {
case _UploadIntent() when $default != null:
return $default(_that.id,_that.url,_that.headers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _UploadIntent implements UploadIntent {
  const _UploadIntent({required this.id, @JsonKey(name: 'uploadUrl') required this.url, @JsonKey(name: 'requiredHeaders') required  Map<String, String> headers}): _headers = headers;
  factory _UploadIntent.fromJson(Map<String, dynamic> json) => _$UploadIntentFromJson(json);

@override final  String id;
@override@JsonKey(name: 'uploadUrl') final  Uri url;
/// Must be sent unchanged: the signature covers them.
 final  Map<String, String> _headers;
/// Must be sent unchanged: the signature covers them.
@override@JsonKey(name: 'requiredHeaders') Map<String, String> get headers {
  if (_headers is EqualUnmodifiableMapView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_headers);
}


/// Create a copy of UploadIntent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadIntentCopyWith<_UploadIntent> get copyWith => __$UploadIntentCopyWithImpl<_UploadIntent>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadIntent&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.headers, _headers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,url,const DeepCollectionEquality().hash(_headers));
}

@override
String toString() {
    return 'UploadIntent(id: $id, url: $url, headers: $headers)';
}


}

/// @nodoc
abstract mixin class _$UploadIntentCopyWith<$Res> implements $UploadIntentCopyWith<$Res> {
  factory _$UploadIntentCopyWith(_UploadIntent value, $Res Function(_UploadIntent) _then) = __$UploadIntentCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'uploadUrl') Uri url,@JsonKey(name: 'requiredHeaders') Map<String, String> headers
});




}
/// @nodoc
class __$UploadIntentCopyWithImpl<$Res>
    implements _$UploadIntentCopyWith<$Res> {
  __$UploadIntentCopyWithImpl(this._self, this._then);

  final _UploadIntent _self;
  final $Res Function(_UploadIntent) _then;

/// Create a copy of UploadIntent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? url = null,Object? headers = null,}) {
  return _then(_UploadIntent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as Uri,headers: null == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

// dart format on
