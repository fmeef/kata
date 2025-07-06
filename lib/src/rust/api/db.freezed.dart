// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'db.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$KeyHandle {

 String get field0;
/// Create a copy of KeyHandle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeyHandleCopyWith<KeyHandle> get copyWith => _$KeyHandleCopyWithImpl<KeyHandle>(this as KeyHandle, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KeyHandle&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'KeyHandle(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $KeyHandleCopyWith<$Res>  {
  factory $KeyHandleCopyWith(KeyHandle value, $Res Function(KeyHandle) _then) = _$KeyHandleCopyWithImpl;
@useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$KeyHandleCopyWithImpl<$Res>
    implements $KeyHandleCopyWith<$Res> {
  _$KeyHandleCopyWithImpl(this._self, this._then);

  final KeyHandle _self;
  final $Res Function(KeyHandle) _then;

/// Create a copy of KeyHandle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? field0 = null,}) {
  return _then(_self.copyWith(
field0: null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [KeyHandle].
extension KeyHandlePatterns on KeyHandle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( KeyHandle_KeyId value)?  keyId,TResult Function( KeyHandle_Fingerprint value)?  fingerprint,required TResult orElse(),}){
final _that = this;
switch (_that) {
case KeyHandle_KeyId() when keyId != null:
return keyId(_that);case KeyHandle_Fingerprint() when fingerprint != null:
return fingerprint(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( KeyHandle_KeyId value)  keyId,required TResult Function( KeyHandle_Fingerprint value)  fingerprint,}){
final _that = this;
switch (_that) {
case KeyHandle_KeyId():
return keyId(_that);case KeyHandle_Fingerprint():
return fingerprint(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( KeyHandle_KeyId value)?  keyId,TResult? Function( KeyHandle_Fingerprint value)?  fingerprint,}){
final _that = this;
switch (_that) {
case KeyHandle_KeyId() when keyId != null:
return keyId(_that);case KeyHandle_Fingerprint() when fingerprint != null:
return fingerprint(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String field0)?  keyId,TResult Function( String field0)?  fingerprint,required TResult orElse(),}) {final _that = this;
switch (_that) {
case KeyHandle_KeyId() when keyId != null:
return keyId(_that.field0);case KeyHandle_Fingerprint() when fingerprint != null:
return fingerprint(_that.field0);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String field0)  keyId,required TResult Function( String field0)  fingerprint,}) {final _that = this;
switch (_that) {
case KeyHandle_KeyId():
return keyId(_that.field0);case KeyHandle_Fingerprint():
return fingerprint(_that.field0);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String field0)?  keyId,TResult? Function( String field0)?  fingerprint,}) {final _that = this;
switch (_that) {
case KeyHandle_KeyId() when keyId != null:
return keyId(_that.field0);case KeyHandle_Fingerprint() when fingerprint != null:
return fingerprint(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class KeyHandle_KeyId extends KeyHandle {
  const KeyHandle_KeyId(this.field0): super._();
  

@override final  String field0;

/// Create a copy of KeyHandle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeyHandle_KeyIdCopyWith<KeyHandle_KeyId> get copyWith => _$KeyHandle_KeyIdCopyWithImpl<KeyHandle_KeyId>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KeyHandle_KeyId&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'KeyHandle.keyId(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $KeyHandle_KeyIdCopyWith<$Res> implements $KeyHandleCopyWith<$Res> {
  factory $KeyHandle_KeyIdCopyWith(KeyHandle_KeyId value, $Res Function(KeyHandle_KeyId) _then) = _$KeyHandle_KeyIdCopyWithImpl;
@override @useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$KeyHandle_KeyIdCopyWithImpl<$Res>
    implements $KeyHandle_KeyIdCopyWith<$Res> {
  _$KeyHandle_KeyIdCopyWithImpl(this._self, this._then);

  final KeyHandle_KeyId _self;
  final $Res Function(KeyHandle_KeyId) _then;

/// Create a copy of KeyHandle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(KeyHandle_KeyId(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class KeyHandle_Fingerprint extends KeyHandle {
  const KeyHandle_Fingerprint(this.field0): super._();
  

@override final  String field0;

/// Create a copy of KeyHandle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeyHandle_FingerprintCopyWith<KeyHandle_Fingerprint> get copyWith => _$KeyHandle_FingerprintCopyWithImpl<KeyHandle_Fingerprint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KeyHandle_Fingerprint&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'KeyHandle.fingerprint(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $KeyHandle_FingerprintCopyWith<$Res> implements $KeyHandleCopyWith<$Res> {
  factory $KeyHandle_FingerprintCopyWith(KeyHandle_Fingerprint value, $Res Function(KeyHandle_Fingerprint) _then) = _$KeyHandle_FingerprintCopyWithImpl;
@override @useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$KeyHandle_FingerprintCopyWithImpl<$Res>
    implements $KeyHandle_FingerprintCopyWith<$Res> {
  _$KeyHandle_FingerprintCopyWithImpl(this._self, this._then);

  final KeyHandle_Fingerprint _self;
  final $Res Function(KeyHandle_Fingerprint) _then;

/// Create a copy of KeyHandle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(KeyHandle_Fingerprint(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
