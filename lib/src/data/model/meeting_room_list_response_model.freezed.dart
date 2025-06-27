// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting_room_list_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MeetingRoomListResponseModel _$MeetingRoomListResponseModelFromJson(
    Map<String, dynamic> json) {
  return _MeetingRoomListResponseModel.fromJson(json);
}

/// @nodoc
mixin _$MeetingRoomListResponseModel {
// ignore: invalid_annotation_target
  @JsonKey(name: 'chatRooms')
  List<MeetingRoomModel> get meetingRooms => throw _privateConstructorUsedError;

  /// Serializes this MeetingRoomListResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MeetingRoomListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeetingRoomListResponseModelCopyWith<MeetingRoomListResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeetingRoomListResponseModelCopyWith<$Res> {
  factory $MeetingRoomListResponseModelCopyWith(
          MeetingRoomListResponseModel value,
          $Res Function(MeetingRoomListResponseModel) then) =
      _$MeetingRoomListResponseModelCopyWithImpl<$Res,
          MeetingRoomListResponseModel>;
  @useResult
  $Res call({@JsonKey(name: 'chatRooms') List<MeetingRoomModel> meetingRooms});
}

/// @nodoc
class _$MeetingRoomListResponseModelCopyWithImpl<$Res,
        $Val extends MeetingRoomListResponseModel>
    implements $MeetingRoomListResponseModelCopyWith<$Res> {
  _$MeetingRoomListResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MeetingRoomListResponseModel
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
              as List<MeetingRoomModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MeetingRoomListResponseModelImplCopyWith<$Res>
    implements $MeetingRoomListResponseModelCopyWith<$Res> {
  factory _$$MeetingRoomListResponseModelImplCopyWith(
          _$MeetingRoomListResponseModelImpl value,
          $Res Function(_$MeetingRoomListResponseModelImpl) then) =
      __$$MeetingRoomListResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'chatRooms') List<MeetingRoomModel> meetingRooms});
}

/// @nodoc
class __$$MeetingRoomListResponseModelImplCopyWithImpl<$Res>
    extends _$MeetingRoomListResponseModelCopyWithImpl<$Res,
        _$MeetingRoomListResponseModelImpl>
    implements _$$MeetingRoomListResponseModelImplCopyWith<$Res> {
  __$$MeetingRoomListResponseModelImplCopyWithImpl(
      _$MeetingRoomListResponseModelImpl _value,
      $Res Function(_$MeetingRoomListResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MeetingRoomListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetingRooms = null,
  }) {
    return _then(_$MeetingRoomListResponseModelImpl(
      meetingRooms: null == meetingRooms
          ? _value._meetingRooms
          : meetingRooms // ignore: cast_nullable_to_non_nullable
              as List<MeetingRoomModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MeetingRoomListResponseModelImpl
    implements _MeetingRoomListResponseModel {
  const _$MeetingRoomListResponseModelImpl(
      {@JsonKey(name: 'chatRooms')
      required final List<MeetingRoomModel> meetingRooms})
      : _meetingRooms = meetingRooms;

  factory _$MeetingRoomListResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$MeetingRoomListResponseModelImplFromJson(json);

// ignore: invalid_annotation_target
  final List<MeetingRoomModel> _meetingRooms;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'chatRooms')
  List<MeetingRoomModel> get meetingRooms {
    if (_meetingRooms is EqualUnmodifiableListView) return _meetingRooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_meetingRooms);
  }

  @override
  String toString() {
    return 'MeetingRoomListResponseModel(meetingRooms: $meetingRooms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeetingRoomListResponseModelImpl &&
            const DeepCollectionEquality()
                .equals(other._meetingRooms, _meetingRooms));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_meetingRooms));

  /// Create a copy of MeetingRoomListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeetingRoomListResponseModelImplCopyWith<
          _$MeetingRoomListResponseModelImpl>
      get copyWith => __$$MeetingRoomListResponseModelImplCopyWithImpl<
          _$MeetingRoomListResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeetingRoomListResponseModelImplToJson(
      this,
    );
  }
}

