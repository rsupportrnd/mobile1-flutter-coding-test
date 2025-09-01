// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) => RoomModel(
      roomId: json['roomId'] as String,
      roomName: json['roomName'] as String,
      creator: json['creator'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: dateTimeFromTimestamp(json['createdAt']),
      lastMessage: LastMessageModel.fromJson(
          json['lastMessage'] as Map<String, dynamic>),
      thumbnailImage: json['thumbnailImage'] as String?,
    );

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
      'roomId': instance.roomId,
      'roomName': instance.roomName,
      'creator': instance.creator,
      'participants': instance.participants,
      'createdAt': timestampToInt(instance.createdAt),
      'lastMessage': instance.lastMessage,
      'thumbnailImage': instance.thumbnailImage,
    };

LastMessageModel _$LastMessageModelFromJson(Map<String, dynamic> json) =>
    LastMessageModel(
      sender: json['sender'] as String,
      content: json['content'] as String,
      timestamp: dateTimeFromTimestamp(json['timestamp']),
    );

Map<String, dynamic> _$LastMessageModelToJson(LastMessageModel instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'content': instance.content,
      'timestamp': timestampToInt(instance.timestamp),
    };
