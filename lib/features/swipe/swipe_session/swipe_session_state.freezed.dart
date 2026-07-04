// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'swipe_session_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SwipeSessionArgs {

 String get batchId; String get batchTitle; bool get isPhotos;
/// Create a copy of SwipeSessionArgs
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SwipeSessionArgsCopyWith<SwipeSessionArgs> get copyWith => _$SwipeSessionArgsCopyWithImpl<SwipeSessionArgs>(this as SwipeSessionArgs, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SwipeSessionArgs&&(identical(other.batchId, batchId) || other.batchId == batchId)&&(identical(other.batchTitle, batchTitle) || other.batchTitle == batchTitle)&&(identical(other.isPhotos, isPhotos) || other.isPhotos == isPhotos));
}


@override
int get hashCode => Object.hash(runtimeType,batchId,batchTitle,isPhotos);

@override
String toString() {
  return 'SwipeSessionArgs(batchId: $batchId, batchTitle: $batchTitle, isPhotos: $isPhotos)';
}


}

/// @nodoc
abstract mixin class $SwipeSessionArgsCopyWith<$Res>  {
  factory $SwipeSessionArgsCopyWith(SwipeSessionArgs value, $Res Function(SwipeSessionArgs) _then) = _$SwipeSessionArgsCopyWithImpl;
@useResult
$Res call({
 String batchId, String batchTitle, bool isPhotos
});




}
/// @nodoc
class _$SwipeSessionArgsCopyWithImpl<$Res>
    implements $SwipeSessionArgsCopyWith<$Res> {
  _$SwipeSessionArgsCopyWithImpl(this._self, this._then);

  final SwipeSessionArgs _self;
  final $Res Function(SwipeSessionArgs) _then;

/// Create a copy of SwipeSessionArgs
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? batchId = null,Object? batchTitle = null,Object? isPhotos = null,}) {
  return _then(_self.copyWith(
batchId: null == batchId ? _self.batchId : batchId // ignore: cast_nullable_to_non_nullable
as String,batchTitle: null == batchTitle ? _self.batchTitle : batchTitle // ignore: cast_nullable_to_non_nullable
as String,isPhotos: null == isPhotos ? _self.isPhotos : isPhotos // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SwipeSessionArgs].
extension SwipeSessionArgsPatterns on SwipeSessionArgs {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SwipeSessionArgs value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SwipeSessionArgs() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SwipeSessionArgs value)  $default,){
final _that = this;
switch (_that) {
case _SwipeSessionArgs():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SwipeSessionArgs value)?  $default,){
final _that = this;
switch (_that) {
case _SwipeSessionArgs() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String batchId,  String batchTitle,  bool isPhotos)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SwipeSessionArgs() when $default != null:
return $default(_that.batchId,_that.batchTitle,_that.isPhotos);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String batchId,  String batchTitle,  bool isPhotos)  $default,) {final _that = this;
switch (_that) {
case _SwipeSessionArgs():
return $default(_that.batchId,_that.batchTitle,_that.isPhotos);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String batchId,  String batchTitle,  bool isPhotos)?  $default,) {final _that = this;
switch (_that) {
case _SwipeSessionArgs() when $default != null:
return $default(_that.batchId,_that.batchTitle,_that.isPhotos);case _:
  return null;

}
}

}

/// @nodoc


class _SwipeSessionArgs implements SwipeSessionArgs {
  const _SwipeSessionArgs({required this.batchId, required this.batchTitle, required this.isPhotos});
  

@override final  String batchId;
@override final  String batchTitle;
@override final  bool isPhotos;

/// Create a copy of SwipeSessionArgs
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SwipeSessionArgsCopyWith<_SwipeSessionArgs> get copyWith => __$SwipeSessionArgsCopyWithImpl<_SwipeSessionArgs>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SwipeSessionArgs&&(identical(other.batchId, batchId) || other.batchId == batchId)&&(identical(other.batchTitle, batchTitle) || other.batchTitle == batchTitle)&&(identical(other.isPhotos, isPhotos) || other.isPhotos == isPhotos));
}


@override
int get hashCode => Object.hash(runtimeType,batchId,batchTitle,isPhotos);

@override
String toString() {
  return 'SwipeSessionArgs(batchId: $batchId, batchTitle: $batchTitle, isPhotos: $isPhotos)';
}


}

