// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomModelImpl _$$RoomModelImplFromJson(Map<String, dynamic> json) =>
    _$RoomModelImpl(
      roomId: json['roomId'] as String,
      roomName: json['roomName'] as String,
      creator: json['creator'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] as String,
      lastMessage: LastMessageModel.fromJson(
          json['lastMessage'] as Map<String, dynamic>),
      thumbnailImage: json['thumbnailImage'] as String,
    );

Map<String, dynamic> _$$RoomModelImplToJson(_$RoomModelImpl instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'roomName': instance.roomName,
      'creator': instance.creator,
      'participants': instance.participants,
      'createdAt': instance.createdAt,
      'lastMessage': instance.lastMessage,
      'thumbnailImage': instance.thumbnailImage,
    };
