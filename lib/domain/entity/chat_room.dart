import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';

class ChatRoom {
  final String roomId;
  final String roomName;
  final String creator;
  final List<String> participants;
  final String createdAt;
  final Message? lastMessage;
  final String thumbnailImage;

  ChatRoom({
    required this.roomId,
    required this.roomName,
    required this.creator,
    required this.participants,
    required this.createdAt,
    this.lastMessage,
    required this.thumbnailImage,
  });
}
