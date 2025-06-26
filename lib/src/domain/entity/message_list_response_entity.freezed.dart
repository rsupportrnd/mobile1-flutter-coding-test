// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_list_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MessageListResponseEntity _$MessageListResponseEntityFromJson(
    Map<String, dynamic> json) {
  return _MessageListResponseEntity.fromJson(json);
}

/// @nodoc
mixin _$MessageListResponseEntity {
  List<MessageEntity> get messages => throw _privateConstructorUsedError;

  /// Serializes this MessageListResponseEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageListResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageListResponseEntityCopyWith<MessageListResponseEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageListResponseEntityCopyWith<$Res> {
  factory $MessageListResponseEntityCopyWith(MessageListResponseEntity value,
          $Res Function(MessageListResponseEntity) then) =
      _$MessageListResponseEntityCopyWithImpl<$Res, MessageListResponseEntity>;
  @useResult
  $Res call({List<MessageEntity> messages});
}

/// @nodoc
class _$MessageListResponseEntityCopyWithImpl<$Res,
        $Val extends MessageListResponseEntity>
    implements $MessageListResponseEntityCopyWith<$Res> {
  _$MessageListResponseEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageListResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
  }) {
    return _then(_value.copyWith(
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageEntity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageListResponseEntityImplCopyWith<$Res>
    implements $MessageListResponseEntityCopyWith<$Res> {
  factory _$$MessageListResponseEntityImplCopyWith(
          _$MessageListResponseEntityImpl value,
          $Res Function(_$MessageListResponseEntityImpl) then) =
      __$$MessageListResponseEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<MessageEntity> messages});
}

/// @nodoc
class __$$MessageListResponseEntityImplCopyWithImpl<$Res>
    extends _$MessageListResponseEntityCopyWithImpl<$Res,
        _$MessageListResponseEntityImpl>
    implements _$$MessageListResponseEntityImplCopyWith<$Res> {
  __$$MessageListResponseEntityImplCopyWithImpl(
      _$MessageListResponseEntityImpl _value,
      $Res Function(_$MessageListResponseEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageListResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
  }) {
    return _then(_$MessageListResponseEntityImpl(
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageEntity>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageListResponseEntityImpl implements _MessageListResponseEntity {
  const _$MessageListResponseEntityImpl(
      {required final List<MessageEntity> messages})
      : _messages = messages;

  factory _$MessageListResponseEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageListResponseEntityImplFromJson(json);

  final List<MessageEntity> _messages;
  @override
  List<MessageEntity> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'MessageListResponseEntity(messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageListResponseEntityImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_messages));

  /// Create a copy of MessageListResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageListResponseEntityImplCopyWith<_$MessageListResponseEntityImpl>
      get copyWith => __$$MessageListResponseEntityImplCopyWithImpl<
          _$MessageListResponseEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageListResponseEntityImplToJson(
      this,
    );
  }
}

abstract class _MessageListResponseEntity implements MessageListResponseEntity {
  const factory _MessageListResponseEntity(
          {required final List<MessageEntity> messages}) =
      _$MessageListResponseEntityImpl;

  factory _MessageListResponseEntity.fromJson(Map<String, dynamic> json) =
      _$MessageListResponseEntityImpl.fromJson;

  @override
  List<MessageEntity> get messages;

  /// Create a copy of MessageListResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageListResponseEntityImplCopyWith<_$MessageListResponseEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MessageEntity _$MessageEntityFromJson(Map<String, dynamic> json) {
  return _MessageEntity.fromJson(json);
}

/// @nodoc
mixin _$MessageEntity {
  String get roomId => throw _privateConstructorUsedError;
  String get messageId => throw _privateConstructorUsedError;
  String get sender => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this MessageEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageEntityCopyWith<MessageEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageEntityCopyWith<$Res> {
  factory $MessageEntityCopyWith(
          MessageEntity value, $Res Function(MessageEntity) then) =
      _$MessageEntityCopyWithImpl<$Res, MessageEntity>;
  @useResult
  $Res call(
      {String roomId,
      String messageId,
      String sender,
      String content,
      DateTime timestamp});
}

/// @nodoc
class _$MessageEntityCopyWithImpl<$Res, $Val extends MessageEntity>
    implements $MessageEntityCopyWith<$Res> {
  _$MessageEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$MessageEntityImplCopyWith<$Res>
    implements $MessageEntityCopyWith<$Res> {
  factory _$$MessageEntityImplCopyWith(
          _$MessageEntityImpl value, $Res Function(_$MessageEntityImpl) then) =
      __$$MessageEntityImplCopyWithImpl<$Res>;
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
class __$$MessageEntityImplCopyWithImpl<$Res>
    extends _$MessageEntityCopyWithImpl<$Res, _$MessageEntityImpl>
    implements _$$MessageEntityImplCopyWith<$Res> {
  __$$MessageEntityImplCopyWithImpl(
      _$MessageEntityImpl _value, $Res Function(_$MessageEntityImpl) _then)
      : super(_value, _then);

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
    return _then(_$MessageEntityImpl(
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$MessageEntityImpl implements _MessageEntity {
  const _$MessageEntityImpl(
      {required this.roomId,
      required this.messageId,
      required this.sender,
      required this.content,
      required this.timestamp});

  factory _$MessageEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageEntityImplFromJson(json);

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

  @override
  String toString() {
    return 'MessageEntity(roomId: $roomId, messageId: $messageId, sender: $sender, content: $content, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageEntityImpl &&
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

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageEntityImplCopyWith<_$MessageEntityImpl> get copyWith =>
      __$$MessageEntityImplCopyWithImpl<_$MessageEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageEntityImplToJson(
      this,
    );
  }
}

abstract class _MessageEntity implements MessageEntity {
  const factory _MessageEntity(
      {required final String roomId,
      required final String messageId,
      required final String sender,
      required final String content,
      required final DateTime timestamp}) = _$MessageEntityImpl;

  factory _MessageEntity.fromJson(Map<String, dynamic> json) =
      _$MessageEntityImpl.fromJson;

  @override
  String get roomId;
  @override
  String get messageId;
  @override
  String get sender;
  @override
  String get content;
  @override
  DateTime get timestamp;

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageEntityImplCopyWith<_$MessageEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
