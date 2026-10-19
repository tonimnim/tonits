// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'draw.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Bracket {

 List<BracketStage> get stages;
/// Create a copy of Bracket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BracketCopyWith<Bracket> get copyWith => _$BracketCopyWithImpl<Bracket>(this as Bracket, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Bracket;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Bracket&&const DeepCollectionEquality().equals(other.stages, _this.stages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Bracket;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.stages));
}

@override
String toString() {
  final _this = this as Bracket;
  return 'Bracket(stages: ${_this.stages})';
}


}

/// @nodoc
abstract mixin class $BracketCopyWith<$Res>  {
  factory $BracketCopyWith(Bracket value, $Res Function(Bracket) _then) = _$BracketCopyWithImpl;
@useResult
$Res call({
 List<BracketStage> stages
});




}
/// @nodoc
class _$BracketCopyWithImpl<$Res>
    implements $BracketCopyWith<$Res> {
  _$BracketCopyWithImpl(this._self, this._then);

  final Bracket _self;
  final $Res Function(Bracket) _then;

/// Create a copy of Bracket
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stages = null,}) {
  return _then(Bracket(
stages: null == stages ? _self.stages : stages // ignore: cast_nullable_to_non_nullable
as List<BracketStage>,
  ));
}

}


/// Adds pattern-matching-related methods to [Bracket].
extension BracketPatterns on Bracket {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Bracket value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Bracket() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Bracket value)  $default,){
final _that = this;
switch (_that) {
case _Bracket():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Bracket value)?  $default,){
final _that = this;
switch (_that) {
case _Bracket() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<BracketStage> stages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Bracket() when $default != null:
return $default(_that.stages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<BracketStage> stages)  $default,) {final _that = this;
switch (_that) {
case _Bracket():
return $default(_that.stages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<BracketStage> stages)?  $default,) {final _that = this;
switch (_that) {
case _Bracket() when $default != null:
return $default(_that.stages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _Bracket implements Bracket {
  const _Bracket({ List<BracketStage> stages = const <BracketStage>[]}): _stages = stages;
  factory _Bracket.fromJson(Map<String, dynamic> json) => _$BracketFromJson(json);

 final  List<BracketStage> _stages;
@override@JsonKey() List<BracketStage> get stages {
  if (_stages is EqualUnmodifiableListView) return _stages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stages);
}


/// Create a copy of Bracket
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BracketCopyWith<_Bracket> get copyWith => __$BracketCopyWithImpl<_Bracket>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Bracket&&const DeepCollectionEquality().equals(other.stages, _stages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_stages));
}

@override
String toString() {
    return 'Bracket(stages: $stages)';
}


}

/// @nodoc
abstract mixin class _$BracketCopyWith<$Res> implements $BracketCopyWith<$Res> {
  factory _$BracketCopyWith(_Bracket value, $Res Function(_Bracket) _then) = __$BracketCopyWithImpl;
@override @useResult
$Res call({
 List<BracketStage> stages
});




}
/// @nodoc
class __$BracketCopyWithImpl<$Res>
    implements _$BracketCopyWith<$Res> {
  __$BracketCopyWithImpl(this._self, this._then);

  final _Bracket _self;
  final $Res Function(_Bracket) _then;

/// Create a copy of Bracket
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stages = null,}) {
  return _then(_Bracket(
stages: null == stages ? _self._stages : stages // ignore: cast_nullable_to_non_nullable
as List<BracketStage>,
  ));
}


}


/// @nodoc
mixin _$BracketStage {

 String get id; int get position;@JsonKey(unknownEnumValue: CompetitionFormat.unknown) CompetitionFormat get format;/// `pending`, `active` or `completed`.
 String get status; List<BracketRound> get rounds;
/// Create a copy of BracketStage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BracketStageCopyWith<BracketStage> get copyWith => _$BracketStageCopyWithImpl<BracketStage>(this as BracketStage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BracketStage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BracketStage&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.format, _this.format) || other.format == _this.format)&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.rounds, _this.rounds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BracketStage;
  return Object.hash(runtimeType,_this.id,_this.position,_this.format,_this.status,const DeepCollectionEquality().hash(_this.rounds));
}

@override
String toString() {
  final _this = this as BracketStage;
  return 'BracketStage(id: ${_this.id}, position: ${_this.position}, format: ${_this.format}, status: ${_this.status}, rounds: ${_this.rounds})';
}


}

/// @nodoc
abstract mixin class $BracketStageCopyWith<$Res>  {
  factory $BracketStageCopyWith(BracketStage value, $Res Function(BracketStage) _then) = _$BracketStageCopyWithImpl;
@useResult
$Res call({
 String id, int position,@JsonKey(unknownEnumValue: CompetitionFormat.unknown) CompetitionFormat format, String status, List<BracketRound> rounds
});




}
/// @nodoc
class _$BracketStageCopyWithImpl<$Res>
    implements $BracketStageCopyWith<$Res> {
  _$BracketStageCopyWithImpl(this._self, this._then);

  final BracketStage _self;
  final $Res Function(BracketStage) _then;

/// Create a copy of BracketStage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? position = null,Object? format = null,Object? status = null,Object? rounds = null,}) {
  return _then(BracketStage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as CompetitionFormat,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,rounds: null == rounds ? _self.rounds : rounds // ignore: cast_nullable_to_non_nullable
as List<BracketRound>,
  ));
}

}


