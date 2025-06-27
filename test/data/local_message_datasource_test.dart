import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/src/data/data.dart';

import 'package:mobile1_flutter_coding_test/src/domain/entity/message_list_response_entity.dart';
import 'package:mocktail/mocktail.dart';

class _MockLocalMessageDatasource extends Mock implements LocalMessageDatasource {}

class _MockRemoteMessageDatasource extends Mock implements RemoteMessageDatasource {}

void main() {
  group('LocalMessageRepositoryImpl', () {
    late _MockLocalMessageDatasource mockLocalMessageDatasource;
    late _MockRemoteMessageDatasource mockRemoteMessageDatasource;

    late MessageRepositoryImpl repository;
    const String roomId = 'room_1';
    setUp(() {
      mockLocalMessageDatasource = _MockLocalMessageDatasource();
      mockRemoteMessageDatasource = _MockRemoteMessageDatasource();
      repository = MessageRepositoryImpl(
          localMessageDatasource: mockLocalMessageDatasource,
          remoteMessageDatasource: mockRemoteMessageDatasource);
    });

    test('getLocalMessageList returns messages from datasource', () async {
      const List<MessageModel> expected = <MessageModel>[];
      when(() => mockLocalMessageDatasource.getMessages(roomId: roomId))
          .thenAnswer((_) async => expected);

      final List<MessageEntity> result = await repository.getLocalMessageList(roomId: roomId);

      expect(result, expected);
      verify(() => mockLocalMessageDatasource.getMessages(roomId: roomId)).called(1);
    });

    test('getLocalMessageList throws when datasource fails', () async {
      final Exception exception = Exception('storage error');
      when(() => mockLocalMessageDatasource.getMessages(roomId: roomId)).thenThrow(exception);

      expect(
        () => repository.getLocalMessageList(roomId: roomId),
        throwsA(same(exception)),
      );
      verify(() => mockLocalMessageDatasource.getMessages(roomId: roomId)).called(1);
    });

    test('saveMessages delegates to datasource', () async {
      const List<MessageEntity> messages = <MessageEntity>[];
      when(() => mockLocalMessageDatasource.saveMessages(roomId: roomId, messages: messages))
          .thenAnswer((_) async {});

      await repository.saveMessages(roomId: roomId, messages: messages);

      verify(() => mockLocalMessageDatasource.saveMessages(roomId: roomId, messages: messages))
          .called(1);
    });

    test('saveMessages throws when datasource fails', () async {
      const List<MessageEntity> messages = <MessageEntity>[];
      final Exception exception = Exception('storage error');
      when(() => mockLocalMessageDatasource.saveMessages(roomId: roomId, messages: messages))
          .thenThrow(exception);

      expect(
        () => repository.saveMessages(roomId: roomId, messages: messages),
        throwsA(same(exception)),
      );
      verify(() => mockLocalMessageDatasource.saveMessages(roomId: roomId, messages: messages))
          .called(1);
    });
  });
}
