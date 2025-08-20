// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'users_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UsersEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String userId) setCurrentUser,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String userId)? setCurrentUser,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String userId)? setCurrentUser,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_SetCurrentUser value) setCurrentUser,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_SetCurrentUser value)? setCurrentUser,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_SetCurrentUser value)? setCurrentUser,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsersEventCopyWith<$Res> {
  factory $UsersEventCopyWith(
    UsersEvent value,
    $Res Function(UsersEvent) then,
  ) = _$UsersEventCopyWithImpl<$Res, UsersEvent>;
}

/// @nodoc
class _$UsersEventCopyWithImpl<$Res, $Val extends UsersEvent>
    implements $UsersEventCopyWith<$Res> {
  _$UsersEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsersEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadImplCopyWith<$Res> {
  factory _$$LoadImplCopyWith(
    _$LoadImpl value,
    $Res Function(_$LoadImpl) then,
  ) = __$$LoadImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadImplCopyWithImpl<$Res>
    extends _$UsersEventCopyWithImpl<$Res, _$LoadImpl>
    implements _$$LoadImplCopyWith<$Res> {
  __$$LoadImplCopyWithImpl(_$LoadImpl _value, $Res Function(_$LoadImpl) _then)
    : super(_value, _then);

  /// Create a copy of UsersEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadImpl implements _Load {
  const _$LoadImpl();

  @override
  String toString() {
    return 'UsersEvent.load()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String userId) setCurrentUser,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String userId)? setCurrentUser,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String userId)? setCurrentUser,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_SetCurrentUser value) setCurrentUser,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_SetCurrentUser value)? setCurrentUser,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_SetCurrentUser value)? setCurrentUser,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _Load implements UsersEvent {
  const factory _Load() = _$LoadImpl;
}

/// @nodoc
abstract class _$$SetCurrentUserImplCopyWith<$Res> {
  factory _$$SetCurrentUserImplCopyWith(
    _$SetCurrentUserImpl value,
    $Res Function(_$SetCurrentUserImpl) then,
  ) = __$$SetCurrentUserImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$SetCurrentUserImplCopyWithImpl<$Res>
    extends _$UsersEventCopyWithImpl<$Res, _$SetCurrentUserImpl>
    implements _$$SetCurrentUserImplCopyWith<$Res> {
  __$$SetCurrentUserImplCopyWithImpl(
    _$SetCurrentUserImpl _value,
    $Res Function(_$SetCurrentUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UsersEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null}) {
    return _then(
      _$SetCurrentUserImpl(
        null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SetCurrentUserImpl implements _SetCurrentUser {
  const _$SetCurrentUserImpl(this.userId);

  @override
  final String userId;

  @override
  String toString() {
    return 'UsersEvent.setCurrentUser(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetCurrentUserImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of UsersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetCurrentUserImplCopyWith<_$SetCurrentUserImpl> get copyWith =>
      __$$SetCurrentUserImplCopyWithImpl<_$SetCurrentUserImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String userId) setCurrentUser,
  }) {
    return setCurrentUser(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String userId)? setCurrentUser,
  }) {
    return setCurrentUser?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String userId)? setCurrentUser,
    required TResult orElse(),
  }) {
    if (setCurrentUser != null) {
      return setCurrentUser(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_SetCurrentUser value) setCurrentUser,
  }) {
    return setCurrentUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_SetCurrentUser value)? setCurrentUser,
  }) {
    return setCurrentUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_SetCurrentUser value)? setCurrentUser,
    required TResult orElse(),
  }) {
    if (setCurrentUser != null) {
      return setCurrentUser(this);
    }
    return orElse();
  }
}

abstract class _SetCurrentUser implements UsersEvent {
  const factory _SetCurrentUser(final String userId) = _$SetCurrentUserImpl;

  String get userId;

  /// Create a copy of UsersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetCurrentUserImplCopyWith<_$SetCurrentUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UsersState {
  bool get loading => throw _privateConstructorUsedError;
  List<dynamic> get users => throw _privateConstructorUsedError;
  String get currentUserId => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of UsersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UsersStateCopyWith<UsersState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsersStateCopyWith<$Res> {
  factory $UsersStateCopyWith(
    UsersState value,
    $Res Function(UsersState) then,
  ) = _$UsersStateCopyWithImpl<$Res, UsersState>;
  @useResult
  $Res call({
    bool loading,
    List<dynamic> users,
    String currentUserId,
    String? error,
  });
}

/// @nodoc
class _$UsersStateCopyWithImpl<$Res, $Val extends UsersState>
    implements $UsersStateCopyWith<$Res> {
  _$UsersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? users = null,
    Object? currentUserId = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            loading: null == loading
                ? _value.loading
                : loading // ignore: cast_nullable_to_non_nullable
                      as bool,
            users: null == users
                ? _value.users
                : users // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
            currentUserId: null == currentUserId
                ? _value.currentUserId
                : currentUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UsersStateImplCopyWith<$Res>
    implements $UsersStateCopyWith<$Res> {
  factory _$$UsersStateImplCopyWith(
    _$UsersStateImpl value,
    $Res Function(_$UsersStateImpl) then,
  ) = __$$UsersStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool loading,
    List<dynamic> users,
    String currentUserId,
    String? error,
  });
}

/// @nodoc
class __$$UsersStateImplCopyWithImpl<$Res>
    extends _$UsersStateCopyWithImpl<$Res, _$UsersStateImpl>
    implements _$$UsersStateImplCopyWith<$Res> {
  __$$UsersStateImplCopyWithImpl(
    _$UsersStateImpl _value,
    $Res Function(_$UsersStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UsersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? users = null,
    Object? currentUserId = null,
    Object? error = freezed,
  }) {
    return _then(
      _$UsersStateImpl(
        loading: null == loading
            ? _value.loading
            : loading // ignore: cast_nullable_to_non_nullable
                  as bool,
        users: null == users
            ? _value._users
            : users // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
        currentUserId: null == currentUserId
            ? _value.currentUserId
            : currentUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$UsersStateImpl implements _UsersState {
  const _$UsersStateImpl({
    this.loading = false,
    final List<dynamic> users = const [],
    this.currentUserId = '',
    this.error,
  }) : _users = users;

  @override
  @JsonKey()
  final bool loading;
  final List<dynamic> _users;
  @override
  @JsonKey()
  List<dynamic> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  @JsonKey()
  final String currentUserId;
  @override
  final String? error;

  @override
  String toString() {
    return 'UsersState(loading: $loading, users: $users, currentUserId: $currentUserId, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsersStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.currentUserId, currentUserId) ||
                other.currentUserId == currentUserId) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    loading,
    const DeepCollectionEquality().hash(_users),
    currentUserId,
    error,
  );

  /// Create a copy of UsersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsersStateImplCopyWith<_$UsersStateImpl> get copyWith =>
      __$$UsersStateImplCopyWithImpl<_$UsersStateImpl>(this, _$identity);
}

abstract class _UsersState implements UsersState {
  const factory _UsersState({
    final bool loading,
    final List<dynamic> users,
    final String currentUserId,
    final String? error,
  }) = _$UsersStateImpl;

  @override
  bool get loading;
  @override
  List<dynamic> get users;
  @override
  String get currentUserId;
  @override
  String? get error;

  /// Create a copy of UsersState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsersStateImplCopyWith<_$UsersStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
