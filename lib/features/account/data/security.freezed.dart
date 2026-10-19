// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceSession {

 String get id;/// What the app called the device when it signed in, such as
/// "Ozone on android". Can be empty.
 String get deviceName; String get userAgent; DateTime get createdAt; DateTime get lastUsedAt; DateTime? get revokedAt;/// The session this request was made with: this device.
 bool get current;
/// Create a copy of DeviceSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceSessionCopyWith<DeviceSession> get copyWith => _$DeviceSessionCopyWithImpl<DeviceSession>(this as DeviceSession, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DeviceSession;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceSession&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.deviceName, _this.deviceName) || other.deviceName == _this.deviceName)&&(identical(other.userAgent, _this.userAgent) || other.userAgent == _this.userAgent)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.lastUsedAt, _this.lastUsedAt) || other.lastUsedAt == _this.lastUsedAt)&&(identical(other.revokedAt, _this.revokedAt) || other.revokedAt == _this.revokedAt)&&(identical(other.current, _this.current) || other.current == _this.current));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DeviceSession;
  return Object.hash(runtimeType,_this.id,_this.deviceName,_this.userAgent,_this.createdAt,_this.lastUsedAt,_this.revokedAt,_this.current);
}

@override
String toString() {
  final _this = this as DeviceSession;
  return 'DeviceSession(id: ${_this.id}, deviceName: ${_this.deviceName}, userAgent: ${_this.userAgent}, createdAt: ${_this.createdAt}, lastUsedAt: ${_this.lastUsedAt}, revokedAt: ${_this.revokedAt}, current: ${_this.current})';
}


}

