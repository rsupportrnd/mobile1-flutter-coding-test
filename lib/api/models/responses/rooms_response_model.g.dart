// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomsResponseModel _$RoomsResponseModelFromJson(Map<String, dynamic> json) =>
    RoomsResponseModel(
      chatRooms: (json['chatRooms'] as List<dynamic>)
          .map((e) => RoomModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoomsResponseModelToJson(RoomsResponseModel instance) =>
    <String, dynamic>{
      'chatRooms': instance.chatRooms,
    };
