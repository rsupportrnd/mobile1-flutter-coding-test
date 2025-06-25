// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageListResponseModelImpl _$$MessageListResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MessageListResponseModelImpl(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MessageListResponseModelImplToJson(
        _$MessageListResponseModelImpl instance) =>
    <String, dynamic>{
      'messages': instance.messages,
    };

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      roomId: json['roomId'] as String,
      messageId: json['messageId'] as String,
      sender: json['sender'] as String,
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'messageId': instance.messageId,
      'sender': instance.sender,
      'content': instance.content,
      'timestamp': instance.timestamp.toIso8601String(),
    };
