// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppState {

 bool get onboardingComplete; bool get tutorialSeen; bool get hasActivity; bool get contactsGranted; bool get photosGranted; bool get hapticOn; bool get notifOn; bool get signedIn; bool get isLoading;
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStateCopyWith<AppState> get copyWith => _$AppStateCopyWithImpl<AppState>(this as AppState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppState&&(identical(other.onboardingComplete, onboardingComplete) || other.onboardingComplete == onboardingComplete)&&(identical(other.tutorialSeen, tutorialSeen) || other.tutorialSeen == tutorialSeen)&&(identical(other.hasActivity, hasActivity) || other.hasActivity == hasActivity)&&(identical(other.contactsGranted, contactsGranted) || other.contactsGranted == contactsGranted)&&(identical(other.photosGranted, photosGranted) || other.photosGranted == photosGranted)&&(identical(other.hapticOn, hapticOn) || other.hapticOn == hapticOn)&&(identical(other.notifOn, notifOn) || other.notifOn == notifOn)&&(identical(other.signedIn, signedIn) || other.signedIn == signedIn)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,onboardingComplete,tutorialSeen,hasActivity,contactsGranted,photosGranted,hapticOn,notifOn,signedIn,isLoading);

@override
String toString() {
  return 'AppState(onboardingComplete: $onboardingComplete, tutorialSeen: $tutorialSeen, hasActivity: $hasActivity, contactsGranted: $contactsGranted, photosGranted: $photosGranted, hapticOn: $hapticOn, notifOn: $notifOn, signedIn: $signedIn, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $AppStateCopyWith<$Res>  {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) _then) = _$AppStateCopyWithImpl;
@useResult
$Res call({
 bool onboardingComplete, bool tutorialSeen, bool hasActivity, bool contactsGranted, bool photosGranted, bool hapticOn, bool notifOn, bool signedIn, bool isLoading
});




}
/// @nodoc
class _$AppStateCopyWithImpl<$Res>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._self, this._then);

  final AppState _self;
  final $Res Function(AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? onboardingComplete = null,Object? tutorialSeen = null,Object? hasActivity = null,Object? contactsGranted = null,Object? photosGranted = null,Object? hapticOn = null,Object? notifOn = null,Object? signedIn = null,Object? isLoading = null,}) {
  return _then(_self.copyWith(
onboardingComplete: null == onboardingComplete ? _self.onboardingComplete : onboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,tutorialSeen: null == tutorialSeen ? _self.tutorialSeen : tutorialSeen // ignore: cast_nullable_to_non_nullable
as bool,hasActivity: null == hasActivity ? _self.hasActivity : hasActivity // ignore: cast_nullable_to_non_nullable
as bool,contactsGranted: null == contactsGranted ? _self.contactsGranted : contactsGranted // ignore: cast_nullable_to_non_nullable
as bool,photosGranted: null == photosGranted ? _self.photosGranted : photosGranted // ignore: cast_nullable_to_non_nullable
as bool,hapticOn: null == hapticOn ? _self.hapticOn : hapticOn // ignore: cast_nullable_to_non_nullable
as bool,notifOn: null == notifOn ? _self.notifOn : notifOn // ignore: cast_nullable_to_non_nullable
as bool,signedIn: null == signedIn ? _self.signedIn : signedIn // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppState].
extension AppStatePatterns on AppState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppState value)  $default,){
final _that = this;
switch (_that) {
case _AppState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppState value)?  $default,){
final _that = this;
switch (_that) {
case _AppState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool onboardingComplete,  bool tutorialSeen,  bool hasActivity,  bool contactsGranted,  bool photosGranted,  bool hapticOn,  bool notifOn,  bool signedIn,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that.onboardingComplete,_that.tutorialSeen,_that.hasActivity,_that.contactsGranted,_that.photosGranted,_that.hapticOn,_that.notifOn,_that.signedIn,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool onboardingComplete,  bool tutorialSeen,  bool hasActivity,  bool contactsGranted,  bool photosGranted,  bool hapticOn,  bool notifOn,  bool signedIn,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _AppState():
return $default(_that.onboardingComplete,_that.tutorialSeen,_that.hasActivity,_that.contactsGranted,_that.photosGranted,_that.hapticOn,_that.notifOn,_that.signedIn,_that.isLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool onboardingComplete,  bool tutorialSeen,  bool hasActivity,  bool contactsGranted,  bool photosGranted,  bool hapticOn,  bool notifOn,  bool signedIn,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that.onboardingComplete,_that.tutorialSeen,_that.hasActivity,_that.contactsGranted,_that.photosGranted,_that.hapticOn,_that.notifOn,_that.signedIn,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _AppState implements AppState {
  const _AppState({this.onboardingComplete = false, this.tutorialSeen = false, this.hasActivity = false, this.contactsGranted = false, this.photosGranted = false, this.hapticOn = true, this.notifOn = true, this.signedIn = false, this.isLoading = true});
  

@override@JsonKey() final  bool onboardingComplete;
@override@JsonKey() final  bool tutorialSeen;
@override@JsonKey() final  bool hasActivity;
@override@JsonKey() final  bool contactsGranted;
@override@JsonKey() final  bool photosGranted;
@override@JsonKey() final  bool hapticOn;
@override@JsonKey() final  bool notifOn;
@override@JsonKey() final  bool signedIn;
@override@JsonKey() final  bool isLoading;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppStateCopyWith<_AppState> get copyWith => __$AppStateCopyWithImpl<_AppState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppState&&(identical(other.onboardingComplete, onboardingComplete) || other.onboardingComplete == onboardingComplete)&&(identical(other.tutorialSeen, tutorialSeen) || other.tutorialSeen == tutorialSeen)&&(identical(other.hasActivity, hasActivity) || other.hasActivity == hasActivity)&&(identical(other.contactsGranted, contactsGranted) || other.contactsGranted == contactsGranted)&&(identical(other.photosGranted, photosGranted) || other.photosGranted == photosGranted)&&(identical(other.hapticOn, hapticOn) || other.hapticOn == hapticOn)&&(identical(other.notifOn, notifOn) || other.notifOn == notifOn)&&(identical(other.signedIn, signedIn) || other.signedIn == signedIn)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,onboardingComplete,tutorialSeen,hasActivity,contactsGranted,photosGranted,hapticOn,notifOn,signedIn,isLoading);

@override
String toString() {
  return 'AppState(onboardingComplete: $onboardingComplete, tutorialSeen: $tutorialSeen, hasActivity: $hasActivity, contactsGranted: $contactsGranted, photosGranted: $photosGranted, hapticOn: $hapticOn, notifOn: $notifOn, signedIn: $signedIn, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) _then) = __$AppStateCopyWithImpl;
@override @useResult
$Res call({
 bool onboardingComplete, bool tutorialSeen, bool hasActivity, bool contactsGranted, bool photosGranted, bool hapticOn, bool notifOn, bool signedIn, bool isLoading
});




}
/// @nodoc
class __$AppStateCopyWithImpl<$Res>
    implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(this._self, this._then);

  final _AppState _self;
  final $Res Function(_AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? onboardingComplete = null,Object? tutorialSeen = null,Object? hasActivity = null,Object? contactsGranted = null,Object? photosGranted = null,Object? hapticOn = null,Object? notifOn = null,Object? signedIn = null,Object? isLoading = null,}) {
  return _then(_AppState(
onboardingComplete: null == onboardingComplete ? _self.onboardingComplete : onboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,tutorialSeen: null == tutorialSeen ? _self.tutorialSeen : tutorialSeen // ignore: cast_nullable_to_non_nullable
as bool,hasActivity: null == hasActivity ? _self.hasActivity : hasActivity // ignore: cast_nullable_to_non_nullable
as bool,contactsGranted: null == contactsGranted ? _self.contactsGranted : contactsGranted // ignore: cast_nullable_to_non_nullable
as bool,photosGranted: null == photosGranted ? _self.photosGranted : photosGranted // ignore: cast_nullable_to_non_nullable
as bool,hapticOn: null == hapticOn ? _self.hapticOn : hapticOn // ignore: cast_nullable_to_non_nullable
as bool,notifOn: null == notifOn ? _self.notifOn : notifOn // ignore: cast_nullable_to_non_nullable
as bool,signedIn: null == signedIn ? _self.signedIn : signedIn // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
