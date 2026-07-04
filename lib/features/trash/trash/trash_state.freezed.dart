// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trash_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrashUiState {

 TrashTab get tab; bool get selectMode; Set<String> get selectedIds; bool get isLoading; List<TrashItem> get items; String get reclaimableLabel;
/// Create a copy of TrashUiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrashUiStateCopyWith<TrashUiState> get copyWith => _$TrashUiStateCopyWithImpl<TrashUiState>(this as TrashUiState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrashUiState&&(identical(other.tab, tab) || other.tab == tab)&&(identical(other.selectMode, selectMode) || other.selectMode == selectMode)&&const DeepCollectionEquality().equals(other.selectedIds, selectedIds)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.reclaimableLabel, reclaimableLabel) || other.reclaimableLabel == reclaimableLabel));
}


@override
int get hashCode => Object.hash(runtimeType,tab,selectMode,const DeepCollectionEquality().hash(selectedIds),isLoading,const DeepCollectionEquality().hash(items),reclaimableLabel);

@override
String toString() {
  return 'TrashUiState(tab: $tab, selectMode: $selectMode, selectedIds: $selectedIds, isLoading: $isLoading, items: $items, reclaimableLabel: $reclaimableLabel)';
}


}

/// @nodoc
abstract mixin class $TrashUiStateCopyWith<$Res>  {
  factory $TrashUiStateCopyWith(TrashUiState value, $Res Function(TrashUiState) _then) = _$TrashUiStateCopyWithImpl;
@useResult
$Res call({
 TrashTab tab, bool selectMode, Set<String> selectedIds, bool isLoading, List<TrashItem> items, String reclaimableLabel
});




}
/// @nodoc
class _$TrashUiStateCopyWithImpl<$Res>
    implements $TrashUiStateCopyWith<$Res> {
  _$TrashUiStateCopyWithImpl(this._self, this._then);

  final TrashUiState _self;
  final $Res Function(TrashUiState) _then;

/// Create a copy of TrashUiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tab = null,Object? selectMode = null,Object? selectedIds = null,Object? isLoading = null,Object? items = null,Object? reclaimableLabel = null,}) {
  return _then(_self.copyWith(
tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as TrashTab,selectMode: null == selectMode ? _self.selectMode : selectMode // ignore: cast_nullable_to_non_nullable
as bool,selectedIds: null == selectedIds ? _self.selectedIds : selectedIds // ignore: cast_nullable_to_non_nullable
as Set<String>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<TrashItem>,reclaimableLabel: null == reclaimableLabel ? _self.reclaimableLabel : reclaimableLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TrashUiState].
extension TrashUiStatePatterns on TrashUiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrashUiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrashUiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrashUiState value)  $default,){
final _that = this;
switch (_that) {
case _TrashUiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrashUiState value)?  $default,){
final _that = this;
switch (_that) {
case _TrashUiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TrashTab tab,  bool selectMode,  Set<String> selectedIds,  bool isLoading,  List<TrashItem> items,  String reclaimableLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrashUiState() when $default != null:
return $default(_that.tab,_that.selectMode,_that.selectedIds,_that.isLoading,_that.items,_that.reclaimableLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TrashTab tab,  bool selectMode,  Set<String> selectedIds,  bool isLoading,  List<TrashItem> items,  String reclaimableLabel)  $default,) {final _that = this;
switch (_that) {
case _TrashUiState():
return $default(_that.tab,_that.selectMode,_that.selectedIds,_that.isLoading,_that.items,_that.reclaimableLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TrashTab tab,  bool selectMode,  Set<String> selectedIds,  bool isLoading,  List<TrashItem> items,  String reclaimableLabel)?  $default,) {final _that = this;
switch (_that) {
case _TrashUiState() when $default != null:
return $default(_that.tab,_that.selectMode,_that.selectedIds,_that.isLoading,_that.items,_that.reclaimableLabel);case _:
  return null;

}
}

}

/// @nodoc


class _TrashUiState implements TrashUiState {
  const _TrashUiState({this.tab = TrashTab.photos, this.selectMode = false, final  Set<String> selectedIds = const <String>{}, this.isLoading = true, final  List<TrashItem> items = const <TrashItem>[], this.reclaimableLabel = ''}): _selectedIds = selectedIds,_items = items;
  

@override@JsonKey() final  TrashTab tab;
@override@JsonKey() final  bool selectMode;
 final  Set<String> _selectedIds;
@override@JsonKey() Set<String> get selectedIds {
  if (_selectedIds is EqualUnmodifiableSetView) return _selectedIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedIds);
}

@override@JsonKey() final  bool isLoading;
 final  List<TrashItem> _items;
@override@JsonKey() List<TrashItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  String reclaimableLabel;

/// Create a copy of TrashUiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrashUiStateCopyWith<_TrashUiState> get copyWith => __$TrashUiStateCopyWithImpl<_TrashUiState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrashUiState&&(identical(other.tab, tab) || other.tab == tab)&&(identical(other.selectMode, selectMode) || other.selectMode == selectMode)&&const DeepCollectionEquality().equals(other._selectedIds, _selectedIds)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.reclaimableLabel, reclaimableLabel) || other.reclaimableLabel == reclaimableLabel));
}


@override
int get hashCode => Object.hash(runtimeType,tab,selectMode,const DeepCollectionEquality().hash(_selectedIds),isLoading,const DeepCollectionEquality().hash(_items),reclaimableLabel);

@override
String toString() {
  return 'TrashUiState(tab: $tab, selectMode: $selectMode, selectedIds: $selectedIds, isLoading: $isLoading, items: $items, reclaimableLabel: $reclaimableLabel)';
}


}

/// @nodoc
abstract mixin class _$TrashUiStateCopyWith<$Res> implements $TrashUiStateCopyWith<$Res> {
  factory _$TrashUiStateCopyWith(_TrashUiState value, $Res Function(_TrashUiState) _then) = __$TrashUiStateCopyWithImpl;
@override @useResult
$Res call({
 TrashTab tab, bool selectMode, Set<String> selectedIds, bool isLoading, List<TrashItem> items, String reclaimableLabel
});




}
/// @nodoc
class __$TrashUiStateCopyWithImpl<$Res>
    implements _$TrashUiStateCopyWith<$Res> {
  __$TrashUiStateCopyWithImpl(this._self, this._then);

  final _TrashUiState _self;
  final $Res Function(_TrashUiState) _then;

/// Create a copy of TrashUiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tab = null,Object? selectMode = null,Object? selectedIds = null,Object? isLoading = null,Object? items = null,Object? reclaimableLabel = null,}) {
  return _then(_TrashUiState(
tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as TrashTab,selectMode: null == selectMode ? _self.selectMode : selectMode // ignore: cast_nullable_to_non_nullable
as bool,selectedIds: null == selectedIds ? _self._selectedIds : selectedIds // ignore: cast_nullable_to_non_nullable
as Set<String>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TrashItem>,reclaimableLabel: null == reclaimableLabel ? _self.reclaimableLabel : reclaimableLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
