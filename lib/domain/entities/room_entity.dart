import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/data/models/room_model.dart';

part 'room_entity.freezed.dart';
part 'room_entity.g.dart';

@freezed
abstract class RoomEntity with _$RoomEntity {
  const factory RoomEntity({
    required String roomId,
    required String roomName,
    required String creator,
    required List<String> participants,
    required DateTime createdAt,
    required LastMessageEntity lastMessage,
    required String thumbnailImage,
  }) = _RoomEntity;

  factory RoomEntity.fromModel(RoomModel model) => RoomEntity(
        roomId: model.roomId,
        roomName: model.roomName,
        creator: model.creator,
        participants: model.participants,
        createdAt: model.createdAt,
        lastMessage: LastMessageEntity.fromModel(model.lastMessage),
        thumbnailImage: model.thumbnailImage,
      );
  factory RoomEntity.fromJson(Map<String, dynamic> json) => _$RoomEntityFromJson(json);
}

@freezed
abstract class LastMessageEntity with _$LastMessageEntity {
  const factory LastMessageEntity({
    required String sender,
    required String content,
    required DateTime timestamp,
  }) = _LastMessageEntity;

  factory LastMessageEntity.fromModel(LastMessageModel model) => LastMessageEntity(
        sender: model.sender,
        content: model.content,
        timestamp: model.timestamp,
      );

  factory LastMessageEntity.fromJson(Map<String, dynamic> json) =>
      _$LastMessageEntityFromJson(json);
}
