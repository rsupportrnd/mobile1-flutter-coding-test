// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rooms_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RoomsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String userId) setCurrentUser,
    required TResult Function(String roomId, Map<String, dynamic> lastMessage)
    updateLastMessage,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String userId)? setCurrentUser,
    TResult? Function(String roomId, Map<String, dynamic> lastMessage)?
    updateLastMessage,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String userId)? setCurrentUser,
    TResult Function(String roomId, Map<String, dynamic> lastMessage)?
    updateLastMessage,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_SetCurrentUser value) setCurrentUser,
    required TResult Function(_UpdateLastMessage value) updateLastMessage,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_SetCurrentUser value)? setCurrentUser,
    TResult? Function(_UpdateLastMessage value)? updateLastMessage,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_SetCurrentUser value)? setCurrentUser,
    TResult Function(_UpdateLastMessage value)? updateLastMessage,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomsEventCopyWith<$Res> {
  factory $RoomsEventCopyWith(
    RoomsEvent value,
    $Res Function(RoomsEvent) then,
  ) = _$RoomsEventCopyWithImpl<$Res, RoomsEvent>;
}

/// @nodoc
class _$RoomsEventCopyWithImpl<$Res, $Val extends RoomsEvent>
    implements $RoomsEventCopyWith<$Res> {
  _$RoomsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoomsEvent
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
    extends _$RoomsEventCopyWithImpl<$Res, _$LoadImpl>
    implements _$$LoadImplCopyWith<$Res> {
  __$$LoadImplCopyWithImpl(_$LoadImpl _value, $Res Function(_$LoadImpl) _then)
    : super(_value, _then);

  /// Create a copy of RoomsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadImpl implements _Load {
  const _$LoadImpl();

  @override
  String toString() {
    return 'RoomsEvent.load()';
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
    required TResult Function(String roomId, Map<String, dynamic> lastMessage)
    updateLastMessage,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String userId)? setCurrentUser,
    TResult? Function(String roomId, Map<String, dynamic> lastMessage)?
    updateLastMessage,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String userId)? setCurrentUser,
    TResult Function(String roomId, Map<String, dynamic> lastMessage)?
    updateLastMessage,
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
    required TResult Function(_UpdateLastMessage value) updateLastMessage,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_SetCurrentUser value)? setCurrentUser,
    TResult? Function(_UpdateLastMessage value)? updateLastMessage,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_SetCurrentUser value)? setCurrentUser,
    TResult Function(_UpdateLastMessage value)? updateLastMessage,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _Load implements RoomsEvent {
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
    extends _$RoomsEventCopyWithImpl<$Res, _$SetCurrentUserImpl>
    implements _$$SetCurrentUserImplCopyWith<$Res> {
  __$$SetCurrentUserImplCopyWithImpl(
    _$SetCurrentUserImpl _value,
    $Res Function(_$SetCurrentUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomsEvent
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
    return 'RoomsEvent.setCurrentUser(userId: $userId)';
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

  /// Create a copy of RoomsEvent
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
    required TResult Function(String roomId, Map<String, dynamic> lastMessage)
    updateLastMessage,
  }) {
    return setCurrentUser(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String userId)? setCurrentUser,
    TResult? Function(String roomId, Map<String, dynamic> lastMessage)?
    updateLastMessage,
  }) {
    return setCurrentUser?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String userId)? setCurrentUser,
    TResult Function(String roomId, Map<String, dynamic> lastMessage)?
    updateLastMessage,
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
    required TResult Function(_UpdateLastMessage value) updateLastMessage,
  }) {
    return setCurrentUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_SetCurrentUser value)? setCurrentUser,
    TResult? Function(_UpdateLastMessage value)? updateLastMessage,
  }) {
    return setCurrentUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_SetCurrentUser value)? setCurrentUser,
    TResult Function(_UpdateLastMessage value)? updateLastMessage,
    required TResult orElse(),
  }) {
    if (setCurrentUser != null) {
      return setCurrentUser(this);
    }
    return orElse();
  }
}

