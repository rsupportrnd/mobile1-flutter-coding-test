class MeetingRoom {
  final String roomId;
  final String roomName;
  final String creator;
  final List<String> participants;
  final DateTime createdAt;
  final LastMessage lastMessage;
  final String thumbnailImage;

  MeetingRoom({
    required this.roomId,
    required this.roomName,
    required this.creator,
    required this.participants,
    required this.createdAt,
    required this.lastMessage,
    required this.thumbnailImage,
  });
}

class LastMessage {
  final String sender;
  final String content;
  final DateTime timestamp;

  LastMessage({
    required this.sender,
    required this.content,
    required this.timestamp,
  });
}
