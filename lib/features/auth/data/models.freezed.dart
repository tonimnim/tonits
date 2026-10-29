// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Player {

 String get id; String? get username; String? get konamiId; String get displayName; String? get email; bool get emailVerified; String? get phoneNumber;/// Empty until onboarding for a new Google or Apple player.
 String get countryCode; String get status;/// False after a first Google or Apple sign-in, until the player adds
/// their Konami ID, phone and country. Accounts from before onboarding
/// existed are complete.
 bool get onboardingCompleted;/// Proven by a successful M-Pesa payment from the number.
 bool get phoneVerified;/// Asked for only by a competition with a minimum age.
 DateTime? get birthDate;/// `google`, `apple` and, for staff accounts, `password`.
 Set<String> get signInMethods;/// What the player can change about their public profile.
 ProfileSettings? get profile;
/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerCopyWith<Player> get copyWith => _$PlayerCopyWithImpl<Player>(this as Player, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Player;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Player&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.konamiId, _this.konamiId) || other.konamiId == _this.konamiId)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.emailVerified, _this.emailVerified) || other.emailVerified == _this.emailVerified)&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.countryCode, _this.countryCode) || other.countryCode == _this.countryCode)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.onboardingCompleted, _this.onboardingCompleted) || other.onboardingCompleted == _this.onboardingCompleted)&&(identical(other.phoneVerified, _this.phoneVerified) || other.phoneVerified == _this.phoneVerified)&&(identical(other.birthDate, _this.birthDate) || other.birthDate == _this.birthDate)&&const DeepCollectionEquality().equals(other.signInMethods, _this.signInMethods)&&(identical(other.profile, _this.profile) || other.profile == _this.profile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Player;
  return Object.hash(runtimeType,_this.id,_this.username,_this.konamiId,_this.displayName,_this.email,_this.emailVerified,_this.phoneNumber,_this.countryCode,_this.status,_this.onboardingCompleted,_this.phoneVerified,_this.birthDate,const DeepCollectionEquality().hash(_this.signInMethods),_this.profile);
}

@override
String toString() {
  final _this = this as Player;
  return 'Player(id: ${_this.id}, username: ${_this.username}, konamiId: ${_this.konamiId}, displayName: ${_this.displayName}, email: ${_this.email}, emailVerified: ${_this.emailVerified}, phoneNumber: ${_this.phoneNumber}, countryCode: ${_this.countryCode}, status: ${_this.status}, onboardingCompleted: ${_this.onboardingCompleted}, phoneVerified: ${_this.phoneVerified}, birthDate: ${_this.birthDate}, signInMethods: ${_this.signInMethods}, profile: ${_this.profile})';
}


}

/// @nodoc
abstract mixin class $PlayerCopyWith<$Res>  {
  factory $PlayerCopyWith(Player value, $Res Function(Player) _then) = _$PlayerCopyWithImpl;
@useResult
$Res call({
 String id, String? username, String? konamiId, String displayName, String? email, bool emailVerified, String? phoneNumber, String countryCode, String status, bool onboardingCompleted, bool phoneVerified, DateTime? birthDate, Set<String> signInMethods, ProfileSettings? profile
});


$ProfileSettingsCopyWith<$Res>? get profile;

}
/// @nodoc
class _$PlayerCopyWithImpl<$Res>
    implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._self, this._then);

  final Player _self;
  final $Res Function(Player) _then;

/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = freezed,Object? konamiId = freezed,Object? displayName = null,Object? email = freezed,Object? emailVerified = null,Object? phoneNumber = freezed,Object? countryCode = null,Object? status = null,Object? onboardingCompleted = null,Object? phoneVerified = null,Object? birthDate = freezed,Object? signInMethods = null,Object? profile = freezed,}) {
  return _then(Player(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,konamiId: freezed == konamiId ? _self.konamiId : konamiId // ignore: cast_nullable_to_non_nullable
as String?,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,emailVerified: null == emailVerified ? _self.emailVerified : emailVerified // ignore: cast_nullable_to_non_nullable
as bool,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,onboardingCompleted: null == onboardingCompleted ? _self.onboardingCompleted : onboardingCompleted // ignore: cast_nullable_to_non_nullable
as bool,phoneVerified: null == phoneVerified ? _self.phoneVerified : phoneVerified // ignore: cast_nullable_to_non_nullable
as bool,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,signInMethods: null == signInMethods ? _self.signInMethods : signInMethods // ignore: cast_nullable_to_non_nullable
as Set<String>,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as ProfileSettings?,
  ));
}
/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileSettingsCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $ProfileSettingsCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}


