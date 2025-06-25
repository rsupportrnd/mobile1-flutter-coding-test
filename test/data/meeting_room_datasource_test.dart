import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/src/core/common/exception/custom_exception.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile1_flutter_coding_test/src/data/datasource/meeting_room_datasource.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/meeting_room_list_response_model.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/message_list_response_model.dart';
import 'package:mobile1_flutter_coding_test/src/data/repository/meeting_room_repository_impl.dart';

class _MockMeetingRoomDatasource extends Mock implements MeetingRoomDatasource {}

void main() {
  group('MeetingRoomRepositoryImpl', () {
    late _MockMeetingRoomDatasource mockDatasource;
    late MeetingRoomRepositoryImpl repository;

    setUp(() {
      mockDatasource = _MockMeetingRoomDatasource();
      repository = MeetingRoomRepositoryImpl(datasource: mockDatasource);
    });

    test('getMeetingRoomList returns data on success', () async {
      const MeetingRoomListResponseModel expected = MeetingRoomListResponseModel(meetingRooms: []);
      when(() => mockDatasource.getMeetingRoomList()).thenAnswer((_) async => expected);

      final result = await repository.getMeetingRoomList();

      expect(result, expected);
      verify(() => mockDatasource.getMeetingRoomList()).called(1);
    });

    test('getMeetingRoomList fails with generic error', () {
      final exception = Exception('Datasource error');
      when(() => mockDatasource.getMeetingRoomList()).thenThrow(exception);

      expect(
        () => repository.getMeetingRoomList(),
        throwsA(isA<UnknownException>()),
      );
      verify(() => mockDatasource.getMeetingRoomList()).called(1);
    });

    test('getMessageList returns data on success', () async {
      const MessageListResponseModel expected = MessageListResponseModel(messages: []);
      when(() => mockDatasource.getMessageList()).thenAnswer((_) async => expected);

      final result = await repository.getMessageList();

      expect(result, expected);
      verify(() => mockDatasource.getMessageList()).called(1);
    });

    test('getMessageList throws when datasource fails', () async {
      final Exception exception = Exception('Datasource error');
      when(() => mockDatasource.getMessageList()).thenThrow(exception);

      expect(
        () => repository.getMessageList(),
        throwsA(isA<UnknownException>()),
      );
      verify(() => mockDatasource.getMessageList()).called(1);
    });
  });
}
