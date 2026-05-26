// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'circle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CircleOr {

 RustOpaqueInterface get field0;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CircleOr&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'CircleOr(field0: $field0)';
}


}

/// @nodoc
class $CircleOrCopyWith<$Res>  {
$CircleOrCopyWith(CircleOr _, $Res Function(CircleOr) __);
}


/// Adds pattern-matching-related methods to [CircleOr].
extension CircleOrPatterns on CircleOr {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CircleOr_Circle value)?  circle,TResult Function( CircleOr_User value)?  user,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CircleOr_Circle() when circle != null:
return circle(_that);case CircleOr_User() when user != null:
return user(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CircleOr_Circle value)  circle,required TResult Function( CircleOr_User value)  user,}){
final _that = this;
switch (_that) {
case CircleOr_Circle():
return circle(_that);case CircleOr_User():
return user(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CircleOr_Circle value)?  circle,TResult? Function( CircleOr_User value)?  user,}){
final _that = this;
switch (_that) {
case CircleOr_Circle() when circle != null:
return circle(_that);case CircleOr_User() when user != null:
return user(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Circle field0)?  circle,TResult Function( UserHandle field0)?  user,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CircleOr_Circle() when circle != null:
return circle(_that.field0);case CircleOr_User() when user != null:
return user(_that.field0);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Circle field0)  circle,required TResult Function( UserHandle field0)  user,}) {final _that = this;
switch (_that) {
case CircleOr_Circle():
return circle(_that.field0);case CircleOr_User():
return user(_that.field0);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Circle field0)?  circle,TResult? Function( UserHandle field0)?  user,}) {final _that = this;
switch (_that) {
case CircleOr_Circle() when circle != null:
return circle(_that.field0);case CircleOr_User() when user != null:
return user(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class CircleOr_Circle extends CircleOr {
  const CircleOr_Circle(this.field0): super._();
  

@override final  Circle field0;

/// Create a copy of CircleOr
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CircleOr_CircleCopyWith<CircleOr_Circle> get copyWith => _$CircleOr_CircleCopyWithImpl<CircleOr_Circle>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CircleOr_Circle&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'CircleOr.circle(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $CircleOr_CircleCopyWith<$Res> implements $CircleOrCopyWith<$Res> {
  factory $CircleOr_CircleCopyWith(CircleOr_Circle value, $Res Function(CircleOr_Circle) _then) = _$CircleOr_CircleCopyWithImpl;
@useResult
$Res call({
 Circle field0
});




}
/// @nodoc
class _$CircleOr_CircleCopyWithImpl<$Res>
    implements $CircleOr_CircleCopyWith<$Res> {
  _$CircleOr_CircleCopyWithImpl(this._self, this._then);

  final CircleOr_Circle _self;
  final $Res Function(CircleOr_Circle) _then;

/// Create a copy of CircleOr
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(CircleOr_Circle(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as Circle,
  ));
}


}

/// @nodoc


class CircleOr_User extends CircleOr {
  const CircleOr_User(this.field0): super._();
  

@override final  UserHandle field0;

/// Create a copy of CircleOr
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CircleOr_UserCopyWith<CircleOr_User> get copyWith => _$CircleOr_UserCopyWithImpl<CircleOr_User>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CircleOr_User&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'CircleOr.user(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $CircleOr_UserCopyWith<$Res> implements $CircleOrCopyWith<$Res> {
  factory $CircleOr_UserCopyWith(CircleOr_User value, $Res Function(CircleOr_User) _then) = _$CircleOr_UserCopyWithImpl;
@useResult
$Res call({
 UserHandle field0
});




}
/// @nodoc
class _$CircleOr_UserCopyWithImpl<$Res>
    implements $CircleOr_UserCopyWith<$Res> {
  _$CircleOr_UserCopyWithImpl(this._self, this._then);

  final CircleOr_User _self;
  final $Res Function(CircleOr_User) _then;

/// Create a copy of CircleOr
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(CircleOr_User(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as UserHandle,
  ));
}


}

// dart format on
