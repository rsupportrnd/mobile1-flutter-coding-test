import 'package:mobile1_flutter_coding_test/data/database/local_database.dart';
import 'package:mobile1_flutter_coding_test/data/utils/id_generator.dart';
import 'package:sqflite/sqflite.dart';

class IdGeneratorImpl implements IdGenerator {
  IdGeneratorImpl({required LocalDatabase database}) : _database = database;
  final LocalDatabase _database;

  Future<Database> get _db async => await _database.database;

  @override
  Future<String> generateNextMessageId() async {
    final db = await _db;
    final result = await db.rawQuery('''
      SELECT messageId FROM messages
      WHERE messageId LIKE 'msg%'
      ORDER BY CAST(SUBSTR(messageId, 4) AS INTEGER) DESC
      LIMIT 1
    ''');

    if (result.isEmpty) return 'msg1';

    final lastId = result.first['messageId'] as String;
    final number = int.tryParse(lastId.replaceFirst('msg', '')) ?? 0;
    return 'msg${number + 1}';
  }
}