/// Adds pattern-matching-related methods to [BracketStage].
extension BracketStagePatterns on BracketStage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BracketStage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BracketStage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BracketStage value)  $default,){
final _that = this;
switch (_that) {
case _BracketStage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BracketStage value)?  $default,){
final _that = this;
switch (_that) {
case _BracketStage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int position, @JsonKey(unknownEnumValue: CompetitionFormat.unknown)  CompetitionFormat format,  String status,  List<BracketRound> rounds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BracketStage() when $default != null:
return $default(_that.id,_that.position,_that.format,_that.status,_that.rounds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int position, @JsonKey(unknownEnumValue: CompetitionFormat.unknown)  CompetitionFormat format,  String status,  List<BracketRound> rounds)  $default,) {final _that = this;
switch (_that) {
case _BracketStage():
return $default(_that.id,_that.position,_that.format,_that.status,_that.rounds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int position, @JsonKey(unknownEnumValue: CompetitionFormat.unknown)  CompetitionFormat format,  String status,  List<BracketRound> rounds)?  $default,) {final _that = this;
switch (_that) {
case _BracketStage() when $default != null:
return $default(_that.id,_that.position,_that.format,_that.status,_that.rounds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _BracketStage implements BracketStage {
  const _BracketStage({required this.id, required this.position, @JsonKey(unknownEnumValue: CompetitionFormat.unknown) required this.format, required this.status,  List<BracketRound> rounds = const <BracketRound>[]}): _rounds = rounds;
  factory _BracketStage.fromJson(Map<String, dynamic> json) => _$BracketStageFromJson(json);

@override final  String id;
@override final  int position;
@override@JsonKey(unknownEnumValue: CompetitionFormat.unknown) final  CompetitionFormat format;
/// `pending`, `active` or `completed`.
@override final  String status;
 final  List<BracketRound> _rounds;
@override@JsonKey() List<BracketRound> get rounds {
  if (_rounds is EqualUnmodifiableListView) return _rounds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rounds);
}


/// Create a copy of BracketStage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BracketStageCopyWith<_BracketStage> get copyWith => __$BracketStageCopyWithImpl<_BracketStage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BracketStage&&(identical(other.id, id) || other.id == id)&&(identical(other.position, position) || other.position == position)&&(identical(other.format, format) || other.format == format)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.rounds, _rounds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,position,format,status,const DeepCollectionEquality().hash(_rounds));
}

@override
String toString() {
    return 'BracketStage(id: $id, position: $position, format: $format, status: $status, rounds: $rounds)';
}


}

/// @nodoc
abstract mixin class _$BracketStageCopyWith<$Res> implements $BracketStageCopyWith<$Res> {
  factory _$BracketStageCopyWith(_BracketStage value, $Res Function(_BracketStage) _then) = __$BracketStageCopyWithImpl;
@override @useResult
$Res call({
 String id, int position,@JsonKey(unknownEnumValue: CompetitionFormat.unknown) CompetitionFormat format, String status, List<BracketRound> rounds
});




}
/// @nodoc
class __$BracketStageCopyWithImpl<$Res>
    implements _$BracketStageCopyWith<$Res> {
  __$BracketStageCopyWithImpl(this._self, this._then);

  final _BracketStage _self;
  final $Res Function(_BracketStage) _then;

/// Create a copy of BracketStage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? position = null,Object? format = null,Object? status = null,Object? rounds = null,}) {
  return _then(_BracketStage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as CompetitionFormat,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,rounds: null == rounds ? _self._rounds : rounds // ignore: cast_nullable_to_non_nullable
as List<BracketRound>,
  ));
}


}


/// @nodoc
mixin _$BracketRound {

/// Counts from 1 within its [bracket].
 int get number;/// `main`, `bronze`, `winners`, `losers`, `grand_final`, or a group's
/// key such as `group_a`.
 String get bracket; List<BracketMatch> get matches;
/// Create a copy of BracketRound
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BracketRoundCopyWith<BracketRound> get copyWith => _$BracketRoundCopyWithImpl<BracketRound>(this as BracketRound, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BracketRound;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BracketRound&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.bracket, _this.bracket) || other.bracket == _this.bracket)&&const DeepCollectionEquality().equals(other.matches, _this.matches));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BracketRound;
  return Object.hash(runtimeType,_this.number,_this.bracket,const DeepCollectionEquality().hash(_this.matches));
}

@override
String toString() {
  final _this = this as BracketRound;
  return 'BracketRound(number: ${_this.number}, bracket: ${_this.bracket}, matches: ${_this.matches})';
}


}

/// @nodoc
abstract mixin class $BracketRoundCopyWith<$Res>  {
  factory $BracketRoundCopyWith(BracketRound value, $Res Function(BracketRound) _then) = _$BracketRoundCopyWithImpl;
@useResult
$Res call({
 int number, String bracket, List<BracketMatch> matches
});




}
/// @nodoc
class _$BracketRoundCopyWithImpl<$Res>
    implements $BracketRoundCopyWith<$Res> {
  _$BracketRoundCopyWithImpl(this._self, this._then);

  final BracketRound _self;
  final $Res Function(BracketRound) _then;

/// Create a copy of BracketRound
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = null,Object? bracket = null,Object? matches = null,}) {
  return _then(BracketRound(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,bracket: null == bracket ? _self.bracket : bracket // ignore: cast_nullable_to_non_nullable
as String,matches: null == matches ? _self.matches : matches // ignore: cast_nullable_to_non_nullable
as List<BracketMatch>,
  ));
}

}


/// Adds pattern-matching-related methods to [BracketRound].
extension BracketRoundPatterns on BracketRound {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BracketRound value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BracketRound() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BracketRound value)  $default,){
final _that = this;
switch (_that) {
case _BracketRound():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BracketRound value)?  $default,){
final _that = this;
switch (_that) {
case _BracketRound() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int number,  String bracket,  List<BracketMatch> matches)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BracketRound() when $default != null:
return $default(_that.number,_that.bracket,_that.matches);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int number,  String bracket,  List<BracketMatch> matches)  $default,) {final _that = this;
switch (_that) {
case _BracketRound():
return $default(_that.number,_that.bracket,_that.matches);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int number,  String bracket,  List<BracketMatch> matches)?  $default,) {final _that = this;
switch (_that) {
case _BracketRound() when $default != null:
return $default(_that.number,_that.bracket,_that.matches);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _BracketRound implements BracketRound {
  const _BracketRound({required this.number, required this.bracket,  List<BracketMatch> matches = const <BracketMatch>[]}): _matches = matches;
  factory _BracketRound.fromJson(Map<String, dynamic> json) => _$BracketRoundFromJson(json);

/// Counts from 1 within its [bracket].
@override final  int number;
/// `main`, `bronze`, `winners`, `losers`, `grand_final`, or a group's
/// key such as `group_a`.
@override final  String bracket;
 final  List<BracketMatch> _matches;
@override@JsonKey() List<BracketMatch> get matches {
  if (_matches is EqualUnmodifiableListView) return _matches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_matches);
}


/// Create a copy of BracketRound
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BracketRoundCopyWith<_BracketRound> get copyWith => __$BracketRoundCopyWithImpl<_BracketRound>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BracketRound&&(identical(other.number, number) || other.number == number)&&(identical(other.bracket, bracket) || other.bracket == bracket)&&const DeepCollectionEquality().equals(other.matches, _matches));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,number,bracket,const DeepCollectionEquality().hash(_matches));
}

@override
String toString() {
    return 'BracketRound(number: $number, bracket: $bracket, matches: $matches)';
}


}

/// @nodoc
abstract mixin class _$BracketRoundCopyWith<$Res> implements $BracketRoundCopyWith<$Res> {
  factory _$BracketRoundCopyWith(_BracketRound value, $Res Function(_BracketRound) _then) = __$BracketRoundCopyWithImpl;
@override @useResult
$Res call({
 int number, String bracket, List<BracketMatch> matches
});




}
/// @nodoc
class __$BracketRoundCopyWithImpl<$Res>
    implements _$BracketRoundCopyWith<$Res> {
  __$BracketRoundCopyWithImpl(this._self, this._then);

  final _BracketRound _self;
  final $Res Function(_BracketRound) _then;

/// Create a copy of BracketRound
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = null,Object? bracket = null,Object? matches = null,}) {
  return _then(_BracketRound(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,bracket: null == bracket ? _self.bracket : bracket // ignore: cast_nullable_to_non_nullable
as String,matches: null == matches ? _self._matches : matches // ignore: cast_nullable_to_non_nullable
as List<BracketMatch>,
  ));
}


}


/// @nodoc
mixin _$BracketMatch {

 String get id; int get matchNumber; int get bestOf;@JsonKey(unknownEnumValue: BracketMatchState.unknown) BracketMatchState get state; BracketSlot get home; BracketSlot get away;/// Goals for a best of 1, games won for a series.
 Score? get score; String? get winnerEntryId; DateTime? get scheduledAt;/// Why it ended, such as `played`, `walkover` or `double_no_show`.
@JsonKey(readValue: _completionReason) String? get completionReason;
/// Create a copy of BracketMatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BracketMatchCopyWith<BracketMatch> get copyWith => _$BracketMatchCopyWithImpl<BracketMatch>(this as BracketMatch, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BracketMatch;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BracketMatch&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.matchNumber, _this.matchNumber) || other.matchNumber == _this.matchNumber)&&(identical(other.bestOf, _this.bestOf) || other.bestOf == _this.bestOf)&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.home, _this.home) || other.home == _this.home)&&(identical(other.away, _this.away) || other.away == _this.away)&&(identical(other.score, _this.score) || other.score == _this.score)&&(identical(other.winnerEntryId, _this.winnerEntryId) || other.winnerEntryId == _this.winnerEntryId)&&(identical(other.scheduledAt, _this.scheduledAt) || other.scheduledAt == _this.scheduledAt)&&(identical(other.completionReason, _this.completionReason) || other.completionReason == _this.completionReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BracketMatch;
  return Object.hash(runtimeType,_this.id,_this.matchNumber,_this.bestOf,_this.state,_this.home,_this.away,_this.score,_this.winnerEntryId,_this.scheduledAt,_this.completionReason);
}

