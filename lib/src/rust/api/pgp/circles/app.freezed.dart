// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MaybeDeleted {

 CircleHandle get field0;
/// Create a copy of MaybeDeleted
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaybeDeletedCopyWith<MaybeDeleted> get copyWith => _$MaybeDeletedCopyWithImpl<MaybeDeleted>(this as MaybeDeleted, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaybeDeleted&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'MaybeDeleted(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $MaybeDeletedCopyWith<$Res>  {
  factory $MaybeDeletedCopyWith(MaybeDeleted value, $Res Function(MaybeDeleted) _then) = _$MaybeDeletedCopyWithImpl;
@useResult
$Res call({
 CircleHandle field0
});




}
/// @nodoc
class _$MaybeDeletedCopyWithImpl<$Res>
    implements $MaybeDeletedCopyWith<$Res> {
  _$MaybeDeletedCopyWithImpl(this._self, this._then);

  final MaybeDeleted _self;
  final $Res Function(MaybeDeleted) _then;

/// Create a copy of MaybeDeleted
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? field0 = null,}) {
  return _then(_self.copyWith(
field0: null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as CircleHandle,
  ));
}

}


/// Adds pattern-matching-related methods to [MaybeDeleted].
extension MaybeDeletedPatterns on MaybeDeleted {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MaybeDeleted_Member value)?  member,TResult Function( MaybeDeleted_Deleted value)?  deleted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MaybeDeleted_Member() when member != null:
return member(_that);case MaybeDeleted_Deleted() when deleted != null:
return deleted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MaybeDeleted_Member value)  member,required TResult Function( MaybeDeleted_Deleted value)  deleted,}){
final _that = this;
switch (_that) {
case MaybeDeleted_Member():
return member(_that);case MaybeDeleted_Deleted():
return deleted(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MaybeDeleted_Member value)?  member,TResult? Function( MaybeDeleted_Deleted value)?  deleted,}){
final _that = this;
switch (_that) {
case MaybeDeleted_Member() when member != null:
return member(_that);case MaybeDeleted_Deleted() when deleted != null:
return deleted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( CircleHandle field0)?  member,TResult Function( CircleHandle field0)?  deleted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MaybeDeleted_Member() when member != null:
return member(_that.field0);case MaybeDeleted_Deleted() when deleted != null:
return deleted(_that.field0);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( CircleHandle field0)  member,required TResult Function( CircleHandle field0)  deleted,}) {final _that = this;
switch (_that) {
case MaybeDeleted_Member():
return member(_that.field0);case MaybeDeleted_Deleted():
return deleted(_that.field0);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( CircleHandle field0)?  member,TResult? Function( CircleHandle field0)?  deleted,}) {final _that = this;
switch (_that) {
case MaybeDeleted_Member() when member != null:
return member(_that.field0);case MaybeDeleted_Deleted() when deleted != null:
return deleted(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class MaybeDeleted_Member extends MaybeDeleted {
  const MaybeDeleted_Member(this.field0): super._();
  

@override final  CircleHandle field0;

/// Create a copy of MaybeDeleted
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaybeDeleted_MemberCopyWith<MaybeDeleted_Member> get copyWith => _$MaybeDeleted_MemberCopyWithImpl<MaybeDeleted_Member>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaybeDeleted_Member&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'MaybeDeleted.member(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $MaybeDeleted_MemberCopyWith<$Res> implements $MaybeDeletedCopyWith<$Res> {
  factory $MaybeDeleted_MemberCopyWith(MaybeDeleted_Member value, $Res Function(MaybeDeleted_Member) _then) = _$MaybeDeleted_MemberCopyWithImpl;
@override @useResult
$Res call({
 CircleHandle field0
});




}
/// @nodoc
class _$MaybeDeleted_MemberCopyWithImpl<$Res>
    implements $MaybeDeleted_MemberCopyWith<$Res> {
  _$MaybeDeleted_MemberCopyWithImpl(this._self, this._then);

  final MaybeDeleted_Member _self;
  final $Res Function(MaybeDeleted_Member) _then;

/// Create a copy of MaybeDeleted
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(MaybeDeleted_Member(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as CircleHandle,
  ));
}


}

/// @nodoc


class MaybeDeleted_Deleted extends MaybeDeleted {
  const MaybeDeleted_Deleted(this.field0): super._();
  

@override final  CircleHandle field0;

/// Create a copy of MaybeDeleted
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaybeDeleted_DeletedCopyWith<MaybeDeleted_Deleted> get copyWith => _$MaybeDeleted_DeletedCopyWithImpl<MaybeDeleted_Deleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaybeDeleted_Deleted&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'MaybeDeleted.deleted(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $MaybeDeleted_DeletedCopyWith<$Res> implements $MaybeDeletedCopyWith<$Res> {
  factory $MaybeDeleted_DeletedCopyWith(MaybeDeleted_Deleted value, $Res Function(MaybeDeleted_Deleted) _then) = _$MaybeDeleted_DeletedCopyWithImpl;
@override @useResult
$Res call({
 CircleHandle field0
});




}
/// @nodoc
class _$MaybeDeleted_DeletedCopyWithImpl<$Res>
    implements $MaybeDeleted_DeletedCopyWith<$Res> {
  _$MaybeDeleted_DeletedCopyWithImpl(this._self, this._then);

  final MaybeDeleted_Deleted _self;
  final $Res Function(MaybeDeleted_Deleted) _then;

/// Create a copy of MaybeDeleted
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(MaybeDeleted_Deleted(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as CircleHandle,
  ));
}


}

// dart format on
