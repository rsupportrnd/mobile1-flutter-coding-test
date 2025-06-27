import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/src/core/common/exception/custom_exception.dart';
import 'package:mobile1_flutter_coding_test/src/data/datasource/local_message_datasource.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/message_list_response_entity.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile1_flutter_coding_test/src/data/datasource/meeting_room_datasource.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/meeting_room_list_response_model.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/message_list_response_model.dart';
import 'package:mobile1_flutter_coding_test/src/data/repository/meeting_room_repository_impl.dart';

class _MockMeetingRoomDatasource extends Mock
    implements MeetingRoomDatasource {}

class _MockLocalMessageDatasource extends Mock
    implements LocalMessageDatasource {}

void main() {
  group('LocalMessageRepositoryImpl', () {
    late _MockMeetingRoomDatasource mockMeetingRoomDatasource;
    late _MockLocalMessageDatasource mockLocalMessageDatasource;

    late MeetingRoomRepositoryImpl repository;
    const String roomId = 'room_1';
    setUp(() {
      mockMeetingRoomDatasource = _MockMeetingRoomDatasource();
      mockLocalMessageDatasource = _MockLocalMessageDatasource();

      repository = MeetingRoomRepositoryImpl(
        meetingRoomDatasource: mockMeetingRoomDatasource,
        localMessageDatasource: mockLocalMessageDatasource,
      );
    });

    test('getLocalMessageList returns messages from datasource', () async {
      const List<MessageEntity> expected = <MessageEntity>[];
      when(() => mockLocalMessageDatasource.getMessages(roomId: roomId))
          .thenAnswer((_) async => expected);

      final List<MessageEntity> result =
          await repository.getLocalMessageList(roomId: roomId);

      expect(result, expected);
      verify(() => mockLocalMessageDatasource.getMessages(roomId: roomId))
          .called(1);
    });

    test('getLocalMessageList throws when datasource fails', () async {
      final Exception exception = Exception('storage error');
      when(() => mockLocalMessageDatasource.getMessages(roomId: roomId))
          .thenThrow(exception);

      expect(
        () => repository.getLocalMessageList(roomId: roomId),
        throwsA(same(exception)),
      );
      verify(() => mockLocalMessageDatasource.getMessages(roomId: roomId))
          .called(1);
    });

    test('saveMessages delegates to datasource', () async {
      const List<MessageEntity> messages = <MessageEntity>[];
      when(() => mockLocalMessageDatasource.saveMessages(
          roomId: roomId, messages: messages)).thenAnswer((_) async {});

      await repository.saveMessages(roomId: roomId, messages: messages);

      verify(() => mockLocalMessageDatasource.saveMessages(
          roomId: roomId, messages: messages)).called(1);
    });

    test('saveMessages throws when datasource fails', () async {
      const List<MessageEntity> messages = <MessageEntity>[];
      final Exception exception = Exception('storage error');
      when(() => mockLocalMessageDatasource.saveMessages(
          roomId: roomId, messages: messages)).thenThrow(exception);

      expect(
        () => repository.saveMessages(roomId: roomId, messages: messages),
        throwsA(same(exception)),
      );
      verify(() => mockLocalMessageDatasource.saveMessages(
          roomId: roomId, messages: messages)).called(1);
    });
  });
}
