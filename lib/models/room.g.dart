// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
      roomId: json['roomId'] as String,
      roomName: json['roomName'] as String,
      creator: json['creator'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] as String,
      thumbnailImage: json['thumbnailImage'] as String?,
      lastMessage: json['lastMessage'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'roomName': instance.roomName,
      'creator': instance.creator,
      'participants': instance.participants,
      'createdAt': instance.createdAt,
      'thumbnailImage': instance.thumbnailImage,
      'lastMessage': instance.lastMessage,
    };
