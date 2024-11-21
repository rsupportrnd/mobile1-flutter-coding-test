import 'package:freezed_annotation/freezed_annotation.dart';

import 'last_message_model.dart';

part 'room_model.freezed.dart';

part 'room_model.g.dart';

@freezed
abstract class RoomModel with _$RoomModel {
  const factory RoomModel({
    required String roomId,
    required String roomName,
    required String creator,
    required List<String> participants,
    required String createdAt,
    required LastMessageModel lastMessage,
    required String thumbnailImage,
  }) = _RoomModel;

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);
}
