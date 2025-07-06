// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frb_generated.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PgpImportImplementor {

 Object get field0;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PgpImportImplementor&&const DeepCollectionEquality().equals(other.field0, field0));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(field0));

@override
String toString() {
  return 'PgpImportImplementor(field0: $field0)';
}


}

/// @nodoc
class $PgpImportImplementorCopyWith<$Res>  {
$PgpImportImplementorCopyWith(PgpImportImplementor _, $Res Function(PgpImportImplementor) __);
}


/// Adds pattern-matching-related methods to [PgpImportImplementor].
extension PgpImportImplementorPatterns on PgpImportImplementor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PgpImportImplementor_Variant0 value)?  variant0,TResult Function( PgpImportImplementor_Variant1 value)?  variant1,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PgpImportImplementor_Variant0() when variant0 != null:
return variant0(_that);case PgpImportImplementor_Variant1() when variant1 != null:
return variant1(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PgpImportImplementor_Variant0 value)  variant0,required TResult Function( PgpImportImplementor_Variant1 value)  variant1,}){
final _that = this;
switch (_that) {
case PgpImportImplementor_Variant0():
return variant0(_that);case PgpImportImplementor_Variant1():
return variant1(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PgpImportImplementor_Variant0 value)?  variant0,TResult? Function( PgpImportImplementor_Variant1 value)?  variant1,}){
final _that = this;
switch (_that) {
case PgpImportImplementor_Variant0() when variant0 != null:
return variant0(_that);case PgpImportImplementor_Variant1() when variant1 != null:
return variant1(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( PgpImportBytes field0)?  variant0,TResult Function( PgpImportFile field0)?  variant1,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PgpImportImplementor_Variant0() when variant0 != null:
return variant0(_that.field0);case PgpImportImplementor_Variant1() when variant1 != null:
return variant1(_that.field0);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( PgpImportBytes field0)  variant0,required TResult Function( PgpImportFile field0)  variant1,}) {final _that = this;
switch (_that) {
case PgpImportImplementor_Variant0():
return variant0(_that.field0);case PgpImportImplementor_Variant1():
return variant1(_that.field0);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( PgpImportBytes field0)?  variant0,TResult? Function( PgpImportFile field0)?  variant1,}) {final _that = this;
switch (_that) {
case PgpImportImplementor_Variant0() when variant0 != null:
return variant0(_that.field0);case PgpImportImplementor_Variant1() when variant1 != null:
return variant1(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class PgpImportImplementor_Variant0 extends PgpImportImplementor {
  const PgpImportImplementor_Variant0(this.field0): super._();
  

@override final  PgpImportBytes field0;

/// Create a copy of PgpImportImplementor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PgpImportImplementor_Variant0CopyWith<PgpImportImplementor_Variant0> get copyWith => _$PgpImportImplementor_Variant0CopyWithImpl<PgpImportImplementor_Variant0>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PgpImportImplementor_Variant0&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'PgpImportImplementor.variant0(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $PgpImportImplementor_Variant0CopyWith<$Res> implements $PgpImportImplementorCopyWith<$Res> {
  factory $PgpImportImplementor_Variant0CopyWith(PgpImportImplementor_Variant0 value, $Res Function(PgpImportImplementor_Variant0) _then) = _$PgpImportImplementor_Variant0CopyWithImpl;
@useResult
$Res call({
 PgpImportBytes field0
});




}
/// @nodoc
class _$PgpImportImplementor_Variant0CopyWithImpl<$Res>
    implements $PgpImportImplementor_Variant0CopyWith<$Res> {
  _$PgpImportImplementor_Variant0CopyWithImpl(this._self, this._then);

  final PgpImportImplementor_Variant0 _self;
  final $Res Function(PgpImportImplementor_Variant0) _then;

/// Create a copy of PgpImportImplementor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(PgpImportImplementor_Variant0(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as PgpImportBytes,
  ));
}


}

/// @nodoc


class PgpImportImplementor_Variant1 extends PgpImportImplementor {
  const PgpImportImplementor_Variant1(this.field0): super._();
  

@override final  PgpImportFile field0;

/// Create a copy of PgpImportImplementor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PgpImportImplementor_Variant1CopyWith<PgpImportImplementor_Variant1> get copyWith => _$PgpImportImplementor_Variant1CopyWithImpl<PgpImportImplementor_Variant1>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PgpImportImplementor_Variant1&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'PgpImportImplementor.variant1(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $PgpImportImplementor_Variant1CopyWith<$Res> implements $PgpImportImplementorCopyWith<$Res> {
  factory $PgpImportImplementor_Variant1CopyWith(PgpImportImplementor_Variant1 value, $Res Function(PgpImportImplementor_Variant1) _then) = _$PgpImportImplementor_Variant1CopyWithImpl;
@useResult
$Res call({
 PgpImportFile field0
});




}
/// @nodoc
class _$PgpImportImplementor_Variant1CopyWithImpl<$Res>
    implements $PgpImportImplementor_Variant1CopyWith<$Res> {
  _$PgpImportImplementor_Variant1CopyWithImpl(this._self, this._then);

  final PgpImportImplementor_Variant1 _self;
  final $Res Function(PgpImportImplementor_Variant1) _then;

/// Create a copy of PgpImportImplementor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(PgpImportImplementor_Variant1(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as PgpImportFile,
  ));
}


}

// dart format on
