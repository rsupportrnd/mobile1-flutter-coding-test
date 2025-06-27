import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/src/core/common/exception/custom_exception.dart';
import 'package:mobile1_flutter_coding_test/src/data/data.dart';
import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

class _MockMeetingRoomDatasource extends Mock implements MeetingRoomDatasource {}

void main() {
  group('MeetingRoomRepositoryImpl', () {
    late _MockMeetingRoomDatasource mockMeetingRoomDatasource;

    late MeetingRoomRepositoryImpl repository;

    setUp(() {
      mockMeetingRoomDatasource = _MockMeetingRoomDatasource();

      repository = MeetingRoomRepositoryImpl(meetingRoomDatasource: mockMeetingRoomDatasource);
    });

    test('getMeetingRoomList returns data on success', () async {
      const MeetingRoomListResponseModel expected = MeetingRoomListResponseModel(meetingRooms: []);
      when(() => mockMeetingRoomDatasource.getMeetingRoomList()).thenAnswer((_) async => expected);

      final MeetingRoomListResponseEntity result = await repository.getMeetingRoomList();

      expect(result, MeetingRoomMapper.meetingRoomListModelToEntity(expected));
      verify(() => mockMeetingRoomDatasource.getMeetingRoomList()).called(1);
    });

    test('getMeetingRoomList fails with generic error', () {
      final Exception exception = Exception('Datasource error');
      when(() => mockMeetingRoomDatasource.getMeetingRoomList()).thenThrow(exception);

      expect(
        () => repository.getMeetingRoomList(),
        throwsA(isA<UnknownException>()),
      );
      verify(() => mockMeetingRoomDatasource.getMeetingRoomList()).called(1);
    });
  });
}
