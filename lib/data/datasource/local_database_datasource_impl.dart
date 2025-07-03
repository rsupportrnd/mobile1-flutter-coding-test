import 'package:mobile1_flutter_coding_test/data/database/local_database.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/local_database_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/mapper/room_mapper.dart';
import 'package:mobile1_flutter_coding_test/data/model/message_model.dart';
import 'package:mobile1_flutter_coding_test/data/model/room_model.dart';
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
  Future<List<MessageModel>> selectMessages({required String roomId}) async {
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

  // @override
  // Future<void> updateLastMessage(String roomId, Message message) async {
  //   await db.update(
  //     'rooms',
  //     {
  //       'lastMessageContent': message.content,
  //       'lastMessageTime': message.timestamp.toIso8601String(),
  //     },
  //     where: 'roomId = ?',
  //     whereArgs: [roomId],
  //   );
  // }
}
