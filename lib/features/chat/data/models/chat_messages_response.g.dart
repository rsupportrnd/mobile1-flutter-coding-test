// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_messages_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatMessagesResponse _$ChatMessagesResponseFromJson(
  Map<String, dynamic> json,
) => _ChatMessagesResponse(
  messages: (json['messages'] as List<dynamic>)
      .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ChatMessagesResponseToJson(
  _ChatMessagesResponse instance,
) => <String, dynamic>{'messages': instance.messages};
