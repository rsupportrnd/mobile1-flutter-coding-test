// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatRoomListResponse _$ChatRoomListResponseFromJson(
  Map<String, dynamic> json,
) => _ChatRoomListResponse(
  chatRooms: (json['chatRooms'] as List<dynamic>)
      .map((e) => ChatRoom.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ChatRoomListResponseToJson(
  _ChatRoomListResponse instance,
) => <String, dynamic>{'chatRooms': instance.chatRooms};
