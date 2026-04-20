// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visual_key.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VisualKeyOr {

 Object get field0;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VisualKeyOr&&const DeepCollectionEquality().equals(other.field0, field0));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(field0));

@override
String toString() {
  return 'VisualKeyOr(field0: $field0)';
}


}

/// @nodoc
class $VisualKeyOrCopyWith<$Res>  {
$VisualKeyOrCopyWith(VisualKeyOr _, $Res Function(VisualKeyOr) __);
}


/// Adds pattern-matching-related methods to [VisualKeyOr].
extension VisualKeyOrPatterns on VisualKeyOr {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VisualKeyOr_Gismu value)?  gismu,TResult Function( VisualKeyOr_Name value)?  name,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VisualKeyOr_Gismu() when gismu != null:
return gismu(_that);case VisualKeyOr_Name() when name != null:
return name(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VisualKeyOr_Gismu value)  gismu,required TResult Function( VisualKeyOr_Name value)  name,}){
final _that = this;
switch (_that) {
case VisualKeyOr_Gismu():
return gismu(_that);case VisualKeyOr_Name():
return name(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VisualKeyOr_Gismu value)?  gismu,TResult? Function( VisualKeyOr_Name value)?  name,}){
final _that = this;
switch (_that) {
case VisualKeyOr_Gismu() when gismu != null:
return gismu(_that);case VisualKeyOr_Name() when name != null:
return name(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( VisualKey field0)?  gismu,TResult Function( String field0)?  name,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VisualKeyOr_Gismu() when gismu != null:
return gismu(_that.field0);case VisualKeyOr_Name() when name != null:
return name(_that.field0);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( VisualKey field0)  gismu,required TResult Function( String field0)  name,}) {final _that = this;
switch (_that) {
case VisualKeyOr_Gismu():
return gismu(_that.field0);case VisualKeyOr_Name():
return name(_that.field0);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( VisualKey field0)?  gismu,TResult? Function( String field0)?  name,}) {final _that = this;
switch (_that) {
case VisualKeyOr_Gismu() when gismu != null:
return gismu(_that.field0);case VisualKeyOr_Name() when name != null:
return name(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class VisualKeyOr_Gismu extends VisualKeyOr {
  const VisualKeyOr_Gismu(this.field0): super._();
  

@override final  VisualKey field0;

/// Create a copy of VisualKeyOr
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VisualKeyOr_GismuCopyWith<VisualKeyOr_Gismu> get copyWith => _$VisualKeyOr_GismuCopyWithImpl<VisualKeyOr_Gismu>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VisualKeyOr_Gismu&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'VisualKeyOr.gismu(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $VisualKeyOr_GismuCopyWith<$Res> implements $VisualKeyOrCopyWith<$Res> {
  factory $VisualKeyOr_GismuCopyWith(VisualKeyOr_Gismu value, $Res Function(VisualKeyOr_Gismu) _then) = _$VisualKeyOr_GismuCopyWithImpl;
@useResult
$Res call({
 VisualKey field0
});




}
/// @nodoc
class _$VisualKeyOr_GismuCopyWithImpl<$Res>
    implements $VisualKeyOr_GismuCopyWith<$Res> {
  _$VisualKeyOr_GismuCopyWithImpl(this._self, this._then);

  final VisualKeyOr_Gismu _self;
  final $Res Function(VisualKeyOr_Gismu) _then;

/// Create a copy of VisualKeyOr
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(VisualKeyOr_Gismu(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as VisualKey,
  ));
}


}

/// @nodoc


class VisualKeyOr_Name extends VisualKeyOr {
  const VisualKeyOr_Name(this.field0): super._();
  

@override final  String field0;

/// Create a copy of VisualKeyOr
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VisualKeyOr_NameCopyWith<VisualKeyOr_Name> get copyWith => _$VisualKeyOr_NameCopyWithImpl<VisualKeyOr_Name>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VisualKeyOr_Name&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'VisualKeyOr.name(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $VisualKeyOr_NameCopyWith<$Res> implements $VisualKeyOrCopyWith<$Res> {
  factory $VisualKeyOr_NameCopyWith(VisualKeyOr_Name value, $Res Function(VisualKeyOr_Name) _then) = _$VisualKeyOr_NameCopyWithImpl;
@useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$VisualKeyOr_NameCopyWithImpl<$Res>
    implements $VisualKeyOr_NameCopyWith<$Res> {
  _$VisualKeyOr_NameCopyWithImpl(this._self, this._then);

  final VisualKeyOr_Name _self;
  final $Res Function(VisualKeyOr_Name) _then;

/// Create a copy of VisualKeyOr
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(VisualKeyOr_Name(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
