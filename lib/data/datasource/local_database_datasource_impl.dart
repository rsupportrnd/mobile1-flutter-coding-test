import 'package:mobile1_flutter_coding_test/data/database/local_database.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/local_database_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/model/message_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseDataSourceImpl implements LocalDatabaseDataSource {
  LocalDatabaseDataSourceImpl({required LocalDatabase database})
      : _database = database;
  final LocalDatabase _database;

  Future<Database> get _db async => await _database.database;

  @override
  Future<List<MessageModel>> getMessage() async {
    final db = await _db;
    final maps = await db.query('messages');
    return maps.map((e) => MessageModel.fromJson(e)).toList();
  }

  @override
  Future<void> insertMessage({required MessageModel message}) async {
    final db = await _db;
    await db.insert('messages', message.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