abstract class _SetCurrentUser implements RoomsEvent {
  const factory _SetCurrentUser(final String userId) = _$SetCurrentUserImpl;

  String get userId;

  /// Create a copy of RoomsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetCurrentUserImplCopyWith<_$SetCurrentUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateLastMessageImplCopyWith<$Res> {
  factory _$$UpdateLastMessageImplCopyWith(
    _$UpdateLastMessageImpl value,
    $Res Function(_$UpdateLastMessageImpl) then,
  ) = __$$UpdateLastMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String roomId, Map<String, dynamic> lastMessage});
}

/// @nodoc
class __$$UpdateLastMessageImplCopyWithImpl<$Res>
    extends _$RoomsEventCopyWithImpl<$Res, _$UpdateLastMessageImpl>
    implements _$$UpdateLastMessageImplCopyWith<$Res> {
  __$$UpdateLastMessageImplCopyWithImpl(
    _$UpdateLastMessageImpl _value,
    $Res Function(_$UpdateLastMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? roomId = null, Object? lastMessage = null}) {
    return _then(
      _$UpdateLastMessageImpl(
        null == roomId
            ? _value.roomId
            : roomId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == lastMessage
            ? _value._lastMessage
            : lastMessage // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class _$UpdateLastMessageImpl implements _UpdateLastMessage {
  const _$UpdateLastMessageImpl(
    this.roomId,
    final Map<String, dynamic> lastMessage,
  ) : _lastMessage = lastMessage;

  @override
  final String roomId;
  final Map<String, dynamic> _lastMessage;
  @override
  Map<String, dynamic> get lastMessage {
    if (_lastMessage is EqualUnmodifiableMapView) return _lastMessage;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_lastMessage);
  }

  @override
  String toString() {
    return 'RoomsEvent.updateLastMessage(roomId: $roomId, lastMessage: $lastMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateLastMessageImpl &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            const DeepCollectionEquality().equals(
              other._lastMessage,
              _lastMessage,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    roomId,
    const DeepCollectionEquality().hash(_lastMessage),
  );

  /// Create a copy of RoomsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateLastMessageImplCopyWith<_$UpdateLastMessageImpl> get copyWith =>
      __$$UpdateLastMessageImplCopyWithImpl<_$UpdateLastMessageImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String userId) setCurrentUser,
    required TResult Function(String roomId, Map<String, dynamic> lastMessage)
    updateLastMessage,
  }) {
    return updateLastMessage(roomId, lastMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String userId)? setCurrentUser,
    TResult? Function(String roomId, Map<String, dynamic> lastMessage)?
    updateLastMessage,
  }) {
    return updateLastMessage?.call(roomId, lastMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String userId)? setCurrentUser,
    TResult Function(String roomId, Map<String, dynamic> lastMessage)?
    updateLastMessage,
    required TResult orElse(),
  }) {
    if (updateLastMessage != null) {
      return updateLastMessage(roomId, lastMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_SetCurrentUser value) setCurrentUser,
    required TResult Function(_UpdateLastMessage value) updateLastMessage,
  }) {
    return updateLastMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_SetCurrentUser value)? setCurrentUser,
    TResult? Function(_UpdateLastMessage value)? updateLastMessage,
  }) {
    return updateLastMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_SetCurrentUser value)? setCurrentUser,
    TResult Function(_UpdateLastMessage value)? updateLastMessage,
    required TResult orElse(),
  }) {
    if (updateLastMessage != null) {
      return updateLastMessage(this);
    }
    return orElse();
  }
}

abstract class _UpdateLastMessage implements RoomsEvent {
  const factory _UpdateLastMessage(
    final String roomId,
    final Map<String, dynamic> lastMessage,
  ) = _$UpdateLastMessageImpl;

  String get roomId;
  Map<String, dynamic> get lastMessage;