/// Adds pattern-matching-related methods to [Player].
extension PlayerPatterns on Player {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Player value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Player() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Player value)  $default,){
final _that = this;
switch (_that) {
case _Player():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Player value)?  $default,){
final _that = this;
switch (_that) {
case _Player() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? username,  String? konamiId,  String displayName,  String? email,  bool emailVerified,  String? phoneNumber,  String countryCode,  String status,  bool onboardingCompleted,  bool phoneVerified,  DateTime? birthDate,  Set<String> signInMethods,  ProfileSettings? profile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Player() when $default != null:
return $default(_that.id,_that.username,_that.konamiId,_that.displayName,_that.email,_that.emailVerified,_that.phoneNumber,_that.countryCode,_that.status,_that.onboardingCompleted,_that.phoneVerified,_that.birthDate,_that.signInMethods,_that.profile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? username,  String? konamiId,  String displayName,  String? email,  bool emailVerified,  String? phoneNumber,  String countryCode,  String status,  bool onboardingCompleted,  bool phoneVerified,  DateTime? birthDate,  Set<String> signInMethods,  ProfileSettings? profile)  $default,) {final _that = this;
switch (_that) {
case _Player():
return $default(_that.id,_that.username,_that.konamiId,_that.displayName,_that.email,_that.emailVerified,_that.phoneNumber,_that.countryCode,_that.status,_that.onboardingCompleted,_that.phoneVerified,_that.birthDate,_that.signInMethods,_that.profile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? username,  String? konamiId,  String displayName,  String? email,  bool emailVerified,  String? phoneNumber,  String countryCode,  String status,  bool onboardingCompleted,  bool phoneVerified,  DateTime? birthDate,  Set<String> signInMethods,  ProfileSettings? profile)?  $default,) {final _that = this;
switch (_that) {
case _Player() when $default != null:
return $default(_that.id,_that.username,_that.konamiId,_that.displayName,_that.email,_that.emailVerified,_that.phoneNumber,_that.countryCode,_that.status,_that.onboardingCompleted,_that.phoneVerified,_that.birthDate,_that.signInMethods,_that.profile);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _Player extends Player {
  const _Player({required this.id, required this.username, required this.konamiId, required this.displayName, required this.email, this.emailVerified = false, required this.phoneNumber, this.countryCode = '', required this.status, this.onboardingCompleted = true, this.phoneVerified = false, this.birthDate,  Set<String> signInMethods = const <String>{}, this.profile}): _signInMethods = signInMethods,super._();
  factory _Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

@override final  String id;
@override final  String? username;
@override final  String? konamiId;
@override final  String displayName;
@override final  String? email;
@override@JsonKey() final  bool emailVerified;
@override final  String? phoneNumber;
/// Empty until onboarding for a new Google or Apple player.
@override@JsonKey() final  String countryCode;
@override final  String status;
/// False after a first Google or Apple sign-in, until the player adds
/// their Konami ID, phone and country. Accounts from before onboarding
/// existed are complete.
@override@JsonKey() final  bool onboardingCompleted;
/// Proven by a successful M-Pesa payment from the number.
@override@JsonKey() final  bool phoneVerified;
/// Asked for only by a competition with a minimum age.
@override final  DateTime? birthDate;
/// `google`, `apple` and, for staff accounts, `password`.
 final  Set<String> _signInMethods;
/// `google`, `apple` and, for staff accounts, `password`.
@override@JsonKey() Set<String> get signInMethods {
  if (_signInMethods is EqualUnmodifiableSetView) return _signInMethods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_signInMethods);
}

/// What the player can change about their public profile.
@override final  ProfileSettings? profile;

/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerCopyWith<_Player> get copyWith => __$PlayerCopyWithImpl<_Player>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Player&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.konamiId, konamiId) || other.konamiId == konamiId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.email, email) || other.email == email)&&(identical(other.emailVerified, emailVerified) || other.emailVerified == emailVerified)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.onboardingCompleted, onboardingCompleted) || other.onboardingCompleted == onboardingCompleted)&&(identical(other.phoneVerified, phoneVerified) || other.phoneVerified == phoneVerified)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&const DeepCollectionEquality().equals(other.signInMethods, _signInMethods)&&(identical(other.profile, profile) || other.profile == profile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,username,konamiId,displayName,email,emailVerified,phoneNumber,countryCode,status,onboardingCompleted,phoneVerified,birthDate,const DeepCollectionEquality().hash(_signInMethods),profile);
}

