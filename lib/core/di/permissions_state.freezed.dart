// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permissions_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PermissionsState {

 bool get contactsGranted; bool get photosGranted; bool get isChecking;
/// Create a copy of PermissionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PermissionsStateCopyWith<PermissionsState> get copyWith => _$PermissionsStateCopyWithImpl<PermissionsState>(this as PermissionsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PermissionsState&&(identical(other.contactsGranted, contactsGranted) || other.contactsGranted == contactsGranted)&&(identical(other.photosGranted, photosGranted) || other.photosGranted == photosGranted)&&(identical(other.isChecking, isChecking) || other.isChecking == isChecking));
}


@override
int get hashCode => Object.hash(runtimeType,contactsGranted,photosGranted,isChecking);

@override
String toString() {
  return 'PermissionsState(contactsGranted: $contactsGranted, photosGranted: $photosGranted, isChecking: $isChecking)';
}


}

/// @nodoc
abstract mixin class $PermissionsStateCopyWith<$Res>  {
  factory $PermissionsStateCopyWith(PermissionsState value, $Res Function(PermissionsState) _then) = _$PermissionsStateCopyWithImpl;
@useResult
$Res call({
 bool contactsGranted, bool photosGranted, bool isChecking
});




}
/// @nodoc
class _$PermissionsStateCopyWithImpl<$Res>
    implements $PermissionsStateCopyWith<$Res> {
  _$PermissionsStateCopyWithImpl(this._self, this._then);

  final PermissionsState _self;
  final $Res Function(PermissionsState) _then;

/// Create a copy of PermissionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contactsGranted = null,Object? photosGranted = null,Object? isChecking = null,}) {
  return _then(_self.copyWith(
contactsGranted: null == contactsGranted ? _self.contactsGranted : contactsGranted // ignore: cast_nullable_to_non_nullable
as bool,photosGranted: null == photosGranted ? _self.photosGranted : photosGranted // ignore: cast_nullable_to_non_nullable
as bool,isChecking: null == isChecking ? _self.isChecking : isChecking // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PermissionsState].
extension PermissionsStatePatterns on PermissionsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PermissionsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PermissionsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PermissionsState value)  $default,){
final _that = this;
switch (_that) {
case _PermissionsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PermissionsState value)?  $default,){
final _that = this;
switch (_that) {
case _PermissionsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool contactsGranted,  bool photosGranted,  bool isChecking)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PermissionsState() when $default != null:
return $default(_that.contactsGranted,_that.photosGranted,_that.isChecking);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool contactsGranted,  bool photosGranted,  bool isChecking)  $default,) {final _that = this;
switch (_that) {
case _PermissionsState():
return $default(_that.contactsGranted,_that.photosGranted,_that.isChecking);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool contactsGranted,  bool photosGranted,  bool isChecking)?  $default,) {final _that = this;
switch (_that) {
case _PermissionsState() when $default != null:
return $default(_that.contactsGranted,_that.photosGranted,_that.isChecking);case _:
  return null;

}
}

}

/// @nodoc


class _PermissionsState implements PermissionsState {
  const _PermissionsState({this.contactsGranted = false, this.photosGranted = false, this.isChecking = true});
  

@override@JsonKey() final  bool contactsGranted;
@override@JsonKey() final  bool photosGranted;
@override@JsonKey() final  bool isChecking;

/// Create a copy of PermissionsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PermissionsStateCopyWith<_PermissionsState> get copyWith => __$PermissionsStateCopyWithImpl<_PermissionsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PermissionsState&&(identical(other.contactsGranted, contactsGranted) || other.contactsGranted == contactsGranted)&&(identical(other.photosGranted, photosGranted) || other.photosGranted == photosGranted)&&(identical(other.isChecking, isChecking) || other.isChecking == isChecking));
}


@override
int get hashCode => Object.hash(runtimeType,contactsGranted,photosGranted,isChecking);

@override
String toString() {
  return 'PermissionsState(contactsGranted: $contactsGranted, photosGranted: $photosGranted, isChecking: $isChecking)';
}


}

/// @nodoc
abstract mixin class _$PermissionsStateCopyWith<$Res> implements $PermissionsStateCopyWith<$Res> {
  factory _$PermissionsStateCopyWith(_PermissionsState value, $Res Function(_PermissionsState) _then) = __$PermissionsStateCopyWithImpl;
@override @useResult
$Res call({
 bool contactsGranted, bool photosGranted, bool isChecking
});




}
/// @nodoc
class __$PermissionsStateCopyWithImpl<$Res>
    implements _$PermissionsStateCopyWith<$Res> {
  __$PermissionsStateCopyWithImpl(this._self, this._then);

  final _PermissionsState _self;
  final $Res Function(_PermissionsState) _then;

/// Create a copy of PermissionsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contactsGranted = null,Object? photosGranted = null,Object? isChecking = null,}) {
  return _then(_PermissionsState(
contactsGranted: null == contactsGranted ? _self.contactsGranted : contactsGranted // ignore: cast_nullable_to_non_nullable
as bool,photosGranted: null == photosGranted ? _self.photosGranted : photosGranted // ignore: cast_nullable_to_non_nullable
as bool,isChecking: null == isChecking ? _self.isChecking : isChecking // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