/// @nodoc
abstract mixin class $DeviceSessionCopyWith<$Res>  {
  factory $DeviceSessionCopyWith(DeviceSession value, $Res Function(DeviceSession) _then) = _$DeviceSessionCopyWithImpl;
@useResult
$Res call({
 String id, String deviceName, String userAgent, DateTime createdAt, DateTime lastUsedAt, DateTime? revokedAt, bool current
});




}
/// @nodoc
class _$DeviceSessionCopyWithImpl<$Res>
    implements $DeviceSessionCopyWith<$Res> {
  _$DeviceSessionCopyWithImpl(this._self, this._then);

  final DeviceSession _self;
  final $Res Function(DeviceSession) _then;

/// Create a copy of DeviceSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? deviceName = null,Object? userAgent = null,Object? createdAt = null,Object? lastUsedAt = null,Object? revokedAt = freezed,Object? current = null,}) {
  return _then(DeviceSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,userAgent: null == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastUsedAt: null == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceSession].
extension DeviceSessionPatterns on DeviceSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceSession value)  $default,){
final _that = this;
switch (_that) {
case _DeviceSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceSession value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String deviceName,  String userAgent,  DateTime createdAt,  DateTime lastUsedAt,  DateTime? revokedAt,  bool current)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceSession() when $default != null:
return $default(_that.id,_that.deviceName,_that.userAgent,_that.createdAt,_that.lastUsedAt,_that.revokedAt,_that.current);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String deviceName,  String userAgent,  DateTime createdAt,  DateTime lastUsedAt,  DateTime? revokedAt,  bool current)  $default,) {final _that = this;
switch (_that) {
case _DeviceSession():
return $default(_that.id,_that.deviceName,_that.userAgent,_that.createdAt,_that.lastUsedAt,_that.revokedAt,_that.current);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String deviceName,  String userAgent,  DateTime createdAt,  DateTime lastUsedAt,  DateTime? revokedAt,  bool current)?  $default,) {final _that = this;
switch (_that) {
case _DeviceSession() when $default != null:
return $default(_that.id,_that.deviceName,_that.userAgent,_that.createdAt,_that.lastUsedAt,_that.revokedAt,_that.current);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _DeviceSession extends DeviceSession {
  const _DeviceSession({required this.id, this.deviceName = '', this.userAgent = '', required this.createdAt, required this.lastUsedAt, this.revokedAt, this.current = false}): super._();
  factory _DeviceSession.fromJson(Map<String, dynamic> json) => _$DeviceSessionFromJson(json);

@override final  String id;
/// What the app called the device when it signed in, such as
/// "Ozone on android". Can be empty.
@override@JsonKey() final  String deviceName;
@override@JsonKey() final  String userAgent;
@override final  DateTime createdAt;
@override final  DateTime lastUsedAt;
@override final  DateTime? revokedAt;
/// The session this request was made with: this device.
@override@JsonKey() final  bool current;

/// Create a copy of DeviceSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceSessionCopyWith<_DeviceSession> get copyWith => __$DeviceSessionCopyWithImpl<_DeviceSession>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceSession&&(identical(other.id, id) || other.id == id)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt)&&(identical(other.current, current) || other.current == current));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,deviceName,userAgent,createdAt,lastUsedAt,revokedAt,current);
}

@override
String toString() {
    return 'DeviceSession(id: $id, deviceName: $deviceName, userAgent: $userAgent, createdAt: $createdAt, lastUsedAt: $lastUsedAt, revokedAt: $revokedAt, current: $current)';
}


}

/// @nodoc
abstract mixin class _$DeviceSessionCopyWith<$Res> implements $DeviceSessionCopyWith<$Res> {
  factory _$DeviceSessionCopyWith(_DeviceSession value, $Res Function(_DeviceSession) _then) = __$DeviceSessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String deviceName, String userAgent, DateTime createdAt, DateTime lastUsedAt, DateTime? revokedAt, bool current
});




}
/// @nodoc
class __$DeviceSessionCopyWithImpl<$Res>
    implements _$DeviceSessionCopyWith<$Res> {
  __$DeviceSessionCopyWithImpl(this._self, this._then);

  final _DeviceSession _self;
  final $Res Function(_DeviceSession) _then;

/// Create a copy of DeviceSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? deviceName = null,Object? userAgent = null,Object? createdAt = null,Object? lastUsedAt = null,Object? revokedAt = freezed,Object? current = null,}) {
  return _then(_DeviceSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,userAgent: null == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastUsedAt: null == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$DeletionRequest {

 String get id;@JsonKey(unknownEnumValue: DeletionStatus.unknown) DeletionStatus get status; DateTime get requestedAt;/// The end of the 24-hour wait: deleting is possible from then on.
 DateTime get executeAfter;
/// Create a copy of DeletionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeletionRequestCopyWith<DeletionRequest> get copyWith => _$DeletionRequestCopyWithImpl<DeletionRequest>(this as DeletionRequest, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DeletionRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeletionRequest&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.requestedAt, _this.requestedAt) || other.requestedAt == _this.requestedAt)&&(identical(other.executeAfter, _this.executeAfter) || other.executeAfter == _this.executeAfter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DeletionRequest;
  return Object.hash(runtimeType,_this.id,_this.status,_this.requestedAt,_this.executeAfter);
}

@override
String toString() {
  final _this = this as DeletionRequest;
  return 'DeletionRequest(id: ${_this.id}, status: ${_this.status}, requestedAt: ${_this.requestedAt}, executeAfter: ${_this.executeAfter})';
}


}

/// @nodoc
abstract mixin class $DeletionRequestCopyWith<$Res>  {
  factory $DeletionRequestCopyWith(DeletionRequest value, $Res Function(DeletionRequest) _then) = _$DeletionRequestCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(unknownEnumValue: DeletionStatus.unknown) DeletionStatus status, DateTime requestedAt, DateTime executeAfter
});




}
/// @nodoc
class _$DeletionRequestCopyWithImpl<$Res>
    implements $DeletionRequestCopyWith<$Res> {
  _$DeletionRequestCopyWithImpl(this._self, this._then);

  final DeletionRequest _self;
  final $Res Function(DeletionRequest) _then;

/// Create a copy of DeletionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? requestedAt = null,Object? executeAfter = null,}) {
  return _then(DeletionRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DeletionStatus,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime,executeAfter: null == executeAfter ? _self.executeAfter : executeAfter // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DeletionRequest].
extension DeletionRequestPatterns on DeletionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeletionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeletionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeletionRequest value)  $default,){
final _that = this;
switch (_that) {
case _DeletionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeletionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _DeletionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(unknownEnumValue: DeletionStatus.unknown)  DeletionStatus status,  DateTime requestedAt,  DateTime executeAfter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeletionRequest() when $default != null:
return $default(_that.id,_that.status,_that.requestedAt,_that.executeAfter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(unknownEnumValue: DeletionStatus.unknown)  DeletionStatus status,  DateTime requestedAt,  DateTime executeAfter)  $default,) {final _that = this;
switch (_that) {
case _DeletionRequest():
return $default(_that.id,_that.status,_that.requestedAt,_that.executeAfter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(unknownEnumValue: DeletionStatus.unknown)  DeletionStatus status,  DateTime requestedAt,  DateTime executeAfter)?  $default,) {final _that = this;
switch (_that) {
case _DeletionRequest() when $default != null:
return $default(_that.id,_that.status,_that.requestedAt,_that.executeAfter);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _DeletionRequest implements DeletionRequest {
  const _DeletionRequest({required this.id, @JsonKey(unknownEnumValue: DeletionStatus.unknown) required this.status, required this.requestedAt, required this.executeAfter});
  factory _DeletionRequest.fromJson(Map<String, dynamic> json) => _$DeletionRequestFromJson(json);

@override final  String id;
@override@JsonKey(unknownEnumValue: DeletionStatus.unknown) final  DeletionStatus status;
@override final  DateTime requestedAt;
/// The end of the 24-hour wait: deleting is possible from then on.
@override final  DateTime executeAfter;

/// Create a copy of DeletionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeletionRequestCopyWith<_DeletionRequest> get copyWith => __$DeletionRequestCopyWithImpl<_DeletionRequest>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeletionRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.executeAfter, executeAfter) || other.executeAfter == executeAfter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,status,requestedAt,executeAfter);
}

@override
String toString() {
    return 'DeletionRequest(id: $id, status: $status, requestedAt: $requestedAt, executeAfter: $executeAfter)';
}


}

/// @nodoc
abstract mixin class _$DeletionRequestCopyWith<$Res> implements $DeletionRequestCopyWith<$Res> {
  factory _$DeletionRequestCopyWith(_DeletionRequest value, $Res Function(_DeletionRequest) _then) = __$DeletionRequestCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(unknownEnumValue: DeletionStatus.unknown) DeletionStatus status, DateTime requestedAt, DateTime executeAfter
});




}
/// @nodoc
class __$DeletionRequestCopyWithImpl<$Res>
    implements _$DeletionRequestCopyWith<$Res> {
  __$DeletionRequestCopyWithImpl(this._self, this._then);

  final _DeletionRequest _self;
  final $Res Function(_DeletionRequest) _then;

/// Create a copy of DeletionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? requestedAt = null,Object? executeAfter = null,}) {
  return _then(_DeletionRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DeletionStatus,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime,executeAfter: null == executeAfter ? _self.executeAfter : executeAfter // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