abstract class _MeetingRoomListResponseModel
    implements MeetingRoomListResponseModel {
  const factory _MeetingRoomListResponseModel(
          {@JsonKey(name: 'chatRooms')
          required final List<MeetingRoomModel> meetingRooms}) =
      _$MeetingRoomListResponseModelImpl;

  factory _MeetingRoomListResponseModel.fromJson(Map<String, dynamic> json) =
      _$MeetingRoomListResponseModelImpl.fromJson;

// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'chatRooms')
  List<MeetingRoomModel> get meetingRooms;

  /// Create a copy of MeetingRoomListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeetingRoomListResponseModelImplCopyWith<
          _$MeetingRoomListResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MeetingRoomModel _$MeetingRoomModelFromJson(Map<String, dynamic> json) {
  return _MeetingRoomModel.fromJson(json);
}

/// @nodoc
mixin _$MeetingRoomModel {
  String get roomId => throw _privateConstructorUsedError;
  String get roomName => throw _privateConstructorUsedError;
  String get creator => throw _privateConstructorUsedError;
  List<String> get participants => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  LastMessageModel get lastMessage => throw _privateConstructorUsedError;
  String get thumbnailImage => throw _privateConstructorUsedError;

  /// Serializes this MeetingRoomModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MeetingRoomModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeetingRoomModelCopyWith<MeetingRoomModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeetingRoomModelCopyWith<$Res> {
  factory $MeetingRoomModelCopyWith(
          MeetingRoomModel value, $Res Function(MeetingRoomModel) then) =
      _$MeetingRoomModelCopyWithImpl<$Res, MeetingRoomModel>;
  @useResult
  $Res call(
      {String roomId,
      String roomName,
      String creator,
      List<String> participants,
      DateTime createdAt,
      LastMessageModel lastMessage,
      String thumbnailImage});

  $LastMessageModelCopyWith<$Res> get lastMessage;
}

/// @nodoc
class _$MeetingRoomModelCopyWithImpl<$Res, $Val extends MeetingRoomModel>
    implements $MeetingRoomModelCopyWith<$Res> {
  _$MeetingRoomModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MeetingRoomModel
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
              as LastMessageModel,
      thumbnailImage: null == thumbnailImage
          ? _value.thumbnailImage
          : thumbnailImage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of MeetingRoomModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LastMessageModelCopyWith<$Res> get lastMessage {
    return $LastMessageModelCopyWith<$Res>(_value.lastMessage, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MeetingRoomModelImplCopyWith<$Res>
    implements $MeetingRoomModelCopyWith<$Res> {
  factory _$$MeetingRoomModelImplCopyWith(_$MeetingRoomModelImpl value,
          $Res Function(_$MeetingRoomModelImpl) then) =
      __$$MeetingRoomModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String roomId,
      String roomName,
      String creator,
      List<String> participants,
      DateTime createdAt,
      LastMessageModel lastMessage,
      String thumbnailImage});

  @override
  $LastMessageModelCopyWith<$Res> get lastMessage;
}

/// @nodoc
class __$$MeetingRoomModelImplCopyWithImpl<$Res>
    extends _$MeetingRoomModelCopyWithImpl<$Res, _$MeetingRoomModelImpl>
    implements _$$MeetingRoomModelImplCopyWith<$Res> {
  __$$MeetingRoomModelImplCopyWithImpl(_$MeetingRoomModelImpl _value,
      $Res Function(_$MeetingRoomModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MeetingRoomModel
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
    return _then(_$MeetingRoomModelImpl(
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
              as LastMessageModel,
      thumbnailImage: null == thumbnailImage
          ? _value.thumbnailImage
          : thumbnailImage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MeetingRoomModelImpl implements _MeetingRoomModel {
  const _$MeetingRoomModelImpl(
      {required this.roomId,
      required this.roomName,
      required this.creator,
      required final List<String> participants,
      required this.createdAt,
      required this.lastMessage,
      required this.thumbnailImage})
      : _participants = participants;

  factory _$MeetingRoomModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeetingRoomModelImplFromJson(json);

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
  final LastMessageModel lastMessage;
  @override
  final String thumbnailImage;

  @override
  String toString() {
    return 'MeetingRoomModel(roomId: $roomId, roomName: $roomName, creator: $creator, participants: $participants, createdAt: $createdAt, lastMessage: $lastMessage, thumbnailImage: $thumbnailImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeetingRoomModelImpl &&
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

  /// Create a copy of MeetingRoomModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeetingRoomModelImplCopyWith<_$MeetingRoomModelImpl> get copyWith =>
      __$$MeetingRoomModelImplCopyWithImpl<_$MeetingRoomModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeetingRoomModelImplToJson(
      this,
    );
  }
}

abstract class _MeetingRoomModel implements MeetingRoomModel {
  const factory _MeetingRoomModel(
      {required final String roomId,
      required final String roomName,
      required final String creator,
      required final List<String> participants,
      required final DateTime createdAt,
      required final LastMessageModel lastMessage,
      required final String thumbnailImage}) = _$MeetingRoomModelImpl;

  factory _MeetingRoomModel.fromJson(Map<String, dynamic> json) =
      _$MeetingRoomModelImpl.fromJson;

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
  LastMessageModel get lastMessage;
  @override
  String get thumbnailImage;

  /// Create a copy of MeetingRoomModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeetingRoomModelImplCopyWith<_$MeetingRoomModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LastMessageModel _$LastMessageModelFromJson(Map<String, dynamic> json) {
  return _LastMessageModel.fromJson(json);
}

/// @nodoc
mixin _$LastMessageModel {
  String get sender => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this LastMessageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LastMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LastMessageModelCopyWith<LastMessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LastMessageModelCopyWith<$Res> {
  factory $LastMessageModelCopyWith(
          LastMessageModel value, $Res Function(LastMessageModel) then) =
      _$LastMessageModelCopyWithImpl<$Res, LastMessageModel>;
  @useResult
  $Res call({String sender, String content, DateTime timestamp});
}

/// @nodoc
class _$LastMessageModelCopyWithImpl<$Res, $Val extends LastMessageModel>
    implements $LastMessageModelCopyWith<$Res> {
  _$LastMessageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LastMessageModel
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
abstract class _$$LastMessageModelImplCopyWith<$Res>
    implements $LastMessageModelCopyWith<$Res> {
  factory _$$LastMessageModelImplCopyWith(_$LastMessageModelImpl value,
          $Res Function(_$LastMessageModelImpl) then) =
      __$$LastMessageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String sender, String content, DateTime timestamp});
}

/// @nodoc
class __$$LastMessageModelImplCopyWithImpl<$Res>
    extends _$LastMessageModelCopyWithImpl<$Res, _$LastMessageModelImpl>
    implements _$$LastMessageModelImplCopyWith<$Res> {
  __$$LastMessageModelImplCopyWithImpl(_$LastMessageModelImpl _value,
      $Res Function(_$LastMessageModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LastMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sender = null,
    Object? content = null,
    Object? timestamp = null,
  }) {
    return _then(_$LastMessageModelImpl(
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
class _$LastMessageModelImpl implements _LastMessageModel {
  const _$LastMessageModelImpl(
      {required this.sender, required this.content, required this.timestamp});

  factory _$LastMessageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LastMessageModelImplFromJson(json);

  @override
  final String sender;
  @override
  final String content;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'LastMessageModel(sender: $sender, content: $content, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LastMessageModelImpl &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sender, content, timestamp);

  /// Create a copy of LastMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LastMessageModelImplCopyWith<_$LastMessageModelImpl> get copyWith =>
      __$$LastMessageModelImplCopyWithImpl<_$LastMessageModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LastMessageModelImplToJson(
      this,
    );
  }
}

abstract class _LastMessageModel implements LastMessageModel {
  const factory _LastMessageModel(
      {required final String sender,
      required final String content,
      required final DateTime timestamp}) = _$LastMessageModelImpl;

  factory _LastMessageModel.fromJson(Map<String, dynamic> json) =
      _$LastMessageModelImpl.fromJson;

  @override
  String get sender;
  @override
  String get content;
  @override
  DateTime get timestamp;

  /// Create a copy of LastMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LastMessageModelImplCopyWith<_$LastMessageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
