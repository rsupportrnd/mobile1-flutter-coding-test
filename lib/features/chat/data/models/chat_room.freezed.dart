// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatRoom {

 String get roomId; String get roomName; String get creator; List<String> get participants; DateTime get createdAt; LastMessage get lastMessage; String get thumbnailImage;
/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatRoomCopyWith<ChatRoom> get copyWith => _$ChatRoomCopyWithImpl<ChatRoom>(this as ChatRoom, _$identity);

  /// Serializes this ChatRoom to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatRoom&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.roomName, roomName) || other.roomName == roomName)&&(identical(other.creator, creator) || other.creator == creator)&&const DeepCollectionEquality().equals(other.participants, participants)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.thumbnailImage, thumbnailImage) || other.thumbnailImage == thumbnailImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,roomId,roomName,creator,const DeepCollectionEquality().hash(participants),createdAt,lastMessage,thumbnailImage);

@override
String toString() {
  return 'ChatRoom(roomId: $roomId, roomName: $roomName, creator: $creator, participants: $participants, createdAt: $createdAt, lastMessage: $lastMessage, thumbnailImage: $thumbnailImage)';
}


}

/// @nodoc
abstract mixin class $ChatRoomCopyWith<$Res>  {
  factory $ChatRoomCopyWith(ChatRoom value, $Res Function(ChatRoom) _then) = _$ChatRoomCopyWithImpl;
@useResult
$Res call({
 String roomId, String roomName, String creator, List<String> participants, DateTime createdAt, LastMessage lastMessage, String thumbnailImage
});


$LastMessageCopyWith<$Res> get lastMessage;

}
/// @nodoc
class _$ChatRoomCopyWithImpl<$Res>
    implements $ChatRoomCopyWith<$Res> {
  _$ChatRoomCopyWithImpl(this._self, this._then);

  final ChatRoom _self;
  final $Res Function(ChatRoom) _then;

/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roomId = null,Object? roomName = null,Object? creator = null,Object? participants = null,Object? createdAt = null,Object? lastMessage = null,Object? thumbnailImage = null,}) {
  return _then(_self.copyWith(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,roomName: null == roomName ? _self.roomName : roomName // ignore: cast_nullable_to_non_nullable
as String,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as String,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as LastMessage,thumbnailImage: null == thumbnailImage ? _self.thumbnailImage : thumbnailImage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LastMessageCopyWith<$Res> get lastMessage {
  
  return $LastMessageCopyWith<$Res>(_self.lastMessage, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatRoom].
extension ChatRoomPatterns on ChatRoom {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatRoom value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatRoom() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatRoom value)  $default,){
final _that = this;
switch (_that) {
case _ChatRoom():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatRoom value)?  $default,){
final _that = this;
switch (_that) {
case _ChatRoom() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String roomId,  String roomName,  String creator,  List<String> participants,  DateTime createdAt,  LastMessage lastMessage,  String thumbnailImage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatRoom() when $default != null:
return $default(_that.roomId,_that.roomName,_that.creator,_that.participants,_that.createdAt,_that.lastMessage,_that.thumbnailImage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String roomId,  String roomName,  String creator,  List<String> participants,  DateTime createdAt,  LastMessage lastMessage,  String thumbnailImage)  $default,) {final _that = this;
switch (_that) {
case _ChatRoom():
return $default(_that.roomId,_that.roomName,_that.creator,_that.participants,_that.createdAt,_that.lastMessage,_that.thumbnailImage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String roomId,  String roomName,  String creator,  List<String> participants,  DateTime createdAt,  LastMessage lastMessage,  String thumbnailImage)?  $default,) {final _that = this;
switch (_that) {
case _ChatRoom() when $default != null:
return $default(_that.roomId,_that.roomName,_that.creator,_that.participants,_that.createdAt,_that.lastMessage,_that.thumbnailImage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatRoom implements ChatRoom {
  const _ChatRoom({required this.roomId, required this.roomName, required this.creator, required final  List<String> participants, required this.createdAt, required this.lastMessage, required this.thumbnailImage}): _participants = participants;
  factory _ChatRoom.fromJson(Map<String, dynamic> json) => _$ChatRoomFromJson(json);

@override final  String roomId;
@override final  String roomName;
@override final  String creator;
 final  List<String> _participants;
@override List<String> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

@override final  DateTime createdAt;
@override final  LastMessage lastMessage;
@override final  String thumbnailImage;

/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatRoomCopyWith<_ChatRoom> get copyWith => __$ChatRoomCopyWithImpl<_ChatRoom>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatRoomToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatRoom&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.roomName, roomName) || other.roomName == roomName)&&(identical(other.creator, creator) || other.creator == creator)&&const DeepCollectionEquality().equals(other._participants, _participants)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.thumbnailImage, thumbnailImage) || other.thumbnailImage == thumbnailImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,roomId,roomName,creator,const DeepCollectionEquality().hash(_participants),createdAt,lastMessage,thumbnailImage);

@override
String toString() {
  return 'ChatRoom(roomId: $roomId, roomName: $roomName, creator: $creator, participants: $participants, createdAt: $createdAt, lastMessage: $lastMessage, thumbnailImage: $thumbnailImage)';
}


}

/// @nodoc
abstract mixin class _$ChatRoomCopyWith<$Res> implements $ChatRoomCopyWith<$Res> {
  factory _$ChatRoomCopyWith(_ChatRoom value, $Res Function(_ChatRoom) _then) = __$ChatRoomCopyWithImpl;
@override @useResult
$Res call({
 String roomId, String roomName, String creator, List<String> participants, DateTime createdAt, LastMessage lastMessage, String thumbnailImage
});


@override $LastMessageCopyWith<$Res> get lastMessage;

}
/// @nodoc
class __$ChatRoomCopyWithImpl<$Res>
    implements _$ChatRoomCopyWith<$Res> {
  __$ChatRoomCopyWithImpl(this._self, this._then);

  final _ChatRoom _self;
  final $Res Function(_ChatRoom) _then;

/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roomId = null,Object? roomName = null,Object? creator = null,Object? participants = null,Object? createdAt = null,Object? lastMessage = null,Object? thumbnailImage = null,}) {
  return _then(_ChatRoom(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,roomName: null == roomName ? _self.roomName : roomName // ignore: cast_nullable_to_non_nullable
as String,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as String,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as LastMessage,thumbnailImage: null == thumbnailImage ? _self.thumbnailImage : thumbnailImage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LastMessageCopyWith<$Res> get lastMessage {
  
  return $LastMessageCopyWith<$Res>(_self.lastMessage, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}

// dart format on
