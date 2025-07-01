// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RoomEntity {
  String get roomId;
  String get roomName;
  String get creator;
  List<String> get participants;
  DateTime get createdAt;
  LastMessageEntity get lastMessage;
  String get thumbnailImage;

  /// Create a copy of RoomEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RoomEntityCopyWith<RoomEntity> get copyWith =>
      _$RoomEntityCopyWithImpl<RoomEntity>(this as RoomEntity, _$identity);

  /// Serializes this RoomEntity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RoomEntity &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.roomName, roomName) ||
                other.roomName == roomName) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            const DeepCollectionEquality()
                .equals(other.participants, participants) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.thumbnailImage, thumbnailImage) ||
                other.thumbnailImage == thumbnailImage));
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
      lastMessage,
      thumbnailImage);

  @override
  String toString() {
    return 'RoomEntity(roomId: $roomId, roomName: $roomName, creator: $creator, participants: $participants, createdAt: $createdAt, lastMessage: $lastMessage, thumbnailImage: $thumbnailImage)';
  }
}

/// @nodoc
abstract mixin class $RoomEntityCopyWith<$Res> {
  factory $RoomEntityCopyWith(
          RoomEntity value, $Res Function(RoomEntity) _then) =
      _$RoomEntityCopyWithImpl;
  @useResult
  $Res call(
      {String roomId,
      String roomName,
      String creator,
      List<String> participants,
      DateTime createdAt,
      LastMessageEntity lastMessage,
      String thumbnailImage});

  $LastMessageEntityCopyWith<$Res> get lastMessage;
}

/// @nodoc
class _$RoomEntityCopyWithImpl<$Res> implements $RoomEntityCopyWith<$Res> {
  _$RoomEntityCopyWithImpl(this._self, this._then);

  final RoomEntity _self;
  final $Res Function(RoomEntity) _then;

  /// Create a copy of RoomEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomId = null,
    Object? roomName = null,
    Object? creator = null,
    Object? participants = null,
    Object? createdAt = null,
    Object? lastMessage = null,
    Object? thumbnailImage = null,
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
              as DateTime,
      lastMessage: null == lastMessage
          ? _self.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as LastMessageEntity,
      thumbnailImage: null == thumbnailImage
          ? _self.thumbnailImage
          : thumbnailImage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of RoomEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LastMessageEntityCopyWith<$Res> get lastMessage {
    return $LastMessageEntityCopyWith<$Res>(_self.lastMessage, (value) {
      return _then(_self.copyWith(lastMessage: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _RoomEntity implements RoomEntity {
  const _RoomEntity(
      {required this.roomId,
      required this.roomName,
      required this.creator,
      required final List<String> participants,
      required this.createdAt,
      required this.lastMessage,
      required this.thumbnailImage})
      : _participants = participants;
  factory _RoomEntity.fromJson(Map<String, dynamic> json) =>
      _$RoomEntityFromJson(json);

  @override
  final String roomId;
  @override
  final String roomName;
  @override
  final String creator;
  final List<String> _participants;
  @override
  List<String> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  @override
  final DateTime createdAt;
  @override
  final LastMessageEntity lastMessage;
  @override
  final String thumbnailImage;

  /// Create a copy of RoomEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RoomEntityCopyWith<_RoomEntity> get copyWith =>
      __$RoomEntityCopyWithImpl<_RoomEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RoomEntityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RoomEntity &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.roomName, roomName) ||
                other.roomName == roomName) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.thumbnailImage, thumbnailImage) ||
                other.thumbnailImage == thumbnailImage));
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
      lastMessage,
      thumbnailImage);

  @override
  String toString() {
    return 'RoomEntity(roomId: $roomId, roomName: $roomName, creator: $creator, participants: $participants, createdAt: $createdAt, lastMessage: $lastMessage, thumbnailImage: $thumbnailImage)';
  }
}

/// @nodoc
abstract mixin class _$RoomEntityCopyWith<$Res>
    implements $RoomEntityCopyWith<$Res> {
  factory _$RoomEntityCopyWith(
          _RoomEntity value, $Res Function(_RoomEntity) _then) =
      __$RoomEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String roomId,
      String roomName,
      String creator,
      List<String> participants,
      DateTime createdAt,
      LastMessageEntity lastMessage,
      String thumbnailImage});

  @override
  $LastMessageEntityCopyWith<$Res> get lastMessage;
}

