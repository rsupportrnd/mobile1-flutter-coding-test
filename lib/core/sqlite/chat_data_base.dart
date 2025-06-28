import 'package:mobile1_flutter_coding_test/app/index.dart';

class ChatDatabase {
  static final ChatDatabase _instance = ChatDatabase._internal();

  factory ChatDatabase() => _instance;

  ChatDatabase._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'chat.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // 메시지 테이블
        await db.execute('''
          CREATE TABLE messages(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            roomId TEXT NOT NULL,
            messageId TEXT NOT NULL,
            sender TEXT NOT NULL,
            content TEXT NOT NULL,
            timestamp INTEGER NOT NULL
          )
        ''');

        // last_message 테이블 추가
        await db.execute('''
          CREATE TABLE last_message(
            room_id TEXT PRIMARY KEY,
            sender TEXT NOT NULL,
            content TEXT NOT NULL,
            timestamp INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  // 메시지 불러오기 (roomId 기준, 시간 오름차순)
  Future<List<Message>> getMessagesByRoom(String roomId) async {
    final database = await db;
    final result = await database.query(
      'messages',
      where: 'roomId = ?',
      whereArgs: [roomId],
      orderBy: 'timestamp ASC',
    );
    return result.map((e) => Message.fromMap(e)).toList();
  }

  // 메시지 삽입
  Future<void> insertMessage(Message message) async {
    final database = await db;
    await database.insert('messages', message.toMap());
  }

  // 방별 마지막 메시지 불러오기
  Future<Map<String, LastMessage>> getAllLastMessages() async {
    final database = await db;
    final result = await database.query('last_message');

    final Map<String, LastMessage> lastMessages = {};
    for (final map in result) {
      lastMessages[map['room_id'] as String] = LastMessage(
        sender: map['sender'] as String,
        content: map['content'] as String,
        timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      );
    }
    return lastMessages;
  }

  // 방별 마지막 메시지 저장 또는 업데이트
  Future<void> upsertLastMessage(String roomId, LastMessage lastMessage) async {
    final database = await db;
    await database.insert(
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
