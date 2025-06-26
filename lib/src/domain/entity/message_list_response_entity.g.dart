// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_list_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageListResponseEntityImpl _$$MessageListResponseEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$MessageListResponseEntityImpl(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => MessageEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MessageListResponseEntityImplToJson(
        _$MessageListResponseEntityImpl instance) =>
    <String, dynamic>{
      'messages': instance.messages,
    };

_$MessageEntityImpl _$$MessageEntityImplFromJson(Map<String, dynamic> json) =>
    _$MessageEntityImpl(
      roomId: json['roomId'] as String,
      messageId: json['messageId'] as String,
      sender: json['sender'] as String,
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$MessageEntityImplToJson(_$MessageEntityImpl instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'messageId': instance.messageId,
      'sender': instance.sender,
      'content': instance.content,
      'timestamp': instance.timestamp.toIso8601String(),
    };
