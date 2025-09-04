// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MessageListModel _$MessageListModelFromJson(Map<String, dynamic> json) {
  return _MessageListModel.fromJson(json);
}

/// @nodoc
mixin _$MessageListModel {
  List<MessageModel> get messages => throw _privateConstructorUsedError;

  /// Serializes this MessageListModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageListModelCopyWith<MessageListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageListModelCopyWith<$Res> {
  factory $MessageListModelCopyWith(
          MessageListModel value, $Res Function(MessageListModel) then) =
      _$MessageListModelCopyWithImpl<$Res, MessageListModel>;
  @useResult
  $Res call({List<MessageModel> messages});
}

/// @nodoc
class _$MessageListModelCopyWithImpl<$Res, $Val extends MessageListModel>
    implements $MessageListModelCopyWith<$Res> {
  _$MessageListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageListModel
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
              as List<MessageModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageListModelImplCopyWith<$Res>
    implements $MessageListModelCopyWith<$Res> {
  factory _$$MessageListModelImplCopyWith(_$MessageListModelImpl value,
          $Res Function(_$MessageListModelImpl) then) =
      __$$MessageListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<MessageModel> messages});
}

/// @nodoc
class __$$MessageListModelImplCopyWithImpl<$Res>
    extends _$MessageListModelCopyWithImpl<$Res, _$MessageListModelImpl>
    implements _$$MessageListModelImplCopyWith<$Res> {
  __$$MessageListModelImplCopyWithImpl(_$MessageListModelImpl _value,
      $Res Function(_$MessageListModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageListModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
  }) {
    return _then(_$MessageListModelImpl(
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageListModelImpl implements _MessageListModel {
  _$MessageListModelImpl({required final List<MessageModel> messages})
      : _messages = messages;

  factory _$MessageListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageListModelImplFromJson(json);

  final List<MessageModel> _messages;
  @override
  List<MessageModel> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'MessageListModel(messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageListModelImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_messages));

  /// Create a copy of MessageListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageListModelImplCopyWith<_$MessageListModelImpl> get copyWith =>
      __$$MessageListModelImplCopyWithImpl<_$MessageListModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageListModelImplToJson(
      this,
    );
  }
}

abstract class _MessageListModel implements MessageListModel {
  factory _MessageListModel({required final List<MessageModel> messages}) =
      _$MessageListModelImpl;

  factory _MessageListModel.fromJson(Map<String, dynamic> json) =
      _$MessageListModelImpl.fromJson;

  @override
  List<MessageModel> get messages;

  /// Create a copy of MessageListModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageListModelImplCopyWith<_$MessageListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return _MessageModel.fromJson(json);
}

/// @nodoc
mixin _$MessageModel {
  String get roomId => throw _privateConstructorUsedError;
  String get messageId => throw _privateConstructorUsedError;
  String get sender => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;

  /// Serializes this MessageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageModelCopyWith<MessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageModelCopyWith<$Res> {
  factory $MessageModelCopyWith(
          MessageModel value, $Res Function(MessageModel) then) =
      _$MessageModelCopyWithImpl<$Res, MessageModel>;
  @useResult
  $Res call(
      {String roomId,
      String messageId,
      String sender,
      String content,
      String timestamp});
}

/// @nodoc
class _$MessageModelCopyWithImpl<$Res, $Val extends MessageModel>
    implements $MessageModelCopyWith<$Res> {
  _$MessageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageModel
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
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageModelImplCopyWith<$Res>
    implements $MessageModelCopyWith<$Res> {
  factory _$$MessageModelImplCopyWith(
          _$MessageModelImpl value, $Res Function(_$MessageModelImpl) then) =
      __$$MessageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String roomId,
      String messageId,
      String sender,
      String content,
      String timestamp});
}

/// @nodoc
class __$$MessageModelImplCopyWithImpl<$Res>
    extends _$MessageModelCopyWithImpl<$Res, _$MessageModelImpl>
    implements _$$MessageModelImplCopyWith<$Res> {
  __$$MessageModelImplCopyWithImpl(
      _$MessageModelImpl _value, $Res Function(_$MessageModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageModel
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
    return _then(_$MessageModelImpl(
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
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageModelImpl implements _MessageModel {
  _$MessageModelImpl(
      {required this.roomId,
      required this.messageId,
      required this.sender,
      required this.content,
      required this.timestamp});

  factory _$MessageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageModelImplFromJson(json);

  @override
  final String roomId;
  @override
  final String messageId;
  @override
  final String sender;
  @override
  final String content;
  @override
  final String timestamp;

  @override
  String toString() {
    return 'MessageModel(roomId: $roomId, messageId: $messageId, sender: $sender, content: $content, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageModelImpl &&
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

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageModelImplCopyWith<_$MessageModelImpl> get copyWith =>
      __$$MessageModelImplCopyWithImpl<_$MessageModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageModelImplToJson(
      this,
    );
  }
}

abstract class _MessageModel implements MessageModel {
  factory _MessageModel(
      {required final String roomId,
      required final String messageId,
      required final String sender,
      required final String content,
      required final String timestamp}) = _$MessageModelImpl;

  factory _MessageModel.fromJson(Map<String, dynamic> json) =
      _$MessageModelImpl.fromJson;

  @override
  String get roomId;
  @override
  String get messageId;
  @override
  String get sender;
  @override
  String get content;
  @override
  String get timestamp;

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageModelImplCopyWith<_$MessageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