@override
String toString() {
  final _this = this as BracketMatch;
  return 'BracketMatch(id: ${_this.id}, matchNumber: ${_this.matchNumber}, bestOf: ${_this.bestOf}, state: ${_this.state}, home: ${_this.home}, away: ${_this.away}, score: ${_this.score}, winnerEntryId: ${_this.winnerEntryId}, scheduledAt: ${_this.scheduledAt}, completionReason: ${_this.completionReason})';
}


}

/// @nodoc
abstract mixin class $BracketMatchCopyWith<$Res>  {
  factory $BracketMatchCopyWith(BracketMatch value, $Res Function(BracketMatch) _then) = _$BracketMatchCopyWithImpl;
@useResult
$Res call({
 String id, int matchNumber, int bestOf,@JsonKey(unknownEnumValue: BracketMatchState.unknown) BracketMatchState state, BracketSlot home, BracketSlot away, Score? score, String? winnerEntryId, DateTime? scheduledAt,@JsonKey(readValue: _completionReason) String? completionReason
});


$BracketSlotCopyWith<$Res> get home;$BracketSlotCopyWith<$Res> get away;$ScoreCopyWith<$Res>? get score;

}
/// @nodoc
class _$BracketMatchCopyWithImpl<$Res>
    implements $BracketMatchCopyWith<$Res> {
  _$BracketMatchCopyWithImpl(this._self, this._then);

  final BracketMatch _self;
  final $Res Function(BracketMatch) _then;

/// Create a copy of BracketMatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? matchNumber = null,Object? bestOf = null,Object? state = null,Object? home = null,Object? away = null,Object? score = freezed,Object? winnerEntryId = freezed,Object? scheduledAt = freezed,Object? completionReason = freezed,}) {
  return _then(BracketMatch(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,matchNumber: null == matchNumber ? _self.matchNumber : matchNumber // ignore: cast_nullable_to_non_nullable
as int,bestOf: null == bestOf ? _self.bestOf : bestOf // ignore: cast_nullable_to_non_nullable
as int,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as BracketMatchState,home: null == home ? _self.home : home // ignore: cast_nullable_to_non_nullable
as BracketSlot,away: null == away ? _self.away : away // ignore: cast_nullable_to_non_nullable
as BracketSlot,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as Score?,winnerEntryId: freezed == winnerEntryId ? _self.winnerEntryId : winnerEntryId // ignore: cast_nullable_to_non_nullable
as String?,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completionReason: freezed == completionReason ? _self.completionReason : completionReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of BracketMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BracketSlotCopyWith<$Res> get home {
  
  return $BracketSlotCopyWith<$Res>(_self.home, (value) {
    return _then(_self.copyWith(home: value));
  });
}/// Create a copy of BracketMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BracketSlotCopyWith<$Res> get away {
  
  return $BracketSlotCopyWith<$Res>(_self.away, (value) {
    return _then(_self.copyWith(away: value));
  });
}/// Create a copy of BracketMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoreCopyWith<$Res>? get score {
    if (_self.score == null) {
    return null;
  }

  return $ScoreCopyWith<$Res>(_self.score!, (value) {
    return _then(_self.copyWith(score: value));
  });
}
}


