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
}