/// @nodoc
abstract mixin class _$SwipeSessionArgsCopyWith<$Res> implements $SwipeSessionArgsCopyWith<$Res> {
  factory _$SwipeSessionArgsCopyWith(_SwipeSessionArgs value, $Res Function(_SwipeSessionArgs) _then) = __$SwipeSessionArgsCopyWithImpl;
@override @useResult
$Res call({
 String batchId, String batchTitle, bool isPhotos
});




}
/// @nodoc
class __$SwipeSessionArgsCopyWithImpl<$Res>
    implements _$SwipeSessionArgsCopyWith<$Res> {
  __$SwipeSessionArgsCopyWithImpl(this._self, this._then);

  final _SwipeSessionArgs _self;
  final $Res Function(_SwipeSessionArgs) _then;

/// Create a copy of SwipeSessionArgs
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? batchId = null,Object? batchTitle = null,Object? isPhotos = null,}) {
  return _then(_SwipeSessionArgs(
batchId: null == batchId ? _self.batchId : batchId // ignore: cast_nullable_to_non_nullable
as String,batchTitle: null == batchTitle ? _self.batchTitle : batchTitle // ignore: cast_nullable_to_non_nullable
as String,isPhotos: null == isPhotos ? _self.isPhotos : isPhotos // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$SwipeSessionState {

 List<SwipeItem> get items; int get currentIndex; int get kept; int get deleted; bool get isLoading; bool get showTutorial; String get batchId; String get batchTitle; bool get isPhotos;
/// Create a copy of SwipeSessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SwipeSessionStateCopyWith<SwipeSessionState> get copyWith => _$SwipeSessionStateCopyWithImpl<SwipeSessionState>(this as SwipeSessionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SwipeSessionState&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.kept, kept) || other.kept == kept)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.showTutorial, showTutorial) || other.showTutorial == showTutorial)&&(identical(other.batchId, batchId) || other.batchId == batchId)&&(identical(other.batchTitle, batchTitle) || other.batchTitle == batchTitle)&&(identical(other.isPhotos, isPhotos) || other.isPhotos == isPhotos));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),currentIndex,kept,deleted,isLoading,showTutorial,batchId,batchTitle,isPhotos);

@override
String toString() {
  return 'SwipeSessionState(items: $items, currentIndex: $currentIndex, kept: $kept, deleted: $deleted, isLoading: $isLoading, showTutorial: $showTutorial, batchId: $batchId, batchTitle: $batchTitle, isPhotos: $isPhotos)';
}


}

/// @nodoc
abstract mixin class $SwipeSessionStateCopyWith<$Res>  {
  factory $SwipeSessionStateCopyWith(SwipeSessionState value, $Res Function(SwipeSessionState) _then) = _$SwipeSessionStateCopyWithImpl;
@useResult
$Res call({
 List<SwipeItem> items, int currentIndex, int kept, int deleted, bool isLoading, bool showTutorial, String batchId, String batchTitle, bool isPhotos
});




}
/// @nodoc
class _$SwipeSessionStateCopyWithImpl<$Res>
    implements $SwipeSessionStateCopyWith<$Res> {
  _$SwipeSessionStateCopyWithImpl(this._self, this._then);

  final SwipeSessionState _self;
  final $Res Function(SwipeSessionState) _then;

/// Create a copy of SwipeSessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? currentIndex = null,Object? kept = null,Object? deleted = null,Object? isLoading = null,Object? showTutorial = null,Object? batchId = null,Object? batchTitle = null,Object? isPhotos = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<SwipeItem>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,kept: null == kept ? _self.kept : kept // ignore: cast_nullable_to_non_nullable
as int,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,showTutorial: null == showTutorial ? _self.showTutorial : showTutorial // ignore: cast_nullable_to_non_nullable
as bool,batchId: null == batchId ? _self.batchId : batchId // ignore: cast_nullable_to_non_nullable
as String,batchTitle: null == batchTitle ? _self.batchTitle : batchTitle // ignore: cast_nullable_to_non_nullable
as String,isPhotos: null == isPhotos ? _self.isPhotos : isPhotos // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SwipeSessionState].
extension SwipeSessionStatePatterns on SwipeSessionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SwipeSessionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SwipeSessionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SwipeSessionState value)  $default,){
final _that = this;
switch (_that) {
case _SwipeSessionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SwipeSessionState value)?  $default,){
final _that = this;
switch (_that) {
case _SwipeSessionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SwipeItem> items,  int currentIndex,  int kept,  int deleted,  bool isLoading,  bool showTutorial,  String batchId,  String batchTitle,  bool isPhotos)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SwipeSessionState() when $default != null:
return $default(_that.items,_that.currentIndex,_that.kept,_that.deleted,_that.isLoading,_that.showTutorial,_that.batchId,_that.batchTitle,_that.isPhotos);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SwipeItem> items,  int currentIndex,  int kept,  int deleted,  bool isLoading,  bool showTutorial,  String batchId,  String batchTitle,  bool isPhotos)  $default,) {final _that = this;
switch (_that) {
case _SwipeSessionState():
return $default(_that.items,_that.currentIndex,_that.kept,_that.deleted,_that.isLoading,_that.showTutorial,_that.batchId,_that.batchTitle,_that.isPhotos);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SwipeItem> items,  int currentIndex,  int kept,  int deleted,  bool isLoading,  bool showTutorial,  String batchId,  String batchTitle,  bool isPhotos)?  $default,) {final _that = this;
switch (_that) {
case _SwipeSessionState() when $default != null:
return $default(_that.items,_that.currentIndex,_that.kept,_that.deleted,_that.isLoading,_that.showTutorial,_that.batchId,_that.batchTitle,_that.isPhotos);case _:
  return null;

}
}

}