/// Adds pattern-matching-related methods to [BracketMatch].
extension BracketMatchPatterns on BracketMatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BracketMatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BracketMatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BracketMatch value)  $default,){
final _that = this;
switch (_that) {
case _BracketMatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BracketMatch value)?  $default,){
final _that = this;
switch (_that) {
case _BracketMatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int matchNumber,  int bestOf, @JsonKey(unknownEnumValue: BracketMatchState.unknown)  BracketMatchState state,  BracketSlot home,  BracketSlot away,  Score? score,  String? winnerEntryId,  DateTime? scheduledAt, @JsonKey(readValue: _completionReason)  String? completionReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BracketMatch() when $default != null:
return $default(_that.id,_that.matchNumber,_that.bestOf,_that.state,_that.home,_that.away,_that.score,_that.winnerEntryId,_that.scheduledAt,_that.completionReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int matchNumber,  int bestOf, @JsonKey(unknownEnumValue: BracketMatchState.unknown)  BracketMatchState state,  BracketSlot home,  BracketSlot away,  Score? score,  String? winnerEntryId,  DateTime? scheduledAt, @JsonKey(readValue: _completionReason)  String? completionReason)  $default,) {final _that = this;
switch (_that) {
case _BracketMatch():
return $default(_that.id,_that.matchNumber,_that.bestOf,_that.state,_that.home,_that.away,_that.score,_that.winnerEntryId,_that.scheduledAt,_that.completionReason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int matchNumber,  int bestOf, @JsonKey(unknownEnumValue: BracketMatchState.unknown)  BracketMatchState state,  BracketSlot home,  BracketSlot away,  Score? score,  String? winnerEntryId,  DateTime? scheduledAt, @JsonKey(readValue: _completionReason)  String? completionReason)?  $default,) {final _that = this;
switch (_that) {
case _BracketMatch() when $default != null:
return $default(_that.id,_that.matchNumber,_that.bestOf,_that.state,_that.home,_that.away,_that.score,_that.winnerEntryId,_that.scheduledAt,_that.completionReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _BracketMatch extends BracketMatch {
  const _BracketMatch({required this.id, required this.matchNumber, this.bestOf = 1, @JsonKey(unknownEnumValue: BracketMatchState.unknown) required this.state, required this.home, required this.away, this.score, this.winnerEntryId, this.scheduledAt, @JsonKey(readValue: _completionReason) this.completionReason}): super._();
  factory _BracketMatch.fromJson(Map<String, dynamic> json) => _$BracketMatchFromJson(json);

@override final  String id;
@override final  int matchNumber;
@override@JsonKey() final  int bestOf;
@override@JsonKey(unknownEnumValue: BracketMatchState.unknown) final  BracketMatchState state;
@override final  BracketSlot home;
@override final  BracketSlot away;
/// Goals for a best of 1, games won for a series.
@override final  Score? score;
@override final  String? winnerEntryId;
@override final  DateTime? scheduledAt;
/// Why it ended, such as `played`, `walkover` or `double_no_show`.
@override@JsonKey(readValue: _completionReason) final  String? completionReason;

/// Create a copy of BracketMatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BracketMatchCopyWith<_BracketMatch> get copyWith => __$BracketMatchCopyWithImpl<_BracketMatch>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BracketMatch&&(identical(other.id, id) || other.id == id)&&(identical(other.matchNumber, matchNumber) || other.matchNumber == matchNumber)&&(identical(other.bestOf, bestOf) || other.bestOf == bestOf)&&(identical(other.state, state) || other.state == state)&&(identical(other.home, home) || other.home == home)&&(identical(other.away, away) || other.away == away)&&(identical(other.score, score) || other.score == score)&&(identical(other.winnerEntryId, winnerEntryId) || other.winnerEntryId == winnerEntryId)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.completionReason, completionReason) || other.completionReason == completionReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,matchNumber,bestOf,state,home,away,score,winnerEntryId,scheduledAt,completionReason);
}

@override
String toString() {
    return 'BracketMatch(id: $id, matchNumber: $matchNumber, bestOf: $bestOf, state: $state, home: $home, away: $away, score: $score, winnerEntryId: $winnerEntryId, scheduledAt: $scheduledAt, completionReason: $completionReason)';
}


}

/// @nodoc
abstract mixin class _$BracketMatchCopyWith<$Res> implements $BracketMatchCopyWith<$Res> {
  factory _$BracketMatchCopyWith(_BracketMatch value, $Res Function(_BracketMatch) _then) = __$BracketMatchCopyWithImpl;
@override @useResult
$Res call({
 String id, int matchNumber, int bestOf,@JsonKey(unknownEnumValue: BracketMatchState.unknown) BracketMatchState state, BracketSlot home, BracketSlot away, Score? score, String? winnerEntryId, DateTime? scheduledAt,@JsonKey(readValue: _completionReason) String? completionReason
});


@override $BracketSlotCopyWith<$Res> get home;@override $BracketSlotCopyWith<$Res> get away;@override $ScoreCopyWith<$Res>? get score;

}
/// @nodoc
class __$BracketMatchCopyWithImpl<$Res>
    implements _$BracketMatchCopyWith<$Res> {
  __$BracketMatchCopyWithImpl(this._self, this._then);

  final _BracketMatch _self;
  final $Res Function(_BracketMatch) _then;

/// Create a copy of BracketMatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? matchNumber = null,Object? bestOf = null,Object? state = null,Object? home = null,Object? away = null,Object? score = freezed,Object? winnerEntryId = freezed,Object? scheduledAt = freezed,Object? completionReason = freezed,}) {
  return _then(_BracketMatch(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,matchNumber: null == matchNumber ? _self.matchNumber : matchNumber // ignore: cast_nullable_to_non_nullable
as int,bestOf: null == bestOf ? _self.bestOf : bestOf // ignore: cast_nullable_to_non_nullable
as int,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as BracketMatchState,home: null == home ? _self.home : home // ignore: cast_nullable_to_non_nullable
as BracketSlot,away: null == away ? _self.away : away // ignore: cast_nullable_to_non_nullable
as BracketSlot,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as Score?,winnerEntryId: freezed == winnerEntryId ? _self.winnerEntryId : winnerEntryId // ignore: cast_nullable_to_non_nullable
as String?,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completionReason: freezed == completionReason ? _self.completionReason : completionReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of BracketMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BracketSlotCopyWith<$Res> get home {
  
  return $BracketSlotCopyWith<$Res>(_self.home, (value) {
    return _then(_self.copyWith(home: value));
  });
}/// Create a copy of BracketMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BracketSlotCopyWith<$Res> get away {
  
  return $BracketSlotCopyWith<$Res>(_self.away, (value) {
    return _then(_self.copyWith(away: value));
  });
}/// Create a copy of BracketMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScoreCopyWith<$Res>? get score {
    if (_self.score == null) {
    return null;
  }

  return $ScoreCopyWith<$Res>(_self.score!, (value) {
    return _then(_self.copyWith(score: value));
  });
}
}


/// @nodoc
mixin _$BracketSlot {

 BracketParticipant? get participant;/// The match that would have filled it ended without a winner, so no
/// one will.
@JsonKey(readValue: _voided) bool get voided;
/// Create a copy of BracketSlot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BracketSlotCopyWith<BracketSlot> get copyWith => _$BracketSlotCopyWithImpl<BracketSlot>(this as BracketSlot, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BracketSlot;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BracketSlot&&(identical(other.participant, _this.participant) || other.participant == _this.participant)&&(identical(other.voided, _this.voided) || other.voided == _this.voided));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BracketSlot;
  return Object.hash(runtimeType,_this.participant,_this.voided);
}

@override
String toString() {
  final _this = this as BracketSlot;
  return 'BracketSlot(participant: ${_this.participant}, voided: ${_this.voided})';
}


}

/// @nodoc
abstract mixin class $BracketSlotCopyWith<$Res>  {
  factory $BracketSlotCopyWith(BracketSlot value, $Res Function(BracketSlot) _then) = _$BracketSlotCopyWithImpl;
@useResult
$Res call({
 BracketParticipant? participant,@JsonKey(readValue: _voided) bool voided
});


$BracketParticipantCopyWith<$Res>? get participant;

}
/// @nodoc
class _$BracketSlotCopyWithImpl<$Res>
    implements $BracketSlotCopyWith<$Res> {
  _$BracketSlotCopyWithImpl(this._self, this._then);

  final BracketSlot _self;
  final $Res Function(BracketSlot) _then;

/// Create a copy of BracketSlot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? participant = freezed,Object? voided = null,}) {
  return _then(BracketSlot(
participant: freezed == participant ? _self.participant : participant // ignore: cast_nullable_to_non_nullable
as BracketParticipant?,voided: null == voided ? _self.voided : voided // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of BracketSlot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BracketParticipantCopyWith<$Res>? get participant {
    if (_self.participant == null) {
    return null;
  }

  return $BracketParticipantCopyWith<$Res>(_self.participant!, (value) {
    return _then(_self.copyWith(participant: value));
  });
}
}


/// Adds pattern-matching-related methods to [BracketSlot].
extension BracketSlotPatterns on BracketSlot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BracketSlot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BracketSlot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BracketSlot value)  $default,){
final _that = this;
switch (_that) {
case _BracketSlot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BracketSlot value)?  $default,){
final _that = this;
switch (_that) {
case _BracketSlot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BracketParticipant? participant, @JsonKey(readValue: _voided)  bool voided)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BracketSlot() when $default != null:
return $default(_that.participant,_that.voided);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BracketParticipant? participant, @JsonKey(readValue: _voided)  bool voided)  $default,) {final _that = this;
switch (_that) {
case _BracketSlot():
return $default(_that.participant,_that.voided);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BracketParticipant? participant, @JsonKey(readValue: _voided)  bool voided)?  $default,) {final _that = this;
switch (_that) {
case _BracketSlot() when $default != null:
return $default(_that.participant,_that.voided);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _BracketSlot implements BracketSlot {
  const _BracketSlot({this.participant, @JsonKey(readValue: _voided) this.voided = false});
  factory _BracketSlot.fromJson(Map<String, dynamic> json) => _$BracketSlotFromJson(json);

@override final  BracketParticipant? participant;
/// The match that would have filled it ended without a winner, so no
/// one will.
@override@JsonKey(readValue: _voided) final  bool voided;

/// Create a copy of BracketSlot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BracketSlotCopyWith<_BracketSlot> get copyWith => __$BracketSlotCopyWithImpl<_BracketSlot>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BracketSlot&&(identical(other.participant, participant) || other.participant == participant)&&(identical(other.voided, voided) || other.voided == voided));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,participant,voided);
}

@override
String toString() {
    return 'BracketSlot(participant: $participant, voided: $voided)';
}


}

/// @nodoc
abstract mixin class _$BracketSlotCopyWith<$Res> implements $BracketSlotCopyWith<$Res> {
  factory _$BracketSlotCopyWith(_BracketSlot value, $Res Function(_BracketSlot) _then) = __$BracketSlotCopyWithImpl;
@override @useResult
$Res call({
 BracketParticipant? participant,@JsonKey(readValue: _voided) bool voided
});


@override $BracketParticipantCopyWith<$Res>? get participant;

}
/// @nodoc
class __$BracketSlotCopyWithImpl<$Res>
    implements _$BracketSlotCopyWith<$Res> {
  __$BracketSlotCopyWithImpl(this._self, this._then);

  final _BracketSlot _self;
  final $Res Function(_BracketSlot) _then;

/// Create a copy of BracketSlot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? participant = freezed,Object? voided = null,}) {
  return _then(_BracketSlot(
participant: freezed == participant ? _self.participant : participant // ignore: cast_nullable_to_non_nullable
as BracketParticipant?,voided: null == voided ? _self.voided : voided // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of BracketSlot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BracketParticipantCopyWith<$Res>? get participant {
    if (_self.participant == null) {
    return null;
  }

  return $BracketParticipantCopyWith<$Res>(_self.participant!, (value) {
    return _then(_self.copyWith(participant: value));
  });
}
}


/// @nodoc
mixin _$BracketParticipant {

 String get entryId; String get displayName;
/// Create a copy of BracketParticipant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BracketParticipantCopyWith<BracketParticipant> get copyWith => _$BracketParticipantCopyWithImpl<BracketParticipant>(this as BracketParticipant, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BracketParticipant;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BracketParticipant&&(identical(other.entryId, _this.entryId) || other.entryId == _this.entryId)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BracketParticipant;
  return Object.hash(runtimeType,_this.entryId,_this.displayName);
}

@override
String toString() {
  final _this = this as BracketParticipant;
  return 'BracketParticipant(entryId: ${_this.entryId}, displayName: ${_this.displayName})';
}


}

/// @nodoc
abstract mixin class $BracketParticipantCopyWith<$Res>  {
  factory $BracketParticipantCopyWith(BracketParticipant value, $Res Function(BracketParticipant) _then) = _$BracketParticipantCopyWithImpl;
@useResult
$Res call({
 String entryId, String displayName
});




}
/// @nodoc
class _$BracketParticipantCopyWithImpl<$Res>
    implements $BracketParticipantCopyWith<$Res> {
  _$BracketParticipantCopyWithImpl(this._self, this._then);

  final BracketParticipant _self;
  final $Res Function(BracketParticipant) _then;

/// Create a copy of BracketParticipant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entryId = null,Object? displayName = null,}) {
  return _then(BracketParticipant(
entryId: null == entryId ? _self.entryId : entryId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BracketParticipant].
extension BracketParticipantPatterns on BracketParticipant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BracketParticipant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BracketParticipant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BracketParticipant value)  $default,){
final _that = this;
switch (_that) {
case _BracketParticipant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BracketParticipant value)?  $default,){
final _that = this;
switch (_that) {
case _BracketParticipant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String entryId,  String displayName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BracketParticipant() when $default != null:
return $default(_that.entryId,_that.displayName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String entryId,  String displayName)  $default,) {final _that = this;
switch (_that) {
case _BracketParticipant():
return $default(_that.entryId,_that.displayName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String entryId,  String displayName)?  $default,) {final _that = this;
switch (_that) {
case _BracketParticipant() when $default != null:
return $default(_that.entryId,_that.displayName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _BracketParticipant implements BracketParticipant {
  const _BracketParticipant({required this.entryId, required this.displayName});
  factory _BracketParticipant.fromJson(Map<String, dynamic> json) => _$BracketParticipantFromJson(json);

@override final  String entryId;
@override final  String displayName;

/// Create a copy of BracketParticipant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BracketParticipantCopyWith<_BracketParticipant> get copyWith => __$BracketParticipantCopyWithImpl<_BracketParticipant>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BracketParticipant&&(identical(other.entryId, entryId) || other.entryId == entryId)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,entryId,displayName);
}

@override
String toString() {
    return 'BracketParticipant(entryId: $entryId, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class _$BracketParticipantCopyWith<$Res> implements $BracketParticipantCopyWith<$Res> {
  factory _$BracketParticipantCopyWith(_BracketParticipant value, $Res Function(_BracketParticipant) _then) = __$BracketParticipantCopyWithImpl;
@override @useResult
$Res call({
 String entryId, String displayName
});




}
/// @nodoc
class __$BracketParticipantCopyWithImpl<$Res>
    implements _$BracketParticipantCopyWith<$Res> {
  __$BracketParticipantCopyWithImpl(this._self, this._then);

  final _BracketParticipant _self;
  final $Res Function(_BracketParticipant) _then;

/// Create a copy of BracketParticipant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entryId = null,Object? displayName = null,}) {
  return _then(_BracketParticipant(
entryId: null == entryId ? _self.entryId : entryId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Standings {

 List<StandingsStage> get stages; List<Placement> get placements;
/// Create a copy of Standings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StandingsCopyWith<Standings> get copyWith => _$StandingsCopyWithImpl<Standings>(this as Standings, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Standings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Standings&&const DeepCollectionEquality().equals(other.stages, _this.stages)&&const DeepCollectionEquality().equals(other.placements, _this.placements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Standings;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.stages),const DeepCollectionEquality().hash(_this.placements));
}

@override
String toString() {
  final _this = this as Standings;
  return 'Standings(stages: ${_this.stages}, placements: ${_this.placements})';
}


}

/// @nodoc
abstract mixin class $StandingsCopyWith<$Res>  {
  factory $StandingsCopyWith(Standings value, $Res Function(Standings) _then) = _$StandingsCopyWithImpl;
@useResult
$Res call({
 List<StandingsStage> stages, List<Placement> placements
});




}
/// @nodoc
class _$StandingsCopyWithImpl<$Res>
    implements $StandingsCopyWith<$Res> {
  _$StandingsCopyWithImpl(this._self, this._then);

  final Standings _self;
  final $Res Function(Standings) _then;

/// Create a copy of Standings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stages = null,Object? placements = null,}) {
  return _then(Standings(
stages: null == stages ? _self.stages : stages // ignore: cast_nullable_to_non_nullable
as List<StandingsStage>,placements: null == placements ? _self.placements : placements // ignore: cast_nullable_to_non_nullable
as List<Placement>,
  ));
}

}


/// Adds pattern-matching-related methods to [Standings].
extension StandingsPatterns on Standings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Standings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Standings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Standings value)  $default,){
final _that = this;
switch (_that) {
case _Standings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Standings value)?  $default,){
final _that = this;
switch (_that) {
case _Standings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<StandingsStage> stages,  List<Placement> placements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Standings() when $default != null:
return $default(_that.stages,_that.placements);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<StandingsStage> stages,  List<Placement> placements)  $default,) {final _that = this;
switch (_that) {
case _Standings():
return $default(_that.stages,_that.placements);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<StandingsStage> stages,  List<Placement> placements)?  $default,) {final _that = this;
switch (_that) {
case _Standings() when $default != null:
return $default(_that.stages,_that.placements);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _Standings implements Standings {
  const _Standings({ List<StandingsStage> stages = const <StandingsStage>[],  List<Placement> placements = const <Placement>[]}): _stages = stages,_placements = placements;
  factory _Standings.fromJson(Map<String, dynamic> json) => _$StandingsFromJson(json);

 final  List<StandingsStage> _stages;
@override@JsonKey() List<StandingsStage> get stages {
  if (_stages is EqualUnmodifiableListView) return _stages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stages);
}

 final  List<Placement> _placements;
@override@JsonKey() List<Placement> get placements {
  if (_placements is EqualUnmodifiableListView) return _placements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_placements);
}


/// Create a copy of Standings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StandingsCopyWith<_Standings> get copyWith => __$StandingsCopyWithImpl<_Standings>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Standings&&const DeepCollectionEquality().equals(other.stages, _stages)&&const DeepCollectionEquality().equals(other.placements, _placements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_stages),const DeepCollectionEquality().hash(_placements));
}

@override
String toString() {
    return 'Standings(stages: $stages, placements: $placements)';
}


}

/// @nodoc
abstract mixin class _$StandingsCopyWith<$Res> implements $StandingsCopyWith<$Res> {
  factory _$StandingsCopyWith(_Standings value, $Res Function(_Standings) _then) = __$StandingsCopyWithImpl;
@override @useResult
$Res call({
 List<StandingsStage> stages, List<Placement> placements
});




}
/// @nodoc
class __$StandingsCopyWithImpl<$Res>
    implements _$StandingsCopyWith<$Res> {
  __$StandingsCopyWithImpl(this._self, this._then);

  final _Standings _self;
  final $Res Function(_Standings) _then;

/// Create a copy of Standings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stages = null,Object? placements = null,}) {
  return _then(_Standings(
stages: null == stages ? _self._stages : stages // ignore: cast_nullable_to_non_nullable
as List<StandingsStage>,placements: null == placements ? _self._placements : placements // ignore: cast_nullable_to_non_nullable
as List<Placement>,
  ));
}


}


/// @nodoc
mixin _$StandingsStage {

 String get id; List<StandingsGroup> get groups;
/// Create a copy of StandingsStage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StandingsStageCopyWith<StandingsStage> get copyWith => _$StandingsStageCopyWithImpl<StandingsStage>(this as StandingsStage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StandingsStage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StandingsStage&&(identical(other.id, _this.id) || other.id == _this.id)&&const DeepCollectionEquality().equals(other.groups, _this.groups));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StandingsStage;
  return Object.hash(runtimeType,_this.id,const DeepCollectionEquality().hash(_this.groups));
}

@override
String toString() {
  final _this = this as StandingsStage;
  return 'StandingsStage(id: ${_this.id}, groups: ${_this.groups})';
}


}

/// @nodoc
abstract mixin class $StandingsStageCopyWith<$Res>  {
  factory $StandingsStageCopyWith(StandingsStage value, $Res Function(StandingsStage) _then) = _$StandingsStageCopyWithImpl;
@useResult
$Res call({
 String id, List<StandingsGroup> groups
});




}
/// @nodoc
class _$StandingsStageCopyWithImpl<$Res>
    implements $StandingsStageCopyWith<$Res> {
  _$StandingsStageCopyWithImpl(this._self, this._then);

  final StandingsStage _self;
  final $Res Function(StandingsStage) _then;

/// Create a copy of StandingsStage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? groups = null,}) {
  return _then(StandingsStage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as List<StandingsGroup>,
  ));
}

}


/// Adds pattern-matching-related methods to [StandingsStage].
extension StandingsStagePatterns on StandingsStage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StandingsStage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StandingsStage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StandingsStage value)  $default,){
final _that = this;
switch (_that) {
case _StandingsStage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StandingsStage value)?  $default,){
final _that = this;
switch (_that) {
case _StandingsStage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  List<StandingsGroup> groups)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StandingsStage() when $default != null:
return $default(_that.id,_that.groups);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  List<StandingsGroup> groups)  $default,) {final _that = this;
switch (_that) {
case _StandingsStage():
return $default(_that.id,_that.groups);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  List<StandingsGroup> groups)?  $default,) {final _that = this;
switch (_that) {
case _StandingsStage() when $default != null:
return $default(_that.id,_that.groups);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _StandingsStage implements StandingsStage {
  const _StandingsStage({required this.id,  List<StandingsGroup> groups = const <StandingsGroup>[]}): _groups = groups;
  factory _StandingsStage.fromJson(Map<String, dynamic> json) => _$StandingsStageFromJson(json);

@override final  String id;
 final  List<StandingsGroup> _groups;
@override@JsonKey() List<StandingsGroup> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}


/// Create a copy of StandingsStage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StandingsStageCopyWith<_StandingsStage> get copyWith => __$StandingsStageCopyWithImpl<_StandingsStage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StandingsStage&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.groups, _groups));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_groups));
}

@override
String toString() {
    return 'StandingsStage(id: $id, groups: $groups)';
}


}

