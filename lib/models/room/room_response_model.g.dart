// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomResponseModelImpl _$$RoomResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RoomResponseModelImpl(
      chatRooms: (json['chatRooms'] as List<dynamic>)
          .map((e) => RoomModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RoomResponseModelImplToJson(
        _$RoomResponseModelImpl instance) =>
    <String, dynamic>{
      'chatRooms': instance.chatRooms,
    };