  /// Create a copy of RoomsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateLastMessageImplCopyWith<_$UpdateLastMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RoomsState {
  bool get loading => throw _privateConstructorUsedError;
  List<Room> get rooms => throw _privateConstructorUsedError;
  String get currentUserId => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of RoomsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomsStateCopyWith<RoomsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomsStateCopyWith<$Res> {
  factory $RoomsStateCopyWith(
    RoomsState value,
    $Res Function(RoomsState) then,
  ) = _$RoomsStateCopyWithImpl<$Res, RoomsState>;
  @useResult
  $Res call({
    bool loading,
    List<Room> rooms,
    String currentUserId,
    String? error,
  });
}

/// @nodoc
class _$RoomsStateCopyWithImpl<$Res, $Val extends RoomsState>
    implements $RoomsStateCopyWith<$Res> {
  _$RoomsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoomsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? rooms = null,
    Object? currentUserId = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            loading: null == loading
                ? _value.loading
                : loading // ignore: cast_nullable_to_non_nullable
                      as bool,
            rooms: null == rooms
                ? _value.rooms
                : rooms // ignore: cast_nullable_to_non_nullable
                      as List<Room>,
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
abstract class _$$RoomsStateImplCopyWith<$Res>
    implements $RoomsStateCopyWith<$Res> {
  factory _$$RoomsStateImplCopyWith(
    _$RoomsStateImpl value,
    $Res Function(_$RoomsStateImpl) then,
  ) = __$$RoomsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool loading,
    List<Room> rooms,
    String currentUserId,
    String? error,
  });
}

/// @nodoc
class __$$RoomsStateImplCopyWithImpl<$Res>
    extends _$RoomsStateCopyWithImpl<$Res, _$RoomsStateImpl>
    implements _$$RoomsStateImplCopyWith<$Res> {
  __$$RoomsStateImplCopyWithImpl(
    _$RoomsStateImpl _value,
    $Res Function(_$RoomsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? rooms = null,
    Object? currentUserId = null,
    Object? error = freezed,
  }) {
    return _then(
      _$RoomsStateImpl(
        loading: null == loading
            ? _value.loading
            : loading // ignore: cast_nullable_to_non_nullable
                  as bool,
        rooms: null == rooms
            ? _value._rooms
            : rooms // ignore: cast_nullable_to_non_nullable
                  as List<Room>,
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

class _$RoomsStateImpl implements _RoomsState {
  const _$RoomsStateImpl({
    this.loading = false,
    final List<Room> rooms = const [],
    this.currentUserId = '',
    this.error,
  }) : _rooms = rooms;

  @override
  @JsonKey()
  final bool loading;
  final List<Room> _rooms;
  @override
  @JsonKey()
  List<Room> get rooms {
    if (_rooms is EqualUnmodifiableListView) return _rooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rooms);
  }

  @override
  @JsonKey()
  final String currentUserId;
  @override
  final String? error;

  @override
  String toString() {
    return 'RoomsState(loading: $loading, rooms: $rooms, currentUserId: $currentUserId, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomsStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            const DeepCollectionEquality().equals(other._rooms, _rooms) &&
            (identical(other.currentUserId, currentUserId) ||
                other.currentUserId == currentUserId) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    loading,
    const DeepCollectionEquality().hash(_rooms),
    currentUserId,
    error,
  );

  /// Create a copy of RoomsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomsStateImplCopyWith<_$RoomsStateImpl> get copyWith =>
      __$$RoomsStateImplCopyWithImpl<_$RoomsStateImpl>(this, _$identity);
}

abstract class _RoomsState implements RoomsState {
  const factory _RoomsState({
    final bool loading,
    final List<Room> rooms,
    final String currentUserId,
    final String? error,
  }) = _$RoomsStateImpl;

  @override
  bool get loading;
  @override
  List<Room> get rooms;
  @override
  String get currentUserId;
  @override
  String? get error;

  /// Create a copy of RoomsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomsStateImplCopyWith<_$RoomsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