/// @nodoc
abstract mixin class _$StandingsStageCopyWith<$Res> implements $StandingsStageCopyWith<$Res> {
  factory _$StandingsStageCopyWith(_StandingsStage value, $Res Function(_StandingsStage) _then) = __$StandingsStageCopyWithImpl;
@override @useResult
$Res call({
 String id, List<StandingsGroup> groups
});




}
/// @nodoc
class __$StandingsStageCopyWithImpl<$Res>
    implements _$StandingsStageCopyWith<$Res> {
  __$StandingsStageCopyWithImpl(this._self, this._then);

  final _StandingsStage _self;
  final $Res Function(_StandingsStage) _then;

/// Create a copy of StandingsStage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? groups = null,}) {
  return _then(_StandingsStage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<StandingsGroup>,
  ));
}


}


/// @nodoc
mixin _$StandingsGroup {

/// `main` for a single table, otherwise `group_a`, `group_b` and so on,
/// matching its rounds' bracket.
 String get key;/// In table order, removed entries last.
 List<StandingRow> get rows;
/// Create a copy of StandingsGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StandingsGroupCopyWith<StandingsGroup> get copyWith => _$StandingsGroupCopyWithImpl<StandingsGroup>(this as StandingsGroup, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StandingsGroup;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StandingsGroup&&(identical(other.key, _this.key) || other.key == _this.key)&&const DeepCollectionEquality().equals(other.rows, _this.rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StandingsGroup;
  return Object.hash(runtimeType,_this.key,const DeepCollectionEquality().hash(_this.rows));
}

