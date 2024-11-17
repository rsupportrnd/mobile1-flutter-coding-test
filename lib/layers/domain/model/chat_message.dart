class ChatMessage {
  final String roomId;
  final String messageId;
  final String sender;
  final String content;
  final DateTime timestamp;

  ChatMessage({
    required this.roomId,
    required this.messageId,
    required this.sender,
    required this.content,
    required this.timestamp,
  });

  @override
  String toString() {
    return 'ChatMessage{roomId: $roomId, messageId: $messageId, sender: $sender, content: $content, timestamp: $timestamp}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessage &&
          runtimeType == other.runtimeType &&
          roomId == other.roomId &&
          messageId == other.messageId &&
          sender == other.sender &&
          content == other.content &&
          timestamp == other.timestamp;

  @override
  int get hashCode =>
      roomId.hashCode ^
      messageId.hashCode ^
      sender.hashCode ^
      content.hashCode ^
      timestamp.hashCode;


}
