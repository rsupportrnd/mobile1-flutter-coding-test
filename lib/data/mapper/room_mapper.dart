import 'package:mobile1_flutter_coding_test/data/model/room_model.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/room.dart';

extension ChatRoomModelToEntityExtension on ChatRoomModel {
  ChatRoom toEntity() => ChatRoom(
      roomId: roomId,
      roomName: roomName,
      creator: creator,
      participants: participants,
      createdAt: createdAt,
      lastMessage: lastMessage.toEntity(),
      thumbnailImage: thumbnailImage);
}

extension RoomEntityToModelExtension on ChatRoom {
  ChatRoomModel toModel() => ChatRoomModel(
      roomId: roomId,
      roomName: roomName,
      creator: creator,
      participants: participants,
      createdAt: createdAt,
      lastMessage: lastMessage.toModel(),
      thumbnailImage: thumbnailImage);
}

extension LastMessageModelToEntityExtension on LastMessageModel {
  LastMessage toEntity() =>
      LastMessage(sender: sender, content: content, timestamp: timestamp);
}

extension LastMessageEntityToModelExtension on LastMessage {
  LastMessageModel toModel() =>
      LastMessageModel(sender: sender, content: content, timestamp: timestamp);
}
