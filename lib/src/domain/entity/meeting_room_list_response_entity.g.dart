// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_room_list_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MeetingRoomListResponseEntityImpl
    _$$MeetingRoomListResponseEntityImplFromJson(Map<String, dynamic> json) =>
        _$MeetingRoomListResponseEntityImpl(
          meetingRooms: (json['meetingRooms'] as List<dynamic>)
              .map((e) => MeetingRoomEntity.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$MeetingRoomListResponseEntityImplToJson(
        _$MeetingRoomListResponseEntityImpl instance) =>
    <String, dynamic>{
      'meetingRooms': instance.meetingRooms,
    };

_$MeetingRoomEntityImpl _$$MeetingRoomEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$MeetingRoomEntityImpl(
      roomId: json['roomId'] as String,
      roomName: json['roomName'] as String,
      creator: json['creator'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastMessage: LastMessageEntity.fromJson(
          json['lastMessage'] as Map<String, dynamic>),
      thumbnailImage: json['thumbnailImage'] as String,
    );

Map<String, dynamic> _$$MeetingRoomEntityImplToJson(
        _$MeetingRoomEntityImpl instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'roomName': instance.roomName,
      'creator': instance.creator,
      'participants': instance.participants,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastMessage': instance.lastMessage,
      'thumbnailImage': instance.thumbnailImage,
    };

_$LastMessageEntityImpl _$$LastMessageEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$LastMessageEntityImpl(
      sender: json['sender'] as String,
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$LastMessageEntityImplToJson(
        _$LastMessageEntityImpl instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'content': instance.content,
      'timestamp': instance.timestamp.toIso8601String(),
    };