@override
String toString() {
    return 'Player(id: $id, username: $username, konamiId: $konamiId, displayName: $displayName, email: $email, emailVerified: $emailVerified, phoneNumber: $phoneNumber, countryCode: $countryCode, status: $status, onboardingCompleted: $onboardingCompleted, phoneVerified: $phoneVerified, birthDate: $birthDate, signInMethods: $signInMethods, profile: $profile)';
}


}

/// @nodoc
abstract mixin class _$PlayerCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$PlayerCopyWith(_Player value, $Res Function(_Player) _then) = __$PlayerCopyWithImpl;
@override @useResult
$Res call({
 String id, String? username, String? konamiId, String displayName, String? email, bool emailVerified, String? phoneNumber, String countryCode, String status, bool onboardingCompleted, bool phoneVerified, DateTime? birthDate, Set<String> signInMethods, ProfileSettings? profile
});


@override $ProfileSettingsCopyWith<$Res>? get profile;

}
/// @nodoc
class __$PlayerCopyWithImpl<$Res>
    implements _$PlayerCopyWith<$Res> {
  __$PlayerCopyWithImpl(this._self, this._then);

  final _Player _self;
  final $Res Function(_Player) _then;

/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = freezed,Object? konamiId = freezed,Object? displayName = null,Object? email = freezed,Object? emailVerified = null,Object? phoneNumber = freezed,Object? countryCode = null,Object? status = null,Object? onboardingCompleted = null,Object? phoneVerified = null,Object? birthDate = freezed,Object? signInMethods = null,Object? profile = freezed,}) {
  return _then(_Player(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,konamiId: freezed == konamiId ? _self.konamiId : konamiId // ignore: cast_nullable_to_non_nullable
as String?,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,emailVerified: null == emailVerified ? _self.emailVerified : emailVerified // ignore: cast_nullable_to_non_nullable
as bool,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,onboardingCompleted: null == onboardingCompleted ? _self.onboardingCompleted : onboardingCompleted // ignore: cast_nullable_to_non_nullable
as bool,phoneVerified: null == phoneVerified ? _self.phoneVerified : phoneVerified // ignore: cast_nullable_to_non_nullable
as bool,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,signInMethods: null == signInMethods ? _self._signInMethods : signInMethods // ignore: cast_nullable_to_non_nullable
as Set<String>,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as ProfileSettings?,
  ));
}

/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileSettingsCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $ProfileSettingsCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}


/// @nodoc
mixin _$ProfileSettings {

/// The username, as `@handle`: 3 to 24 letters, digits, `_` or `.`,
/// starting with a letter or digit.
 String get handle; bool get analyticsConsent; bool get scoutingConsent;
/// Create a copy of ProfileSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileSettingsCopyWith<ProfileSettings> get copyWith => _$ProfileSettingsCopyWithImpl<ProfileSettings>(this as ProfileSettings, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProfileSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSettings&&(identical(other.handle, _this.handle) || other.handle == _this.handle)&&(identical(other.analyticsConsent, _this.analyticsConsent) || other.analyticsConsent == _this.analyticsConsent)&&(identical(other.scoutingConsent, _this.scoutingConsent) || other.scoutingConsent == _this.scoutingConsent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProfileSettings;
  return Object.hash(runtimeType,_this.handle,_this.analyticsConsent,_this.scoutingConsent);
}

@override
String toString() {
  final _this = this as ProfileSettings;
  return 'ProfileSettings(handle: ${_this.handle}, analyticsConsent: ${_this.analyticsConsent}, scoutingConsent: ${_this.scoutingConsent})';
}


}