@override
String toString() {
  final _this = this as StandingsGroup;
  return 'StandingsGroup(key: ${_this.key}, rows: ${_this.rows})';
}


}

/// @nodoc
abstract mixin class $StandingsGroupCopyWith<$Res>  {
  factory $StandingsGroupCopyWith(StandingsGroup value, $Res Function(StandingsGroup) _then) = _$StandingsGroupCopyWithImpl;
@useResult
$Res call({
 String key, List<StandingRow> rows
});




}
/// @nodoc
class _$StandingsGroupCopyWithImpl<$Res>
    implements $StandingsGroupCopyWith<$Res> {
  _$StandingsGroupCopyWithImpl(this._self, this._then);

  final StandingsGroup _self;
  final $Res Function(StandingsGroup) _then;

/// Create a copy of StandingsGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? rows = null,}) {
  return _then(StandingsGroup(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as List<StandingRow>,
  ));
}

}


/// Adds pattern-matching-related methods to [StandingsGroup].
extension StandingsGroupPatterns on StandingsGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StandingsGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StandingsGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StandingsGroup value)  $default,){
final _that = this;
switch (_that) {
case _StandingsGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StandingsGroup value)?  $default,){
final _that = this;
switch (_that) {
case _StandingsGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  List<StandingRow> rows)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StandingsGroup() when $default != null:
return $default(_that.key,_that.rows);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  List<StandingRow> rows)  $default,) {final _that = this;
switch (_that) {
case _StandingsGroup():
return $default(_that.key,_that.rows);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  List<StandingRow> rows)?  $default,) {final _that = this;
switch (_that) {
case _StandingsGroup() when $default != null:
return $default(_that.key,_that.rows);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _StandingsGroup implements StandingsGroup {
  const _StandingsGroup({required this.key,  List<StandingRow> rows = const <StandingRow>[]}): _rows = rows;
  factory _StandingsGroup.fromJson(Map<String, dynamic> json) => _$StandingsGroupFromJson(json);

/// `main` for a single table, otherwise `group_a`, `group_b` and so on,
/// matching its rounds' bracket.
@override final  String key;
/// In table order, removed entries last.
 final  List<StandingRow> _rows;
/// In table order, removed entries last.
@override@JsonKey() List<StandingRow> get rows {
  if (_rows is EqualUnmodifiableListView) return _rows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rows);
}


/// Create a copy of StandingsGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StandingsGroupCopyWith<_StandingsGroup> get copyWith => __$StandingsGroupCopyWithImpl<_StandingsGroup>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StandingsGroup&&(identical(other.key, key) || other.key == key)&&const DeepCollectionEquality().equals(other.rows, _rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,key,const DeepCollectionEquality().hash(_rows));
}

@override
String toString() {
    return 'StandingsGroup(key: $key, rows: $rows)';
}


}

