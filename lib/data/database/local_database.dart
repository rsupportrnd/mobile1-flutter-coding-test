import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();
  factory LocalDatabase() => _instance;
  LocalDatabase._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'chat.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE messages(
            messageId TEXT PRIMARY KEY,
            roomId TEXT,
            sender TEXT,
            content TEXT,
            timestamp TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE rooms (
            roomId TEXT PRIMARY KEY,
            roomName TEXT,
            creator TEXT,
            participants TEXT,
            createdAt TEXT,
            thumbnailImage TEXT,
            lastMessageSender TEXT,
            lastMessageContent TEXT,
            lastMessageTimestamp TEXT
          )
        ''');
      },
    );
  }
}
