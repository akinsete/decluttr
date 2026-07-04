// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'duplicate_contacts_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DuplicateContactsState {

 List<DuplicateGroup> get groups; int get index; int get merged; int get kept; int get deleted; bool get isComplete;
/// Create a copy of DuplicateContactsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DuplicateContactsStateCopyWith<DuplicateContactsState> get copyWith => _$DuplicateContactsStateCopyWithImpl<DuplicateContactsState>(this as DuplicateContactsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DuplicateContactsState&&const DeepCollectionEquality().equals(other.groups, groups)&&(identical(other.index, index) || other.index == index)&&(identical(other.merged, merged) || other.merged == merged)&&(identical(other.kept, kept) || other.kept == kept)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.isComplete, isComplete) || other.isComplete == isComplete));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(groups),index,merged,kept,deleted,isComplete);

@override
String toString() {
  return 'DuplicateContactsState(groups: $groups, index: $index, merged: $merged, kept: $kept, deleted: $deleted, isComplete: $isComplete)';
}


}

/// @nodoc
abstract mixin class $DuplicateContactsStateCopyWith<$Res>  {
  factory $DuplicateContactsStateCopyWith(DuplicateContactsState value, $Res Function(DuplicateContactsState) _then) = _$DuplicateContactsStateCopyWithImpl;
@useResult
$Res call({
 List<DuplicateGroup> groups, int index, int merged, int kept, int deleted, bool isComplete
});




}
/// @nodoc
class _$DuplicateContactsStateCopyWithImpl<$Res>
    implements $DuplicateContactsStateCopyWith<$Res> {
  _$DuplicateContactsStateCopyWithImpl(this._self, this._then);

  final DuplicateContactsState _self;
  final $Res Function(DuplicateContactsState) _then;

/// Create a copy of DuplicateContactsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? groups = null,Object? index = null,Object? merged = null,Object? kept = null,Object? deleted = null,Object? isComplete = null,}) {
  return _then(_self.copyWith(
groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as List<DuplicateGroup>,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,merged: null == merged ? _self.merged : merged // ignore: cast_nullable_to_non_nullable
as int,kept: null == kept ? _self.kept : kept // ignore: cast_nullable_to_non_nullable
as int,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as int,isComplete: null == isComplete ? _self.isComplete : isComplete // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DuplicateContactsState].
extension DuplicateContactsStatePatterns on DuplicateContactsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DuplicateContactsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DuplicateContactsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DuplicateContactsState value)  $default,){
final _that = this;
switch (_that) {
case _DuplicateContactsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DuplicateContactsState value)?  $default,){
final _that = this;
switch (_that) {
case _DuplicateContactsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DuplicateGroup> groups,  int index,  int merged,  int kept,  int deleted,  bool isComplete)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DuplicateContactsState() when $default != null:
return $default(_that.groups,_that.index,_that.merged,_that.kept,_that.deleted,_that.isComplete);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DuplicateGroup> groups,  int index,  int merged,  int kept,  int deleted,  bool isComplete)  $default,) {final _that = this;
switch (_that) {
case _DuplicateContactsState():
return $default(_that.groups,_that.index,_that.merged,_that.kept,_that.deleted,_that.isComplete);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DuplicateGroup> groups,  int index,  int merged,  int kept,  int deleted,  bool isComplete)?  $default,) {final _that = this;
switch (_that) {
case _DuplicateContactsState() when $default != null:
return $default(_that.groups,_that.index,_that.merged,_that.kept,_that.deleted,_that.isComplete);case _:
  return null;

}
}

}

/// @nodoc


class _DuplicateContactsState extends DuplicateContactsState {
  const _DuplicateContactsState({final  List<DuplicateGroup> groups = const <DuplicateGroup>[], this.index = 0, this.merged = 0, this.kept = 0, this.deleted = 0, this.isComplete = false}): _groups = groups,super._();
  

 final  List<DuplicateGroup> _groups;
@override@JsonKey() List<DuplicateGroup> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}

@override@JsonKey() final  int index;
@override@JsonKey() final  int merged;
@override@JsonKey() final  int kept;
@override@JsonKey() final  int deleted;
@override@JsonKey() final  bool isComplete;

/// Create a copy of DuplicateContactsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DuplicateContactsStateCopyWith<_DuplicateContactsState> get copyWith => __$DuplicateContactsStateCopyWithImpl<_DuplicateContactsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DuplicateContactsState&&const DeepCollectionEquality().equals(other._groups, _groups)&&(identical(other.index, index) || other.index == index)&&(identical(other.merged, merged) || other.merged == merged)&&(identical(other.kept, kept) || other.kept == kept)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.isComplete, isComplete) || other.isComplete == isComplete));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_groups),index,merged,kept,deleted,isComplete);

@override
String toString() {
  return 'DuplicateContactsState(groups: $groups, index: $index, merged: $merged, kept: $kept, deleted: $deleted, isComplete: $isComplete)';
}


}

/// @nodoc
abstract mixin class _$DuplicateContactsStateCopyWith<$Res> implements $DuplicateContactsStateCopyWith<$Res> {
  factory _$DuplicateContactsStateCopyWith(_DuplicateContactsState value, $Res Function(_DuplicateContactsState) _then) = __$DuplicateContactsStateCopyWithImpl;
@override @useResult
$Res call({
 List<DuplicateGroup> groups, int index, int merged, int kept, int deleted, bool isComplete
});




}
/// @nodoc
class __$DuplicateContactsStateCopyWithImpl<$Res>
    implements _$DuplicateContactsStateCopyWith<$Res> {
  __$DuplicateContactsStateCopyWithImpl(this._self, this._then);

  final _DuplicateContactsState _self;
  final $Res Function(_DuplicateContactsState) _then;

/// Create a copy of DuplicateContactsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? groups = null,Object? index = null,Object? merged = null,Object? kept = null,Object? deleted = null,Object? isComplete = null,}) {
  return _then(_DuplicateContactsState(
groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<DuplicateGroup>,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,merged: null == merged ? _self.merged : merged // ignore: cast_nullable_to_non_nullable
as int,kept: null == kept ? _self.kept : kept // ignore: cast_nullable_to_non_nullable
as int,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as int,isComplete: null == isComplete ? _self.isComplete : isComplete // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
