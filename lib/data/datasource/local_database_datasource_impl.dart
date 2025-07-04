import 'package:mobile1_flutter_coding_test/data/database/local_database.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/local_database_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/mapper/room_mapper.dart';
import 'package:mobile1_flutter_coding_test/data/model/message_model.dart';
import 'package:mobile1_flutter_coding_test/data/model/room_model.dart';
import 'package:mobile1_flutter_coding_test/data/model/user_model.dart';
import 'package:mobile1_flutter_coding_test/data/utils/id_generator.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseDataSourceImpl implements LocalDatabaseDataSource {
  LocalDatabaseDataSourceImpl(
      {required LocalDatabase database, required IdGenerator idGenerator})
      : _database = database,
        _idGenerator = idGenerator;
  final LocalDatabase _database;
  final IdGenerator _idGenerator;

  Future<Database> get _db async => await _database.database;

  @override
  Future<List<MessageModel>> selectMessages() async {
    try {
      final db = await _db;
      final maps = await db.query(
        'messages',
      );
      return maps.map((e) => MessageModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MessageModel>> selectMessagesByRoomId(
      {required String roomId}) async {
    try {
      final db = await _db;
      final maps = await db.query(
        'messages',
        where: 'roomId = ?',
        whereArgs: [roomId],
        orderBy: 'timestamp ASC',
      );
      return maps.map((e) => MessageModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MessageModel> insertMessage({required MessageModel message}) async {
    try {
      final db = await _db;
      final newMessage = message.copyWith(
          messageId: await _idGenerator.generateNextMessageId());
      await db.insert('messages', newMessage.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return newMessage;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insertMessages({required List<MessageModel> messages}) async {
    try {
      final db = await _db;
      final batch = db.batch();
      for (var msg in messages) {
        batch.insert('messages', msg.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ChatRoomModel>> selectRooms() async {
    try {
      final db = await _db;
      final maps = await db.query(
        'rooms',
        orderBy: 'lastMessageTimestamp DESC',
      );
      return maps.map(ChatRoomDbExtension.fromDbJson).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insertRooms({required List<ChatRoomModel> rooms}) async {
    try {
      final db = await _db;
      final batch = db.batch();
      for (var room in rooms) {
        batch.insert('rooms', room.toDbJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateRoom(
      {required String roomId, required LastMessageModel message}) async {
    try {
      final db = await _db;
      await db.update(
        'rooms',
        {
          'lastMessageSender': message.sender,
          'lastMessageContent': message.content,
          'lastMessageTimestamp': message.timestamp,
        },
        where: 'roomId = ?',
        whereArgs: [roomId],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> selectUsers() async {
    try {
      final db = await _db;
      final maps = await db.query(
        'users',
      );
      return maps.map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insertUsers({required List<UserModel> users}) async {
    try {
      final db = await _db;
      final batch = db.batch();
      for (var user in users) {
        batch.insert('users', user.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true);
    } catch (e) {
      rethrow;
    }
  }
}
