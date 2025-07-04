// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MyError {
  ErrorType get type;
  String get message;

  /// Create a copy of MyError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MyErrorCopyWith<MyError> get copyWith =>
      _$MyErrorCopyWithImpl<MyError>(this as MyError, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MyError &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, message);

  @override
  String toString() {
    return 'MyError(type: $type, message: $message)';
  }
}

/// @nodoc
abstract mixin class $MyErrorCopyWith<$Res> {
  factory $MyErrorCopyWith(MyError value, $Res Function(MyError) _then) =
      _$MyErrorCopyWithImpl;
  @useResult
  $Res call({ErrorType type, String message});
}

/// @nodoc
class _$MyErrorCopyWithImpl<$Res> implements $MyErrorCopyWith<$Res> {
  _$MyErrorCopyWithImpl(this._self, this._then);

  final MyError _self;
  final $Res Function(MyError) _then;

  /// Create a copy of MyError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? message = null,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ErrorType,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _MyError implements MyError {
  const _MyError({required this.type, required this.message});

  @override
  final ErrorType type;
  @override
  final String message;

  /// Create a copy of MyError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MyErrorCopyWith<_MyError> get copyWith =>
      __$MyErrorCopyWithImpl<_MyError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MyError &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, message);

  @override
  String toString() {
    return 'MyError(type: $type, message: $message)';
  }
}

/// @nodoc
abstract mixin class _$MyErrorCopyWith<$Res> implements $MyErrorCopyWith<$Res> {
  factory _$MyErrorCopyWith(_MyError value, $Res Function(_MyError) _then) =
      __$MyErrorCopyWithImpl;
  @override
  @useResult
  $Res call({ErrorType type, String message});
}

/// @nodoc
class __$MyErrorCopyWithImpl<$Res> implements _$MyErrorCopyWith<$Res> {
  __$MyErrorCopyWithImpl(this._self, this._then);

  final _MyError _self;
  final $Res Function(_MyError) _then;

  /// Create a copy of MyError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? message = null,
  }) {
    return _then(_MyError(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ErrorType,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