/// @nodoc


class _SwipeSessionState extends SwipeSessionState {
  const _SwipeSessionState({final  List<SwipeItem> items = const <SwipeItem>[], this.currentIndex = 0, this.kept = 0, this.deleted = 0, this.isLoading = true, this.showTutorial = false, this.batchId = '', this.batchTitle = '', this.isPhotos = true}): _items = items,super._();
  

 final  List<SwipeItem> _items;
@override@JsonKey() List<SwipeItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int currentIndex;
@override@JsonKey() final  int kept;
@override@JsonKey() final  int deleted;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool showTutorial;
@override@JsonKey() final  String batchId;
@override@JsonKey() final  String batchTitle;
@override@JsonKey() final  bool isPhotos;

/// Create a copy of SwipeSessionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SwipeSessionStateCopyWith<_SwipeSessionState> get copyWith => __$SwipeSessionStateCopyWithImpl<_SwipeSessionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SwipeSessionState&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.kept, kept) || other.kept == kept)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.showTutorial, showTutorial) || other.showTutorial == showTutorial)&&(identical(other.batchId, batchId) || other.batchId == batchId)&&(identical(other.batchTitle, batchTitle) || other.batchTitle == batchTitle)&&(identical(other.isPhotos, isPhotos) || other.isPhotos == isPhotos));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),currentIndex,kept,deleted,isLoading,showTutorial,batchId,batchTitle,isPhotos);

@override
String toString() {
  return 'SwipeSessionState(items: $items, currentIndex: $currentIndex, kept: $kept, deleted: $deleted, isLoading: $isLoading, showTutorial: $showTutorial, batchId: $batchId, batchTitle: $batchTitle, isPhotos: $isPhotos)';
}


}

/// @nodoc
abstract mixin class _$SwipeSessionStateCopyWith<$Res> implements $SwipeSessionStateCopyWith<$Res> {
  factory _$SwipeSessionStateCopyWith(_SwipeSessionState value, $Res Function(_SwipeSessionState) _then) = __$SwipeSessionStateCopyWithImpl;
@override @useResult
$Res call({
 List<SwipeItem> items, int currentIndex, int kept, int deleted, bool isLoading, bool showTutorial, String batchId, String batchTitle, bool isPhotos
});




}
/// @nodoc
class __$SwipeSessionStateCopyWithImpl<$Res>
    implements _$SwipeSessionStateCopyWith<$Res> {
  __$SwipeSessionStateCopyWithImpl(this._self, this._then);

  final _SwipeSessionState _self;
  final $Res Function(_SwipeSessionState) _then;

/// Create a copy of SwipeSessionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? currentIndex = null,Object? kept = null,Object? deleted = null,Object? isLoading = null,Object? showTutorial = null,Object? batchId = null,Object? batchTitle = null,Object? isPhotos = null,}) {
  return _then(_SwipeSessionState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<SwipeItem>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,kept: null == kept ? _self.kept : kept // ignore: cast_nullable_to_non_nullable
as int,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,showTutorial: null == showTutorial ? _self.showTutorial : showTutorial // ignore: cast_nullable_to_non_nullable
as bool,batchId: null == batchId ? _self.batchId : batchId // ignore: cast_nullable_to_non_nullable
as String,batchTitle: null == batchTitle ? _self.batchTitle : batchTitle // ignore: cast_nullable_to_non_nullable
as String,isPhotos: null == isPhotos ? _self.isPhotos : isPhotos // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