/// @nodoc
abstract mixin class _$StandingsGroupCopyWith<$Res> implements $StandingsGroupCopyWith<$Res> {
  factory _$StandingsGroupCopyWith(_StandingsGroup value, $Res Function(_StandingsGroup) _then) = __$StandingsGroupCopyWithImpl;
@override @useResult
$Res call({
 String key, List<StandingRow> rows
});




}
/// @nodoc
class __$StandingsGroupCopyWithImpl<$Res>
    implements _$StandingsGroupCopyWith<$Res> {
  __$StandingsGroupCopyWithImpl(this._self, this._then);

  final _StandingsGroup _self;
  final $Res Function(_StandingsGroup) _then;

/// Create a copy of StandingsGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? rows = null,}) {
  return _then(_StandingsGroup(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,rows: null == rows ? _self._rows : rows // ignore: cast_nullable_to_non_nullable
as List<StandingRow>,
  ));
}


}


/// @nodoc
mixin _$StandingRow {

/// Null exactly when [removed].
 int? get rank; String get entryId; String get displayName; int get played; int get wins; int get draws; int get losses; int get gamesWon; int get gamesLost; int get goalDifference; int get points;/// Disqualified or withdrew after the draw: results stand, unranked.
 bool get removed;
/// Create a copy of StandingRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StandingRowCopyWith<StandingRow> get copyWith => _$StandingRowCopyWithImpl<StandingRow>(this as StandingRow, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StandingRow;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StandingRow&&(identical(other.rank, _this.rank) || other.rank == _this.rank)&&(identical(other.entryId, _this.entryId) || other.entryId == _this.entryId)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.played, _this.played) || other.played == _this.played)&&(identical(other.wins, _this.wins) || other.wins == _this.wins)&&(identical(other.draws, _this.draws) || other.draws == _this.draws)&&(identical(other.losses, _this.losses) || other.losses == _this.losses)&&(identical(other.gamesWon, _this.gamesWon) || other.gamesWon == _this.gamesWon)&&(identical(other.gamesLost, _this.gamesLost) || other.gamesLost == _this.gamesLost)&&(identical(other.goalDifference, _this.goalDifference) || other.goalDifference == _this.goalDifference)&&(identical(other.points, _this.points) || other.points == _this.points)&&(identical(other.removed, _this.removed) || other.removed == _this.removed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StandingRow;
  return Object.hash(runtimeType,_this.rank,_this.entryId,_this.displayName,_this.played,_this.wins,_this.draws,_this.losses,_this.gamesWon,_this.gamesLost,_this.goalDifference,_this.points,_this.removed);
}

@override
String toString() {
  final _this = this as StandingRow;
  return 'StandingRow(rank: ${_this.rank}, entryId: ${_this.entryId}, displayName: ${_this.displayName}, played: ${_this.played}, wins: ${_this.wins}, draws: ${_this.draws}, losses: ${_this.losses}, gamesWon: ${_this.gamesWon}, gamesLost: ${_this.gamesLost}, goalDifference: ${_this.goalDifference}, points: ${_this.points}, removed: ${_this.removed})';
}


}

