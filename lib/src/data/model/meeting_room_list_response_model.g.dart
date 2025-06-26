// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_room_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MeetingRoomListResponseModelImpl _$$MeetingRoomListResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MeetingRoomListResponseModelImpl(
      meetingRooms: (json['chatRooms'] as List<dynamic>)
          .map((e) => MeetingRoomModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MeetingRoomListResponseModelImplToJson(
        _$MeetingRoomListResponseModelImpl instance) =>
    <String, dynamic>{
      'chatRooms': instance.meetingRooms,
    };

_$MeetingRoomModelImpl _$$MeetingRoomModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MeetingRoomModelImpl(
      roomId: json['roomId'] as String,
      roomName: json['roomName'] as String,
      creator: json['creator'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastMessage: LastMessageModel.fromJson(
          json['lastMessage'] as Map<String, dynamic>),
      thumbnailImage: json['thumbnailImage'] as String,
    );

Map<String, dynamic> _$$MeetingRoomModelImplToJson(
        _$MeetingRoomModelImpl instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'roomName': instance.roomName,
      'creator': instance.creator,
      'participants': instance.participants,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastMessage': instance.lastMessage,
      'thumbnailImage': instance.thumbnailImage,
    };

_$LastMessageModelImpl _$$LastMessageModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LastMessageModelImpl(
      sender: json['sender'] as String,
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$LastMessageModelImplToJson(
        _$LastMessageModelImpl instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'content': instance.content,
      'timestamp': instance.timestamp.toIso8601String(),
    };
