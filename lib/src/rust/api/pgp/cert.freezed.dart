// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MaybeCert {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaybeCert);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MaybeCert()';
}


}

/// @nodoc
class $MaybeCertCopyWith<$Res>  {
$MaybeCertCopyWith(MaybeCert _, $Res Function(MaybeCert) __);
}


/// Adds pattern-matching-related methods to [MaybeCert].
extension MaybeCertPatterns on MaybeCert {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MaybeCert_Full value)?  full,TResult Function( MaybeCert_Fingerprint value)?  fingerprint,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MaybeCert_Full() when full != null:
return full(_that);case MaybeCert_Fingerprint() when fingerprint != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MaybeCert_Full value)  full,required TResult Function( MaybeCert_Fingerprint value)  fingerprint,}){
final _that = this;
switch (_that) {
case MaybeCert_Full():
return full(_that);case MaybeCert_Fingerprint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MaybeCert_Full value)?  full,TResult? Function( MaybeCert_Fingerprint value)?  fingerprint,}){
final _that = this;
switch (_that) {
case MaybeCert_Full() when full != null:
return full(_that);case MaybeCert_Fingerprint() when fingerprint != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( PgpCertWithIds cert)?  full,TResult Function( UserHandle fpr)?  fingerprint,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MaybeCert_Full() when full != null:
return full(_that.cert);case MaybeCert_Fingerprint() when fingerprint != null:
return fingerprint(_that.fpr);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( PgpCertWithIds cert)  full,required TResult Function( UserHandle fpr)  fingerprint,}) {final _that = this;
switch (_that) {
case MaybeCert_Full():
return full(_that.cert);case MaybeCert_Fingerprint():
return fingerprint(_that.fpr);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( PgpCertWithIds cert)?  full,TResult? Function( UserHandle fpr)?  fingerprint,}) {final _that = this;
switch (_that) {
case MaybeCert_Full() when full != null:
return full(_that.cert);case MaybeCert_Fingerprint() when fingerprint != null:
return fingerprint(_that.fpr);case _:
  return null;

}
}

}

/// @nodoc


class MaybeCert_Full extends MaybeCert {
  const MaybeCert_Full({required this.cert}): super._();
  

 final  PgpCertWithIds cert;

/// Create a copy of MaybeCert
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaybeCert_FullCopyWith<MaybeCert_Full> get copyWith => _$MaybeCert_FullCopyWithImpl<MaybeCert_Full>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaybeCert_Full&&(identical(other.cert, cert) || other.cert == cert));
}


@override
int get hashCode => Object.hash(runtimeType,cert);

@override
String toString() {
  return 'MaybeCert.full(cert: $cert)';
}


}

/// @nodoc
abstract mixin class $MaybeCert_FullCopyWith<$Res> implements $MaybeCertCopyWith<$Res> {
  factory $MaybeCert_FullCopyWith(MaybeCert_Full value, $Res Function(MaybeCert_Full) _then) = _$MaybeCert_FullCopyWithImpl;
@useResult
$Res call({
 PgpCertWithIds cert
});




}
/// @nodoc
class _$MaybeCert_FullCopyWithImpl<$Res>
    implements $MaybeCert_FullCopyWith<$Res> {
  _$MaybeCert_FullCopyWithImpl(this._self, this._then);

  final MaybeCert_Full _self;
  final $Res Function(MaybeCert_Full) _then;

/// Create a copy of MaybeCert
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cert = null,}) {
  return _then(MaybeCert_Full(
cert: null == cert ? _self.cert : cert // ignore: cast_nullable_to_non_nullable
as PgpCertWithIds,
  ));
}


}

/// @nodoc


class MaybeCert_Fingerprint extends MaybeCert {
  const MaybeCert_Fingerprint({required this.fpr}): super._();
  

 final  UserHandle fpr;

/// Create a copy of MaybeCert
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaybeCert_FingerprintCopyWith<MaybeCert_Fingerprint> get copyWith => _$MaybeCert_FingerprintCopyWithImpl<MaybeCert_Fingerprint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaybeCert_Fingerprint&&(identical(other.fpr, fpr) || other.fpr == fpr));
}


@override
int get hashCode => Object.hash(runtimeType,fpr);

@override
String toString() {
  return 'MaybeCert.fingerprint(fpr: $fpr)';
}


}

/// @nodoc
abstract mixin class $MaybeCert_FingerprintCopyWith<$Res> implements $MaybeCertCopyWith<$Res> {
  factory $MaybeCert_FingerprintCopyWith(MaybeCert_Fingerprint value, $Res Function(MaybeCert_Fingerprint) _then) = _$MaybeCert_FingerprintCopyWithImpl;
@useResult
$Res call({
 UserHandle fpr
});




}
/// @nodoc
class _$MaybeCert_FingerprintCopyWithImpl<$Res>
    implements $MaybeCert_FingerprintCopyWith<$Res> {
  _$MaybeCert_FingerprintCopyWithImpl(this._self, this._then);

  final MaybeCert_Fingerprint _self;
  final $Res Function(MaybeCert_Fingerprint) _then;

/// Create a copy of MaybeCert
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fpr = null,}) {
  return _then(MaybeCert_Fingerprint(
fpr: null == fpr ? _self.fpr : fpr // ignore: cast_nullable_to_non_nullable
as UserHandle,
  ));
}


}

// dart format on
