import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/message.dart';

abstract class MessageLocalDataSource {
  Future<void> saveMessage(Message message);
  Future<List<Message>> getMessagesByRoom(String roomId);
}

class MessageLocalDataSourceImpl implements MessageLocalDataSource {
  static Database? _db;

  Future<Database> get _database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'chat.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE messages (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            roomId TEXT NOT NULL,
            messageId TEXT NOT NULL,
            sender TEXT NOT NULL,
            content TEXT NOT NULL,
            timestamp TEXT NOT NULL
          )
        ''');
      },
    );
  }

  @override
  Future<void> saveMessage(Message message) async {
    final db = await _database;
    await db.insert(
      'messages',
      message.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Message>> getMessagesByRoom(String roomId) async {
    final db = await _database;
    final maps = await db.query(
      'messages',
      where: 'roomId = ?',
      whereArgs: [roomId],
      orderBy: 'timestamp ASC',
    );
    return maps.map((e) => Message.fromMap(e)).toList();
  }
}