/// @nodoc
abstract mixin class $ProfileSettingsCopyWith<$Res>  {
  factory $ProfileSettingsCopyWith(ProfileSettings value, $Res Function(ProfileSettings) _then) = _$ProfileSettingsCopyWithImpl;
@useResult
$Res call({
 String handle, bool analyticsConsent, bool scoutingConsent
});




}
/// @nodoc
class _$ProfileSettingsCopyWithImpl<$Res>
    implements $ProfileSettingsCopyWith<$Res> {
  _$ProfileSettingsCopyWithImpl(this._self, this._then);

  final ProfileSettings _self;
  final $Res Function(ProfileSettings) _then;

/// Create a copy of ProfileSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? handle = null,Object? analyticsConsent = null,Object? scoutingConsent = null,}) {
  return _then(ProfileSettings(
handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,analyticsConsent: null == analyticsConsent ? _self.analyticsConsent : analyticsConsent // ignore: cast_nullable_to_non_nullable
as bool,scoutingConsent: null == scoutingConsent ? _self.scoutingConsent : scoutingConsent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileSettings].
extension ProfileSettingsPatterns on ProfileSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileSettings value)  $default,){
final _that = this;
switch (_that) {
case _ProfileSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileSettings value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String handle,  bool analyticsConsent,  bool scoutingConsent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileSettings() when $default != null:
return $default(_that.handle,_that.analyticsConsent,_that.scoutingConsent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String handle,  bool analyticsConsent,  bool scoutingConsent)  $default,) {final _that = this;
switch (_that) {
case _ProfileSettings():
return $default(_that.handle,_that.analyticsConsent,_that.scoutingConsent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String handle,  bool analyticsConsent,  bool scoutingConsent)?  $default,) {final _that = this;
switch (_that) {
case _ProfileSettings() when $default != null:
return $default(_that.handle,_that.analyticsConsent,_that.scoutingConsent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _ProfileSettings implements ProfileSettings {
  const _ProfileSettings({required this.handle, this.analyticsConsent = false, this.scoutingConsent = false});
  factory _ProfileSettings.fromJson(Map<String, dynamic> json) => _$ProfileSettingsFromJson(json);

/// The username, as `@handle`: 3 to 24 letters, digits, `_` or `.`,
/// starting with a letter or digit.
@override final  String handle;
@override@JsonKey() final  bool analyticsConsent;
@override@JsonKey() final  bool scoutingConsent;

/// Create a copy of ProfileSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileSettingsCopyWith<_ProfileSettings> get copyWith => __$ProfileSettingsCopyWithImpl<_ProfileSettings>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileSettings&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.analyticsConsent, analyticsConsent) || other.analyticsConsent == analyticsConsent)&&(identical(other.scoutingConsent, scoutingConsent) || other.scoutingConsent == scoutingConsent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,handle,analyticsConsent,scoutingConsent);
}

@override
String toString() {
    return 'ProfileSettings(handle: $handle, analyticsConsent: $analyticsConsent, scoutingConsent: $scoutingConsent)';
}


}

/// @nodoc
abstract mixin class _$ProfileSettingsCopyWith<$Res> implements $ProfileSettingsCopyWith<$Res> {
  factory _$ProfileSettingsCopyWith(_ProfileSettings value, $Res Function(_ProfileSettings) _then) = __$ProfileSettingsCopyWithImpl;
@override @useResult
$Res call({
 String handle, bool analyticsConsent, bool scoutingConsent
});




}
/// @nodoc
class __$ProfileSettingsCopyWithImpl<$Res>
    implements _$ProfileSettingsCopyWith<$Res> {
  __$ProfileSettingsCopyWithImpl(this._self, this._then);

  final _ProfileSettings _self;
  final $Res Function(_ProfileSettings) _then;

/// Create a copy of ProfileSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? handle = null,Object? analyticsConsent = null,Object? scoutingConsent = null,}) {
  return _then(_ProfileSettings(
handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,analyticsConsent: null == analyticsConsent ? _self.analyticsConsent : analyticsConsent // ignore: cast_nullable_to_non_nullable
as bool,scoutingConsent: null == scoutingConsent ? _self.scoutingConsent : scoutingConsent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$AuthSession {

 String get accessToken; String get refreshToken;@JsonKey(name: 'expiresInSeconds', fromJson: _seconds) Duration get expiresIn; Player get player;
/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthSessionCopyWith<AuthSession> get copyWith => _$AuthSessionCopyWithImpl<AuthSession>(this as AuthSession, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AuthSession;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSession&&(identical(other.accessToken, _this.accessToken) || other.accessToken == _this.accessToken)&&(identical(other.refreshToken, _this.refreshToken) || other.refreshToken == _this.refreshToken)&&(identical(other.expiresIn, _this.expiresIn) || other.expiresIn == _this.expiresIn)&&(identical(other.player, _this.player) || other.player == _this.player));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AuthSession;
  return Object.hash(runtimeType,_this.accessToken,_this.refreshToken,_this.expiresIn,_this.player);
}

@override
String toString() {
  final _this = this as AuthSession;
  return 'AuthSession(accessToken: ${_this.accessToken}, refreshToken: ${_this.refreshToken}, expiresIn: ${_this.expiresIn}, player: ${_this.player})';
}


}

/// @nodoc
abstract mixin class $AuthSessionCopyWith<$Res>  {
  factory $AuthSessionCopyWith(AuthSession value, $Res Function(AuthSession) _then) = _$AuthSessionCopyWithImpl;
@useResult
$Res call({
 String accessToken, String refreshToken,@JsonKey(name: 'expiresInSeconds', fromJson: _seconds) Duration expiresIn, Player player
});


$PlayerCopyWith<$Res> get player;

}
/// @nodoc
class _$AuthSessionCopyWithImpl<$Res>
    implements $AuthSessionCopyWith<$Res> {
  _$AuthSessionCopyWithImpl(this._self, this._then);

  final AuthSession _self;
  final $Res Function(AuthSession) _then;

/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? refreshToken = null,Object? expiresIn = null,Object? player = null,}) {
  return _then(AuthSession(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,expiresIn: null == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as Duration,player: null == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as Player,
  ));
}
/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerCopyWith<$Res> get player {
  
  return $PlayerCopyWith<$Res>(_self.player, (value) {
    return _then(_self.copyWith(player: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthSession].
extension AuthSessionPatterns on AuthSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthSession value)  $default,){
final _that = this;
switch (_that) {
case _AuthSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthSession value)?  $default,){
final _that = this;
switch (_that) {
case _AuthSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accessToken,  String refreshToken, @JsonKey(name: 'expiresInSeconds', fromJson: _seconds)  Duration expiresIn,  Player player)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthSession() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.expiresIn,_that.player);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accessToken,  String refreshToken, @JsonKey(name: 'expiresInSeconds', fromJson: _seconds)  Duration expiresIn,  Player player)  $default,) {final _that = this;
switch (_that) {
case _AuthSession():
return $default(_that.accessToken,_that.refreshToken,_that.expiresIn,_that.player);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accessToken,  String refreshToken, @JsonKey(name: 'expiresInSeconds', fromJson: _seconds)  Duration expiresIn,  Player player)?  $default,) {final _that = this;
switch (_that) {
case _AuthSession() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.expiresIn,_that.player);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _AuthSession implements AuthSession {
  const _AuthSession({required this.accessToken, required this.refreshToken, @JsonKey(name: 'expiresInSeconds', fromJson: _seconds) required this.expiresIn, required this.player});
  factory _AuthSession.fromJson(Map<String, dynamic> json) => _$AuthSessionFromJson(json);

@override final  String accessToken;
@override final  String refreshToken;
@override@JsonKey(name: 'expiresInSeconds', fromJson: _seconds) final  Duration expiresIn;
@override final  Player player;

/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthSessionCopyWith<_AuthSession> get copyWith => __$AuthSessionCopyWithImpl<_AuthSession>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthSession&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn)&&(identical(other.player, player) || other.player == player));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,accessToken,refreshToken,expiresIn,player);
}

@override
String toString() {
    return 'AuthSession(accessToken: $accessToken, refreshToken: $refreshToken, expiresIn: $expiresIn, player: $player)';
}


}

/// @nodoc
abstract mixin class _$AuthSessionCopyWith<$Res> implements $AuthSessionCopyWith<$Res> {
  factory _$AuthSessionCopyWith(_AuthSession value, $Res Function(_AuthSession) _then) = __$AuthSessionCopyWithImpl;
@override @useResult
$Res call({
 String accessToken, String refreshToken,@JsonKey(name: 'expiresInSeconds', fromJson: _seconds) Duration expiresIn, Player player
});


@override $PlayerCopyWith<$Res> get player;

}
/// @nodoc
class __$AuthSessionCopyWithImpl<$Res>
    implements _$AuthSessionCopyWith<$Res> {
  __$AuthSessionCopyWithImpl(this._self, this._then);

  final _AuthSession _self;
  final $Res Function(_AuthSession) _then;

/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? refreshToken = null,Object? expiresIn = null,Object? player = null,}) {
  return _then(_AuthSession(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,expiresIn: null == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as Duration,player: null == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as Player,
  ));
}

/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerCopyWith<$Res> get player {
  
  return $PlayerCopyWith<$Res>(_self.player, (value) {
    return _then(_self.copyWith(player: value));
  });
}
}


