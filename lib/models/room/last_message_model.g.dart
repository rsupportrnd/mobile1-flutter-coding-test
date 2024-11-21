// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LastMessageModelImpl _$$LastMessageModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LastMessageModelImpl(
      sender: json['sender'] as String,
      content: json['content'] as String,
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$$LastMessageModelImplToJson(
        _$LastMessageModelImpl instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'content': instance.content,
      'timestamp': instance.timestamp,
    };
