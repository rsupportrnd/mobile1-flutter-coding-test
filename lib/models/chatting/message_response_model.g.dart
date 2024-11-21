// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageResponseModelImpl _$$MessageResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MessageResponseModelImpl(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MessageResponseModelImplToJson(
        _$MessageResponseModelImpl instance) =>
    <String, dynamic>{
      'messages': instance.messages,
    };
