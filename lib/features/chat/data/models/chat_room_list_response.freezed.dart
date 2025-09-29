// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_room_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatRoomListResponse {

 List<ChatRoom> get chatRooms;
/// Create a copy of ChatRoomListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatRoomListResponseCopyWith<ChatRoomListResponse> get copyWith => _$ChatRoomListResponseCopyWithImpl<ChatRoomListResponse>(this as ChatRoomListResponse, _$identity);

  /// Serializes this ChatRoomListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatRoomListResponse&&const DeepCollectionEquality().equals(other.chatRooms, chatRooms));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(chatRooms));

@override
String toString() {
  return 'ChatRoomListResponse(chatRooms: $chatRooms)';
}


}

/// @nodoc
abstract mixin class $ChatRoomListResponseCopyWith<$Res>  {
  factory $ChatRoomListResponseCopyWith(ChatRoomListResponse value, $Res Function(ChatRoomListResponse) _then) = _$ChatRoomListResponseCopyWithImpl;
@useResult
$Res call({
 List<ChatRoom> chatRooms
});




}
/// @nodoc
class _$ChatRoomListResponseCopyWithImpl<$Res>
    implements $ChatRoomListResponseCopyWith<$Res> {
  _$ChatRoomListResponseCopyWithImpl(this._self, this._then);

  final ChatRoomListResponse _self;
  final $Res Function(ChatRoomListResponse) _then;

/// Create a copy of ChatRoomListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chatRooms = null,}) {
  return _then(_self.copyWith(
chatRooms: null == chatRooms ? _self.chatRooms : chatRooms // ignore: cast_nullable_to_non_nullable
as List<ChatRoom>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatRoomListResponse].
extension ChatRoomListResponsePatterns on ChatRoomListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatRoomListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatRoomListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatRoomListResponse value)  $default,){
final _that = this;
switch (_that) {
case _ChatRoomListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatRoomListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ChatRoomListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ChatRoom> chatRooms)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatRoomListResponse() when $default != null:
return $default(_that.chatRooms);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ChatRoom> chatRooms)  $default,) {final _that = this;
switch (_that) {
case _ChatRoomListResponse():
return $default(_that.chatRooms);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ChatRoom> chatRooms)?  $default,) {final _that = this;
switch (_that) {
case _ChatRoomListResponse() when $default != null:
return $default(_that.chatRooms);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatRoomListResponse implements ChatRoomListResponse {
  const _ChatRoomListResponse({required final  List<ChatRoom> chatRooms}): _chatRooms = chatRooms;
  factory _ChatRoomListResponse.fromJson(Map<String, dynamic> json) => _$ChatRoomListResponseFromJson(json);

 final  List<ChatRoom> _chatRooms;
@override List<ChatRoom> get chatRooms {
  if (_chatRooms is EqualUnmodifiableListView) return _chatRooms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chatRooms);
}


/// Create a copy of ChatRoomListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatRoomListResponseCopyWith<_ChatRoomListResponse> get copyWith => __$ChatRoomListResponseCopyWithImpl<_ChatRoomListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatRoomListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatRoomListResponse&&const DeepCollectionEquality().equals(other._chatRooms, _chatRooms));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_chatRooms));

@override
String toString() {
  return 'ChatRoomListResponse(chatRooms: $chatRooms)';
}


}

/// @nodoc
abstract mixin class _$ChatRoomListResponseCopyWith<$Res> implements $ChatRoomListResponseCopyWith<$Res> {
  factory _$ChatRoomListResponseCopyWith(_ChatRoomListResponse value, $Res Function(_ChatRoomListResponse) _then) = __$ChatRoomListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<ChatRoom> chatRooms
});




}
/// @nodoc
class __$ChatRoomListResponseCopyWithImpl<$Res>
    implements _$ChatRoomListResponseCopyWith<$Res> {
  __$ChatRoomListResponseCopyWithImpl(this._self, this._then);

  final _ChatRoomListResponse _self;
  final $Res Function(_ChatRoomListResponse) _then;

/// Create a copy of ChatRoomListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chatRooms = null,}) {
  return _then(_ChatRoomListResponse(
chatRooms: null == chatRooms ? _self._chatRooms : chatRooms // ignore: cast_nullable_to_non_nullable
as List<ChatRoom>,
  ));
}


}

// dart format on
