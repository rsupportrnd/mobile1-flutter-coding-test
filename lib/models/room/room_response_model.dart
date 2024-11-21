import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/models/room/room_model.dart';

part 'room_response_model.freezed.dart';

part 'room_response_model.g.dart';

@freezed
abstract class RoomResponseModel with _$RoomResponseModel {
  const factory RoomResponseModel({
    required List<RoomModel> chatRooms,
  }) = _RoomResponseModel;

  factory RoomResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RoomResponseModelFromJson(json);
}
