// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting_room_list_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MeetingRoomListResponseEntity _$MeetingRoomListResponseEntityFromJson(
    Map<String, dynamic> json) {
  return _MeetingRoomListResponseEntity.fromJson(json);
}

/// @nodoc
mixin _$MeetingRoomListResponseEntity {
  List<MeetingRoomEntity> get meetingRooms =>
      throw _privateConstructorUsedError;

  /// Serializes this MeetingRoomListResponseEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MeetingRoomListResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeetingRoomListResponseEntityCopyWith<MeetingRoomListResponseEntity>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeetingRoomListResponseEntityCopyWith<$Res> {
  factory $MeetingRoomListResponseEntityCopyWith(
          MeetingRoomListResponseEntity value,
          $Res Function(MeetingRoomListResponseEntity) then) =
      _$MeetingRoomListResponseEntityCopyWithImpl<$Res,
          MeetingRoomListResponseEntity>;
  @useResult
  $Res call({List<MeetingRoomEntity> meetingRooms});
}

/// @nodoc
class _$MeetingRoomListResponseEntityCopyWithImpl<$Res,
        $Val extends MeetingRoomListResponseEntity>
    implements $MeetingRoomListResponseEntityCopyWith<$Res> {
  _$MeetingRoomListResponseEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MeetingRoomListResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetingRooms = null,
  }) {
    return _then(_value.copyWith(
      meetingRooms: null == meetingRooms
          ? _value.meetingRooms
          : meetingRooms // ignore: cast_nullable_to_non_nullable
              as List<MeetingRoomEntity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MeetingRoomListResponseEntityImplCopyWith<$Res>
    implements $MeetingRoomListResponseEntityCopyWith<$Res> {
  factory _$$MeetingRoomListResponseEntityImplCopyWith(
          _$MeetingRoomListResponseEntityImpl value,
          $Res Function(_$MeetingRoomListResponseEntityImpl) then) =
      __$$MeetingRoomListResponseEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<MeetingRoomEntity> meetingRooms});
}

/// @nodoc
class __$$MeetingRoomListResponseEntityImplCopyWithImpl<$Res>
    extends _$MeetingRoomListResponseEntityCopyWithImpl<$Res,
        _$MeetingRoomListResponseEntityImpl>
    implements _$$MeetingRoomListResponseEntityImplCopyWith<$Res> {
  __$$MeetingRoomListResponseEntityImplCopyWithImpl(
      _$MeetingRoomListResponseEntityImpl _value,
      $Res Function(_$MeetingRoomListResponseEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of MeetingRoomListResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetingRooms = null,
  }) {
    return _then(_$MeetingRoomListResponseEntityImpl(
      meetingRooms: null == meetingRooms
          ? _value._meetingRooms
          : meetingRooms // ignore: cast_nullable_to_non_nullable
              as List<MeetingRoomEntity>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MeetingRoomListResponseEntityImpl
    implements _MeetingRoomListResponseEntity {
  const _$MeetingRoomListResponseEntityImpl(
      {required final List<MeetingRoomEntity> meetingRooms})
      : _meetingRooms = meetingRooms;

  factory _$MeetingRoomListResponseEntityImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$MeetingRoomListResponseEntityImplFromJson(json);

  final List<MeetingRoomEntity> _meetingRooms;
  @override
  List<MeetingRoomEntity> get meetingRooms {
    if (_meetingRooms is EqualUnmodifiableListView) return _meetingRooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_meetingRooms);
  }

  @override
  String toString() {
    return 'MeetingRoomListResponseEntity(meetingRooms: $meetingRooms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeetingRoomListResponseEntityImpl &&
            const DeepCollectionEquality()
                .equals(other._meetingRooms, _meetingRooms));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_meetingRooms));

  /// Create a copy of MeetingRoomListResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeetingRoomListResponseEntityImplCopyWith<
          _$MeetingRoomListResponseEntityImpl>
      get copyWith => __$$MeetingRoomListResponseEntityImplCopyWithImpl<
          _$MeetingRoomListResponseEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeetingRoomListResponseEntityImplToJson(
      this,
    );
  }
}

abstract class _MeetingRoomListResponseEntity
    implements MeetingRoomListResponseEntity {
  const factory _MeetingRoomListResponseEntity(
          {required final List<MeetingRoomEntity> meetingRooms}) =
      _$MeetingRoomListResponseEntityImpl;

  factory _MeetingRoomListResponseEntity.fromJson(Map<String, dynamic> json) =
      _$MeetingRoomListResponseEntityImpl.fromJson;

  @override
  List<MeetingRoomEntity> get meetingRooms;

  /// Create a copy of MeetingRoomListResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeetingRoomListResponseEntityImplCopyWith<
          _$MeetingRoomListResponseEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MeetingRoomEntity _$MeetingRoomEntityFromJson(Map<String, dynamic> json) {
  return _MeetingRoomEntity.fromJson(json);
}

/// @nodoc
mixin _$MeetingRoomEntity {
  String get roomId => throw _privateConstructorUsedError;
  String get roomName => throw _privateConstructorUsedError;
  String get creator => throw _privateConstructorUsedError;
  List<String> get participants => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  LastMessageEntity get lastMessage => throw _privateConstructorUsedError;
  String get thumbnailImage => throw _privateConstructorUsedError;

  /// Serializes this MeetingRoomEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MeetingRoomEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeetingRoomEntityCopyWith<MeetingRoomEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeetingRoomEntityCopyWith<$Res> {
  factory $MeetingRoomEntityCopyWith(
          MeetingRoomEntity value, $Res Function(MeetingRoomEntity) then) =
      _$MeetingRoomEntityCopyWithImpl<$Res, MeetingRoomEntity>;
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
class _$MeetingRoomEntityCopyWithImpl<$Res, $Val extends MeetingRoomEntity>
    implements $MeetingRoomEntityCopyWith<$Res> {
  _$MeetingRoomEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MeetingRoomEntity
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
    return _then(_value.copyWith(
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      roomName: null == roomName
          ? _value.roomName
          : roomName // ignore: cast_nullable_to_non_nullable
              as String,
      creator: null == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String,
      participants: null == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastMessage: null == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as LastMessageEntity,
      thumbnailImage: null == thumbnailImage
          ? _value.thumbnailImage
          : thumbnailImage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of MeetingRoomEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LastMessageEntityCopyWith<$Res> get lastMessage {
    return $LastMessageEntityCopyWith<$Res>(_value.lastMessage, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MeetingRoomEntityImplCopyWith<$Res>
    implements $MeetingRoomEntityCopyWith<$Res> {
  factory _$$MeetingRoomEntityImplCopyWith(_$MeetingRoomEntityImpl value,
          $Res Function(_$MeetingRoomEntityImpl) then) =
      __$$MeetingRoomEntityImplCopyWithImpl<$Res>;
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
class __$$MeetingRoomEntityImplCopyWithImpl<$Res>
    extends _$MeetingRoomEntityCopyWithImpl<$Res, _$MeetingRoomEntityImpl>
    implements _$$MeetingRoomEntityImplCopyWith<$Res> {
  __$$MeetingRoomEntityImplCopyWithImpl(_$MeetingRoomEntityImpl _value,
      $Res Function(_$MeetingRoomEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of MeetingRoomEntity
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
    return _then(_$MeetingRoomEntityImpl(
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      roomName: null == roomName
          ? _value.roomName
          : roomName // ignore: cast_nullable_to_non_nullable
              as String,
      creator: null == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String,
      participants: null == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastMessage: null == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as LastMessageEntity,
      thumbnailImage: null == thumbnailImage
          ? _value.thumbnailImage
          : thumbnailImage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MeetingRoomEntityImpl implements _MeetingRoomEntity {
  const _$MeetingRoomEntityImpl(
      {required this.roomId,
      required this.roomName,
      required this.creator,
      required final List<String> participants,
      required this.createdAt,
      required this.lastMessage,
      required this.thumbnailImage})
      : _participants = participants;

  factory _$MeetingRoomEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeetingRoomEntityImplFromJson(json);

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

  @override
  String toString() {
    return 'MeetingRoomEntity(roomId: $roomId, roomName: $roomName, creator: $creator, participants: $participants, createdAt: $createdAt, lastMessage: $lastMessage, thumbnailImage: $thumbnailImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeetingRoomEntityImpl &&
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

  /// Create a copy of MeetingRoomEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeetingRoomEntityImplCopyWith<_$MeetingRoomEntityImpl> get copyWith =>
      __$$MeetingRoomEntityImplCopyWithImpl<_$MeetingRoomEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeetingRoomEntityImplToJson(
      this,
    );
  }
}

abstract class _MeetingRoomEntity implements MeetingRoomEntity {
  const factory _MeetingRoomEntity(
      {required final String roomId,
      required final String roomName,
      required final String creator,
      required final List<String> participants,
      required final DateTime createdAt,
      required final LastMessageEntity lastMessage,
      required final String thumbnailImage}) = _$MeetingRoomEntityImpl;

  factory _MeetingRoomEntity.fromJson(Map<String, dynamic> json) =
      _$MeetingRoomEntityImpl.fromJson;

  @override
  String get roomId;
  @override
  String get roomName;
  @override
  String get creator;
  @override
  List<String> get participants;
  @override
  DateTime get createdAt;
  @override
  LastMessageEntity get lastMessage;
  @override
  String get thumbnailImage;

  /// Create a copy of MeetingRoomEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeetingRoomEntityImplCopyWith<_$MeetingRoomEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LastMessageEntity _$LastMessageEntityFromJson(Map<String, dynamic> json) {
  return _LastMessageEntity.fromJson(json);
}

/// @nodoc
mixin _$LastMessageEntity {
  String get sender => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this LastMessageEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LastMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LastMessageEntityCopyWith<LastMessageEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LastMessageEntityCopyWith<$Res> {
  factory $LastMessageEntityCopyWith(
          LastMessageEntity value, $Res Function(LastMessageEntity) then) =
      _$LastMessageEntityCopyWithImpl<$Res, LastMessageEntity>;
  @useResult
  $Res call({String sender, String content, DateTime timestamp});
}

/// @nodoc
class _$LastMessageEntityCopyWithImpl<$Res, $Val extends LastMessageEntity>
    implements $LastMessageEntityCopyWith<$Res> {
  _$LastMessageEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LastMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sender = null,
    Object? content = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LastMessageEntityImplCopyWith<$Res>
    implements $LastMessageEntityCopyWith<$Res> {
  factory _$$LastMessageEntityImplCopyWith(_$LastMessageEntityImpl value,
          $Res Function(_$LastMessageEntityImpl) then) =
      __$$LastMessageEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String sender, String content, DateTime timestamp});
}

/// @nodoc
class __$$LastMessageEntityImplCopyWithImpl<$Res>
    extends _$LastMessageEntityCopyWithImpl<$Res, _$LastMessageEntityImpl>
    implements _$$LastMessageEntityImplCopyWith<$Res> {
  __$$LastMessageEntityImplCopyWithImpl(_$LastMessageEntityImpl _value,
      $Res Function(_$LastMessageEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of LastMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sender = null,
    Object? content = null,
    Object? timestamp = null,
  }) {
    return _then(_$LastMessageEntityImpl(
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LastMessageEntityImpl implements _LastMessageEntity {
  const _$LastMessageEntityImpl(
      {required this.sender, required this.content, required this.timestamp});

  factory _$LastMessageEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$LastMessageEntityImplFromJson(json);

  @override
  final String sender;
  @override
  final String content;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'LastMessageEntity(sender: $sender, content: $content, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LastMessageEntityImpl &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sender, content, timestamp);

  /// Create a copy of LastMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LastMessageEntityImplCopyWith<_$LastMessageEntityImpl> get copyWith =>
      __$$LastMessageEntityImplCopyWithImpl<_$LastMessageEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LastMessageEntityImplToJson(
      this,
    );
  }
}

abstract class _LastMessageEntity implements LastMessageEntity {
  const factory _LastMessageEntity(
      {required final String sender,
      required final String content,
      required final DateTime timestamp}) = _$LastMessageEntityImpl;

  factory _LastMessageEntity.fromJson(Map<String, dynamic> json) =
      _$LastMessageEntityImpl.fromJson;

  @override
  String get sender;
  @override
  String get content;
  @override
  DateTime get timestamp;

  /// Create a copy of LastMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LastMessageEntityImplCopyWith<_$LastMessageEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