/// @nodoc
abstract mixin class $StandingRowCopyWith<$Res>  {
  factory $StandingRowCopyWith(StandingRow value, $Res Function(StandingRow) _then) = _$StandingRowCopyWithImpl;
@useResult
$Res call({
 int? rank, String entryId, String displayName, int played, int wins, int draws, int losses, int gamesWon, int gamesLost, int goalDifference, int points, bool removed
});




}
/// @nodoc
class _$StandingRowCopyWithImpl<$Res>
    implements $StandingRowCopyWith<$Res> {
  _$StandingRowCopyWithImpl(this._self, this._then);

  final StandingRow _self;
  final $Res Function(StandingRow) _then;

/// Create a copy of StandingRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rank = freezed,Object? entryId = null,Object? displayName = null,Object? played = null,Object? wins = null,Object? draws = null,Object? losses = null,Object? gamesWon = null,Object? gamesLost = null,Object? goalDifference = null,Object? points = null,Object? removed = null,}) {
  return _then(StandingRow(
rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int?,entryId: null == entryId ? _self.entryId : entryId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,played: null == played ? _self.played : played // ignore: cast_nullable_to_non_nullable
as int,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,draws: null == draws ? _self.draws : draws // ignore: cast_nullable_to_non_nullable
as int,losses: null == losses ? _self.losses : losses // ignore: cast_nullable_to_non_nullable
as int,gamesWon: null == gamesWon ? _self.gamesWon : gamesWon // ignore: cast_nullable_to_non_nullable
as int,gamesLost: null == gamesLost ? _self.gamesLost : gamesLost // ignore: cast_nullable_to_non_nullable
as int,goalDifference: null == goalDifference ? _self.goalDifference : goalDifference // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,removed: null == removed ? _self.removed : removed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [StandingRow].
extension StandingRowPatterns on StandingRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StandingRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StandingRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StandingRow value)  $default,){
final _that = this;
switch (_that) {
case _StandingRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StandingRow value)?  $default,){
final _that = this;
switch (_that) {
case _StandingRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? rank,  String entryId,  String displayName,  int played,  int wins,  int draws,  int losses,  int gamesWon,  int gamesLost,  int goalDifference,  int points,  bool removed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StandingRow() when $default != null:
return $default(_that.rank,_that.entryId,_that.displayName,_that.played,_that.wins,_that.draws,_that.losses,_that.gamesWon,_that.gamesLost,_that.goalDifference,_that.points,_that.removed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? rank,  String entryId,  String displayName,  int played,  int wins,  int draws,  int losses,  int gamesWon,  int gamesLost,  int goalDifference,  int points,  bool removed)  $default,) {final _that = this;
switch (_that) {
case _StandingRow():
return $default(_that.rank,_that.entryId,_that.displayName,_that.played,_that.wins,_that.draws,_that.losses,_that.gamesWon,_that.gamesLost,_that.goalDifference,_that.points,_that.removed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? rank,  String entryId,  String displayName,  int played,  int wins,  int draws,  int losses,  int gamesWon,  int gamesLost,  int goalDifference,  int points,  bool removed)?  $default,) {final _that = this;
switch (_that) {
case _StandingRow() when $default != null:
return $default(_that.rank,_that.entryId,_that.displayName,_that.played,_that.wins,_that.draws,_that.losses,_that.gamesWon,_that.gamesLost,_that.goalDifference,_that.points,_that.removed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _StandingRow implements StandingRow {
  const _StandingRow({this.rank, required this.entryId, required this.displayName, required this.played, required this.wins, required this.draws, required this.losses, this.gamesWon = 0, this.gamesLost = 0, required this.goalDifference, required this.points, this.removed = false});
  factory _StandingRow.fromJson(Map<String, dynamic> json) => _$StandingRowFromJson(json);

/// Null exactly when [removed].
@override final  int? rank;
@override final  String entryId;
@override final  String displayName;
@override final  int played;
@override final  int wins;
@override final  int draws;
@override final  int losses;
@override@JsonKey() final  int gamesWon;
@override@JsonKey() final  int gamesLost;
@override final  int goalDifference;
@override final  int points;
/// Disqualified or withdrew after the draw: results stand, unranked.
@override@JsonKey() final  bool removed;

/// Create a copy of StandingRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StandingRowCopyWith<_StandingRow> get copyWith => __$StandingRowCopyWithImpl<_StandingRow>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StandingRow&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.entryId, entryId) || other.entryId == entryId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.played, played) || other.played == played)&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.draws, draws) || other.draws == draws)&&(identical(other.losses, losses) || other.losses == losses)&&(identical(other.gamesWon, gamesWon) || other.gamesWon == gamesWon)&&(identical(other.gamesLost, gamesLost) || other.gamesLost == gamesLost)&&(identical(other.goalDifference, goalDifference) || other.goalDifference == goalDifference)&&(identical(other.points, points) || other.points == points)&&(identical(other.removed, removed) || other.removed == removed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,rank,entryId,displayName,played,wins,draws,losses,gamesWon,gamesLost,goalDifference,points,removed);
}

@override
String toString() {
    return 'StandingRow(rank: $rank, entryId: $entryId, displayName: $displayName, played: $played, wins: $wins, draws: $draws, losses: $losses, gamesWon: $gamesWon, gamesLost: $gamesLost, goalDifference: $goalDifference, points: $points, removed: $removed)';
}


}

/// @nodoc
abstract mixin class _$StandingRowCopyWith<$Res> implements $StandingRowCopyWith<$Res> {
  factory _$StandingRowCopyWith(_StandingRow value, $Res Function(_StandingRow) _then) = __$StandingRowCopyWithImpl;
@override @useResult
$Res call({
 int? rank, String entryId, String displayName, int played, int wins, int draws, int losses, int gamesWon, int gamesLost, int goalDifference, int points, bool removed
});




}
/// @nodoc
class __$StandingRowCopyWithImpl<$Res>
    implements _$StandingRowCopyWith<$Res> {
  __$StandingRowCopyWithImpl(this._self, this._then);

  final _StandingRow _self;
  final $Res Function(_StandingRow) _then;

/// Create a copy of StandingRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rank = freezed,Object? entryId = null,Object? displayName = null,Object? played = null,Object? wins = null,Object? draws = null,Object? losses = null,Object? gamesWon = null,Object? gamesLost = null,Object? goalDifference = null,Object? points = null,Object? removed = null,}) {
  return _then(_StandingRow(
rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int?,entryId: null == entryId ? _self.entryId : entryId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,played: null == played ? _self.played : played // ignore: cast_nullable_to_non_nullable
as int,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,draws: null == draws ? _self.draws : draws // ignore: cast_nullable_to_non_nullable
as int,losses: null == losses ? _self.losses : losses // ignore: cast_nullable_to_non_nullable
as int,gamesWon: null == gamesWon ? _self.gamesWon : gamesWon // ignore: cast_nullable_to_non_nullable
as int,gamesLost: null == gamesLost ? _self.gamesLost : gamesLost // ignore: cast_nullable_to_non_nullable
as int,goalDifference: null == goalDifference ? _self.goalDifference : goalDifference // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,removed: null == removed ? _self.removed : removed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$Placement {

 int get placement; String get entryId; String get displayName;
/// Create a copy of Placement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacementCopyWith<Placement> get copyWith => _$PlacementCopyWithImpl<Placement>(this as Placement, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Placement;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Placement&&(identical(other.placement, _this.placement) || other.placement == _this.placement)&&(identical(other.entryId, _this.entryId) || other.entryId == _this.entryId)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Placement;
  return Object.hash(runtimeType,_this.placement,_this.entryId,_this.displayName);
}

@override
String toString() {
  final _this = this as Placement;
  return 'Placement(placement: ${_this.placement}, entryId: ${_this.entryId}, displayName: ${_this.displayName})';
}


}

/// @nodoc
abstract mixin class $PlacementCopyWith<$Res>  {
  factory $PlacementCopyWith(Placement value, $Res Function(Placement) _then) = _$PlacementCopyWithImpl;
@useResult
$Res call({
 int placement, String entryId, String displayName
});




}
/// @nodoc
class _$PlacementCopyWithImpl<$Res>
    implements $PlacementCopyWith<$Res> {
  _$PlacementCopyWithImpl(this._self, this._then);

  final Placement _self;
  final $Res Function(Placement) _then;

/// Create a copy of Placement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? placement = null,Object? entryId = null,Object? displayName = null,}) {
  return _then(Placement(
placement: null == placement ? _self.placement : placement // ignore: cast_nullable_to_non_nullable
as int,entryId: null == entryId ? _self.entryId : entryId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Placement].
extension PlacementPatterns on Placement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Placement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Placement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Placement value)  $default,){
final _that = this;
switch (_that) {
case _Placement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Placement value)?  $default,){
final _that = this;
switch (_that) {
case _Placement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int placement,  String entryId,  String displayName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Placement() when $default != null:
return $default(_that.placement,_that.entryId,_that.displayName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int placement,  String entryId,  String displayName)  $default,) {final _that = this;
switch (_that) {
case _Placement():
return $default(_that.placement,_that.entryId,_that.displayName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int placement,  String entryId,  String displayName)?  $default,) {final _that = this;
switch (_that) {
case _Placement() when $default != null:
return $default(_that.placement,_that.entryId,_that.displayName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _Placement implements Placement {
  const _Placement({required this.placement, required this.entryId, required this.displayName});
  factory _Placement.fromJson(Map<String, dynamic> json) => _$PlacementFromJson(json);

@override final  int placement;
@override final  String entryId;
@override final  String displayName;

/// Create a copy of Placement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlacementCopyWith<_Placement> get copyWith => __$PlacementCopyWithImpl<_Placement>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Placement&&(identical(other.placement, placement) || other.placement == placement)&&(identical(other.entryId, entryId) || other.entryId == entryId)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,placement,entryId,displayName);
}

@override
String toString() {
    return 'Placement(placement: $placement, entryId: $entryId, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class _$PlacementCopyWith<$Res> implements $PlacementCopyWith<$Res> {
  factory _$PlacementCopyWith(_Placement value, $Res Function(_Placement) _then) = __$PlacementCopyWithImpl;
@override @useResult
$Res call({
 int placement, String entryId, String displayName
});




}
/// @nodoc
class __$PlacementCopyWithImpl<$Res>
    implements _$PlacementCopyWith<$Res> {
  __$PlacementCopyWithImpl(this._self, this._then);

  final _Placement _self;
  final $Res Function(_Placement) _then;

/// Create a copy of Placement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? placement = null,Object? entryId = null,Object? displayName = null,}) {
  return _then(_Placement(
placement: null == placement ? _self.placement : placement // ignore: cast_nullable_to_non_nullable
as int,entryId: null == entryId ? _self.entryId : entryId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
