// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageEntity {
  String get roomId;
  String get messageId;
  String get sender;
  String get content;
  DateTime get timestamp;

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageEntityCopyWith<MessageEntity> get copyWith =>
      _$MessageEntityCopyWithImpl<MessageEntity>(
          this as MessageEntity, _$identity);

  /// Serializes this MessageEntity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageEntity &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, roomId, messageId, sender, content, timestamp);

  @override
  String toString() {
    return 'MessageEntity(roomId: $roomId, messageId: $messageId, sender: $sender, content: $content, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $MessageEntityCopyWith<$Res> {
  factory $MessageEntityCopyWith(
          MessageEntity value, $Res Function(MessageEntity) _then) =
      _$MessageEntityCopyWithImpl;
  @useResult
  $Res call(
      {String roomId,
      String messageId,
      String sender,
      String content,
      DateTime timestamp});
}

/// @nodoc
class _$MessageEntityCopyWithImpl<$Res>
    implements $MessageEntityCopyWith<$Res> {
  _$MessageEntityCopyWithImpl(this._self, this._then);

  final MessageEntity _self;
  final $Res Function(MessageEntity) _then;

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomId = null,
    Object? messageId = null,
    Object? sender = null,
    Object? content = null,
    Object? timestamp = null,
  }) {
    return _then(_self.copyWith(
      roomId: null == roomId
          ? _self.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      messageId: null == messageId
          ? _self.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
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
class _MessageEntity implements MessageEntity {
  const _MessageEntity(
      {required this.roomId,
      required this.messageId,
      required this.sender,
      required this.content,
      required this.timestamp});
  factory _MessageEntity.fromJson(Map<String, dynamic> json) =>
      _$MessageEntityFromJson(json);

  @override
  final String roomId;
  @override
  final String messageId;
  @override
  final String sender;
  @override
  final String content;
  @override
  final DateTime timestamp;

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageEntityCopyWith<_MessageEntity> get copyWith =>
      __$MessageEntityCopyWithImpl<_MessageEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageEntityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageEntity &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, roomId, messageId, sender, content, timestamp);

  @override
  String toString() {
    return 'MessageEntity(roomId: $roomId, messageId: $messageId, sender: $sender, content: $content, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$MessageEntityCopyWith<$Res>
    implements $MessageEntityCopyWith<$Res> {
  factory _$MessageEntityCopyWith(
          _MessageEntity value, $Res Function(_MessageEntity) _then) =
      __$MessageEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String roomId,
      String messageId,
      String sender,
      String content,
      DateTime timestamp});
}

/// @nodoc
class __$MessageEntityCopyWithImpl<$Res>
    implements _$MessageEntityCopyWith<$Res> {
  __$MessageEntityCopyWithImpl(this._self, this._then);

  final _MessageEntity _self;
  final $Res Function(_MessageEntity) _then;

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? roomId = null,
    Object? messageId = null,
    Object? sender = null,
    Object? content = null,
    Object? timestamp = null,
  }) {
    return _then(_MessageEntity(
      roomId: null == roomId
          ? _self.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      messageId: null == messageId
          ? _self.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
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
