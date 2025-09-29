// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) => _ChatRoom(
  roomId: json['roomId'] as String,
  roomName: json['roomName'] as String,
  creator: json['creator'] as String,
  participants: (json['participants'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  lastMessage: LastMessage.fromJson(
    json['lastMessage'] as Map<String, dynamic>,
  ),
  thumbnailImage: json['thumbnailImage'] as String,
);

Map<String, dynamic> _$ChatRoomToJson(_ChatRoom instance) => <String, dynamic>{
  'roomId': instance.roomId,
  'roomName': instance.roomName,
  'creator': instance.creator,
  'participants': instance.participants,
  'createdAt': instance.createdAt.toIso8601String(),
  'lastMessage': instance.lastMessage,
  'thumbnailImage': instance.thumbnailImage,
};
