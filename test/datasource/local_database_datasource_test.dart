import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/data/mapper/room_mapper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:mobile1_flutter_coding_test/data/database/local_database.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/local_database_datasource_impl.dart';
import 'package:mobile1_flutter_coding_test/data/model/message_model.dart';
import 'package:mobile1_flutter_coding_test/data/model/room_model.dart';
import 'package:mobile1_flutter_coding_test/data/model/user_model.dart';
import 'package:mobile1_flutter_coding_test/data/utils/id_generator_impl.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late LocalDatabase dbHelper;
  late LocalDatabaseDataSourceImpl datasource;
  late IdGeneratorImpl idGenerator;

  setUp(() async {
    dbHelper = LocalDatabase();

    // DB 초기화 - 실제로 _initDb에서 테이블 생성하므로 별도 DROP 안함
    final db = await dbHelper.database;

    idGenerator = IdGeneratorImpl(database: dbHelper);
    datasource = LocalDatabaseDataSourceImpl(
        database: dbHelper, idGenerator: idGenerator);

    // 초기 데이터 세팅 - 방 데이터 1개, 유저 데이터 1명
    await db.delete('messages');
    await db.delete('rooms');
    await db.delete('users');

    final mockChatRoomModel = ChatRoomModel(
        roomId: "room1",
        roomName: "roomName",
        creator: "user1",
        participants: ["user1", "user2"],
        createdAt: DateTime.now().toIso8601String(),
        lastMessage: LastMessageModel(
            sender: "user2",
            content: "content2",
            timestamp: DateTime.now().toIso8601String()),
        thumbnailImage: "url");

    await db.insert('rooms', mockChatRoomModel.toDbJson());

    await db.insert('users', {
      'userId': 'user1',
      'name': 'Alice',
      'email': 'alice@example.com',
      'profilePicture': '',
      'status': 'online',
      'role': 'member',
    });
  });

  test('insertMessage & selectMessagesByRoomId 테스트', () async {
    final message = MessageModel(
      messageId: '', // idGenerator가 새 ID 부여
      roomId: 'room1',
      sender: 'user1',
      content: 'Hello World',
      timestamp: DateTime.now().toIso8601String(),
    );

    final inserted = await datasource.insertMessage(message: message);
    expect(inserted.messageId, isNotEmpty);
    expect(inserted.content, 'Hello World');

    final messages = await datasource.selectMessagesByRoomId(roomId: 'room1');
    expect(messages.length, 1);
    expect(inserted.roomId, 'room1');
    expect(messages.first.content, 'Hello World');
  });

  test('updateRoom 테스트', () async {
    final lastMessage = LastMessageModel(
      sender: 'user1',
      content: 'Updated Last Message',
      timestamp: DateTime.now().toIso8601String(),
    );

    await datasource.updateRoom(roomId: 'room1', message: lastMessage);

    final rooms = await datasource.selectRooms();
    final room = rooms.firstWhere((r) => r.roomId == 'room1');
    expect(room.lastMessage.sender, lastMessage.sender);
    expect(room.lastMessage.content, lastMessage.content);
    expect(room.lastMessage.timestamp, lastMessage.timestamp);
  });

  test('selectUsers 테스트', () async {
    final users = await datasource.selectUsers();
    expect(users.length, 1);
    expect(users.first.userId, 'user1');
    expect(users.first.name, 'Alice');
  });

  test('insertRooms 테스트', () async {
    final newRoom = ChatRoomModel(
      roomId: 'room2',
      roomName: 'New Room',
      creator: 'user2',
      participants: ['user2', 'user3'],
      createdAt: DateTime.now().toIso8601String(),
      thumbnailImage: '',
      lastMessage: LastMessageModel(
          sender: 'user2',
          content: "content2",
          timestamp: DateTime.now().toIso8601String()),
    );

    await datasource.insertRooms(rooms: [newRoom]);

    final rooms = await datasource.selectRooms();
    expect(rooms.any((r) => r.roomId == 'room2'), true);
    final participants = rooms.first.participants;
    expect(participants, isA<List<String>>());
    expect(participants, contains('user2'));
    expect(participants, contains('user3'));
  });

  test('insertUsers 테스트', () async {
    const newUser = UserModel(
      userId: 'user2',
      name: 'Bob',
      email: 'bob@example.com',
      profilePicture: '',
      status: 'offline',
      role: 'admin',
    );

    await datasource.insertUsers(users: [newUser]);

    final users = await datasource.selectUsers();
    expect(users.any((u) => u.userId == 'user2'), true);
  });
}
