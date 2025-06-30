// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UsersResponse {
  List<UserModel> get users;

  /// Create a copy of UsersResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UsersResponseCopyWith<UsersResponse> get copyWith =>
      _$UsersResponseCopyWithImpl<UsersResponse>(
          this as UsersResponse, _$identity);

  /// Serializes this UsersResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UsersResponse &&
            const DeepCollectionEquality().equals(other.users, users));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(users));

  @override
  String toString() {
    return 'UsersResponse(users: $users)';
  }
}

/// @nodoc
abstract mixin class $UsersResponseCopyWith<$Res> {
  factory $UsersResponseCopyWith(
          UsersResponse value, $Res Function(UsersResponse) _then) =
      _$UsersResponseCopyWithImpl;
  @useResult
  $Res call({List<UserModel> users});
}

/// @nodoc
class _$UsersResponseCopyWithImpl<$Res>
    implements $UsersResponseCopyWith<$Res> {
  _$UsersResponseCopyWithImpl(this._self, this._then);

  final UsersResponse _self;
  final $Res Function(UsersResponse) _then;

  /// Create a copy of UsersResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
  }) {
    return _then(_self.copyWith(
      users: null == users
          ? _self.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UsersResponse implements UsersResponse {
  const _UsersResponse({required final List<UserModel> users}) : _users = users;
  factory _UsersResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersResponseFromJson(json);

  final List<UserModel> _users;
  @override
  List<UserModel> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  /// Create a copy of UsersResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UsersResponseCopyWith<_UsersResponse> get copyWith =>
      __$UsersResponseCopyWithImpl<_UsersResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UsersResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UsersResponse &&
            const DeepCollectionEquality().equals(other._users, _users));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_users));

  @override
  String toString() {
    return 'UsersResponse(users: $users)';
  }
}

/// @nodoc
abstract mixin class _$UsersResponseCopyWith<$Res>
    implements $UsersResponseCopyWith<$Res> {
  factory _$UsersResponseCopyWith(
          _UsersResponse value, $Res Function(_UsersResponse) _then) =
      __$UsersResponseCopyWithImpl;
  @override
  @useResult
  $Res call({List<UserModel> users});
}

/// @nodoc
class __$UsersResponseCopyWithImpl<$Res>
    implements _$UsersResponseCopyWith<$Res> {
  __$UsersResponseCopyWithImpl(this._self, this._then);

  final _UsersResponse _self;
  final $Res Function(_UsersResponse) _then;

  /// Create a copy of UsersResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? users = null,
  }) {
    return _then(_UsersResponse(
      users: null == users
          ? _self._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
    ));
  }
}

/// @nodoc
mixin _$ChatRoomResponse {
  List<ChatRoomModel> get chatRooms;

  /// Create a copy of ChatRoomResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatRoomResponseCopyWith<ChatRoomResponse> get copyWith =>
      _$ChatRoomResponseCopyWithImpl<ChatRoomResponse>(
          this as ChatRoomResponse, _$identity);

  /// Serializes this ChatRoomResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatRoomResponse &&
            const DeepCollectionEquality().equals(other.chatRooms, chatRooms));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(chatRooms));

  @override
  String toString() {
    return 'ChatRoomResponse(chatRooms: $chatRooms)';
  }
}

/// @nodoc
abstract mixin class $ChatRoomResponseCopyWith<$Res> {
  factory $ChatRoomResponseCopyWith(
          ChatRoomResponse value, $Res Function(ChatRoomResponse) _then) =
      _$ChatRoomResponseCopyWithImpl;
  @useResult
  $Res call({List<ChatRoomModel> chatRooms});
}

/// @nodoc
class _$ChatRoomResponseCopyWithImpl<$Res>
    implements $ChatRoomResponseCopyWith<$Res> {
  _$ChatRoomResponseCopyWithImpl(this._self, this._then);

  final ChatRoomResponse _self;
  final $Res Function(ChatRoomResponse) _then;

  /// Create a copy of ChatRoomResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatRooms = null,
  }) {
    return _then(_self.copyWith(
      chatRooms: null == chatRooms
          ? _self.chatRooms
          : chatRooms // ignore: cast_nullable_to_non_nullable
              as List<ChatRoomModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ChatRoomResponse implements ChatRoomResponse {
  const _ChatRoomResponse({required final List<ChatRoomModel> chatRooms})
      : _chatRooms = chatRooms;
  factory _ChatRoomResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomResponseFromJson(json);

  final List<ChatRoomModel> _chatRooms;
  @override
  List<ChatRoomModel> get chatRooms {
    if (_chatRooms is EqualUnmodifiableListView) return _chatRooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chatRooms);
  }

  /// Create a copy of ChatRoomResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChatRoomResponseCopyWith<_ChatRoomResponse> get copyWith =>
      __$ChatRoomResponseCopyWithImpl<_ChatRoomResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChatRoomResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChatRoomResponse &&
            const DeepCollectionEquality()
                .equals(other._chatRooms, _chatRooms));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_chatRooms));

  @override
  String toString() {
    return 'ChatRoomResponse(chatRooms: $chatRooms)';
  }
}

