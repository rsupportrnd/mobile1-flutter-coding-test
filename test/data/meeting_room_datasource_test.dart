import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/src/core/common/exception/custom_exception.dart';
import 'package:mobile1_flutter_coding_test/src/data/datasource/local_message_datasource.dart';
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
  group('MeetingRoomRepositoryImpl', () {
    late _MockMeetingRoomDatasource mockMeetingRoomDatasource;
    late _MockLocalMessageDatasource mockLocalMessageDatasource;

    late MeetingRoomRepositoryImpl repository;

    setUp(() {
      mockMeetingRoomDatasource = _MockMeetingRoomDatasource();
      mockLocalMessageDatasource = _MockLocalMessageDatasource();

      repository = MeetingRoomRepositoryImpl(
        meetingRoomDatasource: mockMeetingRoomDatasource,
        localMessageDatasource: mockLocalMessageDatasource,
      );
    });

    test('getMeetingRoomList returns data on success', () async {
      const MeetingRoomListResponseModel expected =
          MeetingRoomListResponseModel(meetingRooms: []);
      when(() => mockMeetingRoomDatasource.getMeetingRoomList())
          .thenAnswer((_) async => expected);

      final result = await repository.getMeetingRoomList();

      expect(result, expected);
      verify(() => mockMeetingRoomDatasource.getMeetingRoomList()).called(1);
    });

    test('getMeetingRoomList fails with generic error', () {
      final exception = Exception('Datasource error');
      when(() => mockMeetingRoomDatasource.getMeetingRoomList())
          .thenThrow(exception);

      expect(
        () => repository.getMeetingRoomList(),
        throwsA(isA<UnknownException>()),
      );
      verify(() => mockMeetingRoomDatasource.getMeetingRoomList()).called(1);
    });

    test('getMessageList returns data on success', () async {
      const MessageListResponseModel expected =
          MessageListResponseModel(messages: []);
      when(() => mockMeetingRoomDatasource.getRemoteMessageList())
          .thenAnswer((_) async => expected);

      final result = await repository.getRemoteMessageList();

      expect(result, expected);
      verify(() => mockMeetingRoomDatasource.getRemoteMessageList()).called(1);
    });

    test('getMessageList throws when datasource fails', () async {
      final Exception exception = Exception('Datasource error');
      when(() => mockMeetingRoomDatasource.getRemoteMessageList())
          .thenThrow(exception);

      expect(
        () => repository.getRemoteMessageList(),
        throwsA(isA<UnknownException>()),
      );
      verify(() => mockMeetingRoomDatasource.getRemoteMessageList()).called(1);
    });
  });
}
