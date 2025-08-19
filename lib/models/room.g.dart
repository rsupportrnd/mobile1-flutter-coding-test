// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Room _$RoomFromJson(Map<String, dynamic> json) => _Room(
  roomId: json['roomId'] as String? ?? '111',
  roomName: json['roomName'] as String? ?? '',
  creator: json['creator'] as String? ?? '',
  participants:
      (json['participants'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  createdAt: json['createdAt'] as String? ?? '',
  thumbnailImage: json['thumbnailImage'] as String?,
  lastMessage: json['lastMessage'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$RoomToJson(_Room instance) => <String, dynamic>{
  'roomId': instance.roomId,
  'roomName': instance.roomName,
  'creator': instance.creator,
  'participants': instance.participants,
  'createdAt': instance.createdAt,
  'thumbnailImage': instance.thumbnailImage,
  'lastMessage': instance.lastMessage,
};
