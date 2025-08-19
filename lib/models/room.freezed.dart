// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Room {
  String get roomId;
  String get roomName;
  String get creator;
  List<String> get participants;
  String get createdAt;
  String? get thumbnailImage;
  Map<String, dynamic>? get lastMessage;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RoomCopyWith<Room> get copyWith =>
      _$RoomCopyWithImpl<Room>(this as Room, _$identity);

  /// Serializes this Room to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Room &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.roomName, roomName) ||
                other.roomName == roomName) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            const DeepCollectionEquality()
                .equals(other.participants, participants) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.thumbnailImage, thumbnailImage) ||
                other.thumbnailImage == thumbnailImage) &&
            const DeepCollectionEquality()
                .equals(other.lastMessage, lastMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      roomId,
      roomName,
      creator,
      const DeepCollectionEquality().hash(participants),
      createdAt,
      thumbnailImage,
      const DeepCollectionEquality().hash(lastMessage));

  @override
  String toString() {
    return 'Room(roomId: $roomId, roomName: $roomName, creator: $creator, participants: $participants, createdAt: $createdAt, thumbnailImage: $thumbnailImage, lastMessage: $lastMessage)';
  }
}

/// @nodoc
abstract mixin class $RoomCopyWith<$Res> {
  factory $RoomCopyWith(Room value, $Res Function(Room) _then) =
      _$RoomCopyWithImpl;
  @useResult
  $Res call(
      {String roomId,
      String roomName,
      String creator,
      List<String> participants,
      String createdAt,
      String? thumbnailImage,
      Map<String, dynamic>? lastMessage});
}

/// @nodoc
class _$RoomCopyWithImpl<$Res> implements $RoomCopyWith<$Res> {
  _$RoomCopyWithImpl(this._self, this._then);

  final Room _self;
  final $Res Function(Room) _then;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomId = null,
    Object? roomName = null,
    Object? creator = null,
    Object? participants = null,
    Object? createdAt = null,
    Object? thumbnailImage = freezed,
    Object? lastMessage = freezed,
  }) {
    return _then(_self.copyWith(
      roomId: null == roomId
          ? _self.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      roomName: null == roomName
          ? _self.roomName
          : roomName // ignore: cast_nullable_to_non_nullable
              as String,
      creator: null == creator
          ? _self.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String,
      participants: null == participants
          ? _self.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailImage: freezed == thumbnailImage
          ? _self.thumbnailImage
          : thumbnailImage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _self.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Room].
extension RoomPatterns on Room {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Room value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Room() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Room value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Room():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Room value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Room() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String roomId,
            String roomName,
            String creator,
            List<String> participants,
            String createdAt,
            String? thumbnailImage,
            Map<String, dynamic>? lastMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Room() when $default != null:
        return $default(
            _that.roomId,
            _that.roomName,
            _that.creator,
            _that.participants,
            _that.createdAt,
            _that.thumbnailImage,
            _that.lastMessage);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String roomId,
            String roomName,
            String creator,
            List<String> participants,
            String createdAt,
            String? thumbnailImage,
            Map<String, dynamic>? lastMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Room():
        return $default(
            _that.roomId,
            _that.roomName,
            _that.creator,
            _that.participants,
            _that.createdAt,
            _that.thumbnailImage,
            _that.lastMessage);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String roomId,
            String roomName,
            String creator,
            List<String> participants,
            String createdAt,
            String? thumbnailImage,
            Map<String, dynamic>? lastMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Room() when $default != null:
        return $default(
            _that.roomId,
            _that.roomName,
            _that.creator,
            _that.participants,
            _that.createdAt,
            _that.thumbnailImage,
            _that.lastMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Room implements Room {
  const _Room(
      {this.roomId = '111',
      this.roomName = '',
      this.creator = '',
      final List<String> participants = const [],
      this.createdAt = '',
      this.thumbnailImage,
      final Map<String, dynamic>? lastMessage})
      : _participants = participants,
        _lastMessage = lastMessage;
  factory _Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  @override
  @JsonKey()
  final String roomId;
  @override
  @JsonKey()
  final String roomName;
  @override
  @JsonKey()
  final String creator;
  final List<String> _participants;
  @override
  @JsonKey()
  List<String> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  @override
  @JsonKey()
  final String createdAt;
  @override
  final String? thumbnailImage;
  final Map<String, dynamic>? _lastMessage;
  @override
  Map<String, dynamic>? get lastMessage {
    final value = _lastMessage;
    if (value == null) return null;
    if (_lastMessage is EqualUnmodifiableMapView) return _lastMessage;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RoomCopyWith<_Room> get copyWith =>
      __$RoomCopyWithImpl<_Room>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RoomToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Room &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.roomName, roomName) ||
                other.roomName == roomName) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.thumbnailImage, thumbnailImage) ||
                other.thumbnailImage == thumbnailImage) &&
            const DeepCollectionEquality()
                .equals(other._lastMessage, _lastMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      roomId,
      roomName,
      creator,
      const DeepCollectionEquality().hash(_participants),
      createdAt,
      thumbnailImage,
      const DeepCollectionEquality().hash(_lastMessage));

  @override
  String toString() {
    return 'Room(roomId: $roomId, roomName: $roomName, creator: $creator, participants: $participants, createdAt: $createdAt, thumbnailImage: $thumbnailImage, lastMessage: $lastMessage)';
  }
}

/// @nodoc
abstract mixin class _$RoomCopyWith<$Res> implements $RoomCopyWith<$Res> {
  factory _$RoomCopyWith(_Room value, $Res Function(_Room) _then) =
      __$RoomCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String roomId,
      String roomName,
      String creator,
      List<String> participants,
      String createdAt,
      String? thumbnailImage,
      Map<String, dynamic>? lastMessage});
}

/// @nodoc
class __$RoomCopyWithImpl<$Res> implements _$RoomCopyWith<$Res> {
  __$RoomCopyWithImpl(this._self, this._then);

  final _Room _self;
  final $Res Function(_Room) _then;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? roomId = null,
    Object? roomName = null,
    Object? creator = null,
    Object? participants = null,
    Object? createdAt = null,
    Object? thumbnailImage = freezed,
    Object? lastMessage = freezed,
  }) {
    return _then(_Room(
      roomId: null == roomId
          ? _self.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      roomName: null == roomName
          ? _self.roomName
          : roomName // ignore: cast_nullable_to_non_nullable
              as String,
      creator: null == creator
          ? _self.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String,
      participants: null == participants
          ? _self._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailImage: freezed == thumbnailImage
          ? _self.thumbnailImage
          : thumbnailImage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _self._lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

// dart format on
