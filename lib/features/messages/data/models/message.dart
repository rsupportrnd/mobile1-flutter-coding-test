class Message {
  final int? id;
  final String roomId;
  final String messageId;
  final String sender;
  final String content;
  final DateTime timestamp;

  Message({
    this.id,
    required this.roomId,
    required this.messageId,
    required this.sender,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'roomId': roomId,
        'messageId': messageId,
        'sender': sender,
        'content': content,
        'timestamp': timestamp.toIso8601String(),
      };

  factory Message.fromMap(Map<String, dynamic> map) => Message(
        id: map['id'],
        roomId: map['roomId'],
        messageId: map['messageId'],
        sender: map['sender'],
        content: map['content'],
        timestamp: DateTime.parse(map['timestamp']),
      );

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: null,
        roomId: json['roomId'],
        messageId: json['messageId'],
        sender: json['sender'],
        content: json['content'],
        timestamp: DateTime.parse(json['timestamp']),
      );
}
