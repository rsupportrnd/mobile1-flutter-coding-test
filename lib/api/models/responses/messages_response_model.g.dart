// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessagesResponseModel _$MessagesResponseModelFromJson(
        Map<String, dynamic> json) =>
    MessagesResponseModel(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MessagesResponseModelToJson(
        MessagesResponseModel instance) =>
    <String, dynamic>{
      'messages': instance.messages,
    };
