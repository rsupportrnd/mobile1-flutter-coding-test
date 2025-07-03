import 'dart:convert';

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

extension ChatRoomDbExtension on ChatRoomModel {
  /// DB용 JSON (SQLite 저장용)
  Map<String, dynamic> toDbJson() {
    return {
      'roomId': roomId,
      'roomName': roomName,
      'creator': creator,
      'participants': jsonEncode(participants),
      'createdAt': createdAt,
      'thumbnailImage': thumbnailImage,
      'lastMessageSender': lastMessage.sender,
      'lastMessageContent': lastMessage.content,
      'lastMessageTimestamp': lastMessage.timestamp,
    };
  }

  /// DB에서 불러올 때
  static ChatRoomModel fromDbJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      roomId: json['roomId'] as String,
      roomName: json['roomName'] as String,
      creator: json['creator'] as String,
      participants:
          List<String>.from(jsonDecode(json['participants'] as String)),
      createdAt: json['createdAt'] as String,
      thumbnailImage: json['thumbnailImage'] as String,
      lastMessage: LastMessageModel(
        sender: json['lastMessageSender'] as String,
        content: json['lastMessageContent'] as String,
        timestamp: json['lastMessageTimestamp'] as String,
      ),
    );
  }
}