/// @nodoc
abstract mixin class _$ChatRoomResponseCopyWith<$Res>
    implements $ChatRoomResponseCopyWith<$Res> {
  factory _$ChatRoomResponseCopyWith(
          _ChatRoomResponse value, $Res Function(_ChatRoomResponse) _then) =
      __$ChatRoomResponseCopyWithImpl;
  @override
  @useResult
  $Res call({List<ChatRoomModel> chatRooms});
}

/// @nodoc
class __$ChatRoomResponseCopyWithImpl<$Res>
    implements _$ChatRoomResponseCopyWith<$Res> {
  __$ChatRoomResponseCopyWithImpl(this._self, this._then);

  final _ChatRoomResponse _self;
  final $Res Function(_ChatRoomResponse) _then;

  /// Create a copy of ChatRoomResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? chatRooms = null,
  }) {
    return _then(_ChatRoomResponse(
      chatRooms: null == chatRooms
          ? _self._chatRooms
          : chatRooms // ignore: cast_nullable_to_non_nullable
              as List<ChatRoomModel>,
    ));
  }
}

/// @nodoc
mixin _$MessageResponse {
  List<MessageModel> get messages;

  /// Create a copy of MessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageResponseCopyWith<MessageResponse> get copyWith =>
      _$MessageResponseCopyWithImpl<MessageResponse>(
          this as MessageResponse, _$identity);

  /// Serializes this MessageResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageResponse &&
            const DeepCollectionEquality().equals(other.messages, messages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(messages));

  @override
  String toString() {
    return 'MessageResponse(messages: $messages)';
  }
}

/// @nodoc
abstract mixin class $MessageResponseCopyWith<$Res> {
  factory $MessageResponseCopyWith(
          MessageResponse value, $Res Function(MessageResponse) _then) =
      _$MessageResponseCopyWithImpl;
  @useResult
  $Res call({List<MessageModel> messages});
}

/// @nodoc
class _$MessageResponseCopyWithImpl<$Res>
    implements $MessageResponseCopyWith<$Res> {
  _$MessageResponseCopyWithImpl(this._self, this._then);

  final MessageResponse _self;
  final $Res Function(MessageResponse) _then;

  /// Create a copy of MessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
  }) {
    return _then(_self.copyWith(
      messages: null == messages
          ? _self.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _MessageResponse implements MessageResponse {
  const _MessageResponse({required final List<MessageModel> messages})
      : _messages = messages;
  factory _MessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseFromJson(json);

  final List<MessageModel> _messages;
  @override
  List<MessageModel> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  /// Create a copy of MessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageResponseCopyWith<_MessageResponse> get copyWith =>
      __$MessageResponseCopyWithImpl<_MessageResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageResponse &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_messages));

  @override
  String toString() {
    return 'MessageResponse(messages: $messages)';
  }
}

/// @nodoc
abstract mixin class _$MessageResponseCopyWith<$Res>
    implements $MessageResponseCopyWith<$Res> {
  factory _$MessageResponseCopyWith(
          _MessageResponse value, $Res Function(_MessageResponse) _then) =
      __$MessageResponseCopyWithImpl;
  @override
  @useResult
  $Res call({List<MessageModel> messages});
}

/// @nodoc
class __$MessageResponseCopyWithImpl<$Res>
    implements _$MessageResponseCopyWith<$Res> {
  __$MessageResponseCopyWithImpl(this._self, this._then);

  final _MessageResponse _self;
  final $Res Function(_MessageResponse) _then;

  /// Create a copy of MessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? messages = null,
  }) {
    return _then(_MessageResponse(
      messages: null == messages
          ? _self._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageModel>,
    ));
  }
}

// dart format on
