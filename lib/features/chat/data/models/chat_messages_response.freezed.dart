// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_messages_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatMessagesResponse {

 List<ChatMessage> get messages;
/// Create a copy of ChatMessagesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessagesResponseCopyWith<ChatMessagesResponse> get copyWith => _$ChatMessagesResponseCopyWithImpl<ChatMessagesResponse>(this as ChatMessagesResponse, _$identity);

  /// Serializes this ChatMessagesResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessagesResponse&&const DeepCollectionEquality().equals(other.messages, messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(messages));

@override
String toString() {
  return 'ChatMessagesResponse(messages: $messages)';
}


}

/// @nodoc
abstract mixin class $ChatMessagesResponseCopyWith<$Res>  {
  factory $ChatMessagesResponseCopyWith(ChatMessagesResponse value, $Res Function(ChatMessagesResponse) _then) = _$ChatMessagesResponseCopyWithImpl;
@useResult
$Res call({
 List<ChatMessage> messages
});




}
/// @nodoc
class _$ChatMessagesResponseCopyWithImpl<$Res>
    implements $ChatMessagesResponseCopyWith<$Res> {
  _$ChatMessagesResponseCopyWithImpl(this._self, this._then);

  final ChatMessagesResponse _self;
  final $Res Function(ChatMessagesResponse) _then;

/// Create a copy of ChatMessagesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messages = null,}) {
  return _then(_self.copyWith(
messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessagesResponse].
extension ChatMessagesResponsePatterns on ChatMessagesResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessagesResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessagesResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessagesResponse value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessagesResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessagesResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessagesResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ChatMessage> messages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessagesResponse() when $default != null:
return $default(_that.messages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ChatMessage> messages)  $default,) {final _that = this;
switch (_that) {
case _ChatMessagesResponse():
return $default(_that.messages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ChatMessage> messages)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessagesResponse() when $default != null:
return $default(_that.messages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMessagesResponse implements ChatMessagesResponse {
  const _ChatMessagesResponse({required final  List<ChatMessage> messages}): _messages = messages;
  factory _ChatMessagesResponse.fromJson(Map<String, dynamic> json) => _$ChatMessagesResponseFromJson(json);

 final  List<ChatMessage> _messages;
@override List<ChatMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of ChatMessagesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessagesResponseCopyWith<_ChatMessagesResponse> get copyWith => __$ChatMessagesResponseCopyWithImpl<_ChatMessagesResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessagesResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessagesResponse&&const DeepCollectionEquality().equals(other._messages, _messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages));

@override
String toString() {
  return 'ChatMessagesResponse(messages: $messages)';
}


}

/// @nodoc
abstract mixin class _$ChatMessagesResponseCopyWith<$Res> implements $ChatMessagesResponseCopyWith<$Res> {
  factory _$ChatMessagesResponseCopyWith(_ChatMessagesResponse value, $Res Function(_ChatMessagesResponse) _then) = __$ChatMessagesResponseCopyWithImpl;
@override @useResult
$Res call({
 List<ChatMessage> messages
});




}
/// @nodoc
class __$ChatMessagesResponseCopyWithImpl<$Res>
    implements _$ChatMessagesResponseCopyWith<$Res> {
  __$ChatMessagesResponseCopyWithImpl(this._self, this._then);

  final _ChatMessagesResponse _self;
  final $Res Function(_ChatMessagesResponse) _then;

/// Create a copy of ChatMessagesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,}) {
  return _then(_ChatMessagesResponse(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,
  ));
}


}

// dart format on
