import 'package:mobile1_flutter_coding_test/app/index.dart';

abstract class RoomLocalDataSource {
  Future<Map<String, LastMessage>> fetchAllLastMessages();

  Future<void> saveLastMessage(String roomId, LastMessage lastMessage);
}

class RoomLocalDataSourceImpl implements RoomLocalDataSource {
  final ChatDatabase chatDatabase;

  RoomLocalDataSourceImpl({required this.chatDatabase});

  Future<Database> get _db async => await chatDatabase.db;

  @override
  Future<Map<String, LastMessage>> fetchAllLastMessages() async {
    final db = await _db;
    final maps = await db.query('last_message');

    final Map<String, LastMessage> lastMessages = {};
    for (final map in maps) {
      final roomId = map['room_id'] as String;
      final lastMessage = LastMessage(
        sender: map['sender'] as String,
        content: map['content'] as String,
        timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      );
      lastMessages[roomId] = lastMessage;
    }
    return lastMessages;
  }

  @override
  Future<void> saveLastMessage(String roomId, LastMessage lastMessage) async {
    final db = await _db;
    await db.insert(
      'last_message',
      {
        'room_id': roomId,
        'sender': lastMessage.sender,
        'content': lastMessage.content,
        'timestamp': lastMessage.timestamp.millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
