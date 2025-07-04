// test/id_generator_impl_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/data/database/local_database.dart'; // DB 초기화용
import 'package:mobile1_flutter_coding_test/data/datasource/local_database_datasource_impl.dart'; // 메시지 삽입용
import 'package:mobile1_flutter_coding_test/data/model/message_model.dart'; // 메시지 모델
import 'package:mobile1_flutter_coding_test/data/utils/id_generator_impl.dart'; // 실제 위치로 수정
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit(); // FFI 사용 설정
  databaseFactory = databaseFactoryFfi;

  group('IdGeneratorImpl (DB 기반)', () {
    late LocalDatabase dbHelper;
    late LocalDatabaseDataSourceImpl datasource;
    late IdGeneratorImpl idGenerator;

    setUp(() async {
      dbHelper = LocalDatabase();
      final db = await dbHelper.database; // LocalDatabase 내부에서 DB 열기

      // 메시지 테이블 초기화(삭제 후 재생성)
      await db.execute('DROP TABLE IF EXISTS messages');
      await db.execute('''
        CREATE TABLE messages (
          messageId TEXT PRIMARY KEY,
          roomId TEXT,
          sender TEXT,
          content TEXT,
          timestamp TEXT
        )
      ''');

      idGenerator = IdGeneratorImpl(database: dbHelper);
      datasource = LocalDatabaseDataSourceImpl(
          database: dbHelper, idGenerator: idGenerator);
    });

    test('초기에는 messageId가 msg1부터 시작', () async {
      final messageId = await idGenerator.generateNextMessageId();
      expect(messageId, equals("msg1"));
    });

    test('메시지를 하나 삽입 후 다음 ID는 2여야 함', () async {
      // given
      final firstId = await idGenerator.generateNextMessageId();
      final message = MessageModel(
        messageId: firstId,
        roomId: 'room1',
        sender: 'user1',
        content: 'Hello',
        timestamp: DateTime.now().toIso8601String(),
      );

      await datasource.insertMessage(message: message);

      // when
      final nextId = await idGenerator.generateNextMessageId();

      // then
      expect(
          int.tryParse(nextId.replaceFirst('msg', '')) ?? 0,
          equals((int.tryParse(firstId.replaceFirst('msg', '')) ?? 0) +
              1)); // 다음 messageId 숫자는 +1
    });

    test('여러 메시지를 삽입한 경우 ID가 누적됨', () async {
      for (int i = 0; i < 5; i++) {
        final id = await idGenerator.generateNextMessageId();
        final message = MessageModel(
          messageId: id,
          roomId: 'room1',
          sender: 'user1',
          content: 'Hi $i',
          timestamp: DateTime.now().toIso8601String(),
        );
        await datasource.insertMessage(message: message);
      }

      final nextId = await idGenerator.generateNextMessageId();
      expect(nextId, equals("msg6")); // 1~5까지 들어갔으니 다음은 6
    });
  });
}
