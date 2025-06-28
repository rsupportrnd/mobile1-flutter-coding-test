import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile1_flutter_coding_test/features/messages/data/datasources/message_local_datasource.dart';
import 'package:mobile1_flutter_coding_test/features/messages/data/datasources/message_remote_datasource.dart';
import 'package:mobile1_flutter_coding_test/features/messages/data/models/message.dart';
import 'package:mobile1_flutter_coding_test/features/messages/data/repositories/message_repository_impl.dart';

class MockMessageRemoteDataSource extends Mock implements MessageRemoteDataSource {}
class MockMessageLocalDataSource extends Mock implements MessageLocalDataSource {}

void main() {
  late MessageRepositoryImpl repository;
  late MockMessageRemoteDataSource remoteDataSource;
  late MockMessageLocalDataSource localDataSource;

  setUp(() {
    remoteDataSource = MockMessageRemoteDataSource();
    localDataSource = MockMessageLocalDataSource();
    repository = MessageRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
  });

  group('fetchMessages', () {
    test('원격 데이터 소스로부터 메시지 목록을 정상적으로 가져와야 한다', () async {
      final mockMessages = [
        Message(
          messageId: '1',
          roomId: 'room123',
          sender: 'user1',
          content: 'Hello',
          timestamp: DateTime.now(),
        ),
      ];

      // remoteDataSource.fetchMessages()가 호출되면 mockMessages 리턴
      when(() => remoteDataSource.fetchMessages())
          .thenAnswer((_) async => mockMessages);

      final result = await repository.fetchMessages();

      expect(result, mockMessages);
      verify(() => remoteDataSource.fetchMessages()).called(1);
    });
  });

  group('saveMessage', () {
    test('로컬 데이터 소스에 메시지를 저장해야 한다', () async {
      final message = Message(
        messageId: '1',
        roomId: 'room123',
        sender: 'user1',
        content: 'Hello',
        timestamp: DateTime.now(),
      );

      when(() => localDataSource.saveMessage(message))
          .thenAnswer((_) async {});

      await repository.saveMessage(message);

      verify(() => localDataSource.saveMessage(message)).called(1);
    });
  });

  group('getLocalMessagesByRoom', () {
    test('로컬 데이터 소스에서 roomId에 맞는 메시지 목록을 가져와야 한다', () async {
      final roomId = 'room123';
      final mockMessages = [
        Message(
          messageId: '1',
          roomId: roomId,
          sender: 'user1',
          content: 'Hello',
          timestamp: DateTime.now(),
        ),
      ];

      when(() => localDataSource.getMessagesByRoom(roomId))
          .thenAnswer((_) async => mockMessages);

      final result = await repository.getLocalMessagesByRoom(roomId);

      expect(result, mockMessages);
      verify(() => localDataSource.getMessagesByRoom(roomId)).called(1);
    });
  });
}