/// @nodoc
class __$RoomEntityCopyWithImpl<$Res> implements _$RoomEntityCopyWith<$Res> {
  __$RoomEntityCopyWithImpl(this._self, this._then);

  final _RoomEntity _self;
  final $Res Function(_RoomEntity) _then;

  /// Create a copy of RoomEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? roomId = null,
    Object? roomName = null,
    Object? creator = null,
    Object? participants = null,
    Object? createdAt = null,
    Object? lastMessage = null,
    Object? thumbnailImage = null,
  }) {
    return _then(_RoomEntity(
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
              as DateTime,
      lastMessage: null == lastMessage
          ? _self.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as LastMessageEntity,
      thumbnailImage: null == thumbnailImage
          ? _self.thumbnailImage
          : thumbnailImage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of RoomEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LastMessageEntityCopyWith<$Res> get lastMessage {
    return $LastMessageEntityCopyWith<$Res>(_self.lastMessage, (value) {
      return _then(_self.copyWith(lastMessage: value));
    });
  }
}

/// @nodoc
mixin _$LastMessageEntity {
  String get sender;
  String get content;
  DateTime get timestamp;

  /// Create a copy of LastMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LastMessageEntityCopyWith<LastMessageEntity> get copyWith =>
      _$LastMessageEntityCopyWithImpl<LastMessageEntity>(
          this as LastMessageEntity, _$identity);

  /// Serializes this LastMessageEntity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LastMessageEntity &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sender, content, timestamp);

  @override
  String toString() {
    return 'LastMessageEntity(sender: $sender, content: $content, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $LastMessageEntityCopyWith<$Res> {
  factory $LastMessageEntityCopyWith(
          LastMessageEntity value, $Res Function(LastMessageEntity) _then) =
      _$LastMessageEntityCopyWithImpl;
  @useResult
  $Res call({String sender, String content, DateTime timestamp});
}

/// @nodoc
class _$LastMessageEntityCopyWithImpl<$Res>
    implements $LastMessageEntityCopyWith<$Res> {
  _$LastMessageEntityCopyWithImpl(this._self, this._then);

  final LastMessageEntity _self;
  final $Res Function(LastMessageEntity) _then;

  /// Create a copy of LastMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sender = null,
    Object? content = null,
    Object? timestamp = null,
  }) {
    return _then(_self.copyWith(
      sender: null == sender
          ? _self.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _LastMessageEntity implements LastMessageEntity {
  const _LastMessageEntity(
      {required this.sender, required this.content, required this.timestamp});
  factory _LastMessageEntity.fromJson(Map<String, dynamic> json) =>
      _$LastMessageEntityFromJson(json);

  @override
  final String sender;
  @override
  final String content;
  @override
  final DateTime timestamp;

  /// Create a copy of LastMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LastMessageEntityCopyWith<_LastMessageEntity> get copyWith =>
      __$LastMessageEntityCopyWithImpl<_LastMessageEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LastMessageEntityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LastMessageEntity &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sender, content, timestamp);

  @override
  String toString() {
    return 'LastMessageEntity(sender: $sender, content: $content, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$LastMessageEntityCopyWith<$Res>
    implements $LastMessageEntityCopyWith<$Res> {
  factory _$LastMessageEntityCopyWith(
          _LastMessageEntity value, $Res Function(_LastMessageEntity) _then) =
      __$LastMessageEntityCopyWithImpl;
  @override
  @useResult
  $Res call({String sender, String content, DateTime timestamp});
}

/// @nodoc
class __$LastMessageEntityCopyWithImpl<$Res>
    implements _$LastMessageEntityCopyWith<$Res> {
  __$LastMessageEntityCopyWithImpl(this._self, this._then);

  final _LastMessageEntity _self;
  final $Res Function(_LastMessageEntity) _then;

  /// Create a copy of LastMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? sender = null,
    Object? content = null,
    Object? timestamp = null,
  }) {
    return _then(_LastMessageEntity(
      sender: null == sender
          ? _self.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