/// @nodoc
mixin _$LegalDocument {

@JsonKey(name: 'documentType', unknownEnumValue: LegalDocumentType.unknown) LegalDocumentType get type; String get version;/// May be relative to the API origin.
 String get contentUrl;
/// Create a copy of LegalDocument
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LegalDocumentCopyWith<LegalDocument> get copyWith => _$LegalDocumentCopyWithImpl<LegalDocument>(this as LegalDocument, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LegalDocument;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LegalDocument&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.version, _this.version) || other.version == _this.version)&&(identical(other.contentUrl, _this.contentUrl) || other.contentUrl == _this.contentUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LegalDocument;
  return Object.hash(runtimeType,_this.type,_this.version,_this.contentUrl);
}

@override
String toString() {
  final _this = this as LegalDocument;
  return 'LegalDocument(type: ${_this.type}, version: ${_this.version}, contentUrl: ${_this.contentUrl})';
}


}

/// @nodoc
abstract mixin class $LegalDocumentCopyWith<$Res>  {
  factory $LegalDocumentCopyWith(LegalDocument value, $Res Function(LegalDocument) _then) = _$LegalDocumentCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'documentType', unknownEnumValue: LegalDocumentType.unknown) LegalDocumentType type, String version, String contentUrl
});




}
/// @nodoc
class _$LegalDocumentCopyWithImpl<$Res>
    implements $LegalDocumentCopyWith<$Res> {
  _$LegalDocumentCopyWithImpl(this._self, this._then);

  final LegalDocument _self;
  final $Res Function(LegalDocument) _then;

/// Create a copy of LegalDocument
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? version = null,Object? contentUrl = null,}) {
  return _then(LegalDocument(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LegalDocumentType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,contentUrl: null == contentUrl ? _self.contentUrl : contentUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LegalDocument].
extension LegalDocumentPatterns on LegalDocument {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LegalDocument value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LegalDocument() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LegalDocument value)  $default,){
final _that = this;
switch (_that) {
case _LegalDocument():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LegalDocument value)?  $default,){
final _that = this;
switch (_that) {
case _LegalDocument() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'documentType', unknownEnumValue: LegalDocumentType.unknown)  LegalDocumentType type,  String version,  String contentUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LegalDocument() when $default != null:
return $default(_that.type,_that.version,_that.contentUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'documentType', unknownEnumValue: LegalDocumentType.unknown)  LegalDocumentType type,  String version,  String contentUrl)  $default,) {final _that = this;
switch (_that) {
case _LegalDocument():
return $default(_that.type,_that.version,_that.contentUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'documentType', unknownEnumValue: LegalDocumentType.unknown)  LegalDocumentType type,  String version,  String contentUrl)?  $default,) {final _that = this;
switch (_that) {
case _LegalDocument() when $default != null:
return $default(_that.type,_that.version,_that.contentUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _LegalDocument implements LegalDocument {
  const _LegalDocument({@JsonKey(name: 'documentType', unknownEnumValue: LegalDocumentType.unknown) required this.type, required this.version, required this.contentUrl});
  factory _LegalDocument.fromJson(Map<String, dynamic> json) => _$LegalDocumentFromJson(json);

@override@JsonKey(name: 'documentType', unknownEnumValue: LegalDocumentType.unknown) final  LegalDocumentType type;
@override final  String version;
/// May be relative to the API origin.
@override final  String contentUrl;

/// Create a copy of LegalDocument
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LegalDocumentCopyWith<_LegalDocument> get copyWith => __$LegalDocumentCopyWithImpl<_LegalDocument>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LegalDocument&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.contentUrl, contentUrl) || other.contentUrl == contentUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,type,version,contentUrl);
}

@override
String toString() {
    return 'LegalDocument(type: $type, version: $version, contentUrl: $contentUrl)';
}


}

/// @nodoc
abstract mixin class _$LegalDocumentCopyWith<$Res> implements $LegalDocumentCopyWith<$Res> {
  factory _$LegalDocumentCopyWith(_LegalDocument value, $Res Function(_LegalDocument) _then) = __$LegalDocumentCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'documentType', unknownEnumValue: LegalDocumentType.unknown) LegalDocumentType type, String version, String contentUrl
});




}
/// @nodoc
class __$LegalDocumentCopyWithImpl<$Res>
    implements _$LegalDocumentCopyWith<$Res> {
  __$LegalDocumentCopyWithImpl(this._self, this._then);

  final _LegalDocument _self;
  final $Res Function(_LegalDocument) _then;

/// Create a copy of LegalDocument
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? version = null,Object? contentUrl = null,}) {
  return _then(_LegalDocument(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LegalDocumentType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,contentUrl: null == contentUrl ? _self.contentUrl : contentUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
