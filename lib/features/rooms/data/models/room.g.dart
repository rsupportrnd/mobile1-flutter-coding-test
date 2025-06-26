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
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastMessage:
          LastMessage.fromJson(json['lastMessage'] as Map<String, dynamic>),
      thumbnailImage: json['thumbnailImage'] as String,
    );

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'roomName': instance.roomName,
      'creator': instance.creator,
      'participants': instance.participants,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastMessage': instance.lastMessage,
      'thumbnailImage': instance.thumbnailImage,
    };

_$LastMessageImpl _$$LastMessageImplFromJson(Map<String, dynamic> json) =>
    _$LastMessageImpl(
      sender: json['sender'] as String,
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$LastMessageImplToJson(_$LastMessageImpl instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'content': instance.content,
      'timestamp': instance.timestamp.toIso8601String(),
    };
