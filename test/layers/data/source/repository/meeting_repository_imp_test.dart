import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/layers/data/data.dart';
import 'package:mobile1_flutter_coding_test/layers/domain/domain.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meeting_repository_imp_test.mocks.dart';

@GenerateMocks([RemoteDataSources])
void main() {
  late MockRemoteDataSources mockRemoteDataSource;
  late MeetingRepositoryImp meetingRepositoryImp;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSources();
    meetingRepositoryImp = MeetingRepositoryImp(mockRemoteDataSource);
  });

  group('MeetingRepositoryImp Tests', () {
    test('fetchMeetingRoom 가 성공적으로 호출되면 사용자 목록 반환결과를 확인합니다.', () async {
      // Mock 데이터를 준비합니다.
      final mockResponse = [
        MeetingRoomDTO(
          roomId: "room6",
          roomName: "재무 보고서 검토",
          creator: "user3",
          participants: ["user3", "user2", "user5"],
          createdAt: DateTime.parse("2024-11-08T08:00:00Z"),
          lastMessage: LastMessageDTO(
              sender: "user5",
              content: "이번 분기 재무 보고서를 공유합니다.",
              timestamp: DateTime.parse("2024-11-08T08:30:00Z")),
          thumbnailImage: "https://picsum.photos/id/1016/200/200",
        ),
        MeetingRoomDTO(
          roomId: "room1",
          roomName: "프로젝트 A 회의",
          creator: "user1",
          participants: ["user1", "user2", "user3"],
          createdAt: DateTime.parse("2024-11-08T08:00:00Z"),
          lastMessage: LastMessageDTO(
              sender: "user2",
              content: "다음 회의는 언제로 할까요?",
              timestamp: DateTime.parse("2024-11-07T15:30:00Z")),
          thumbnailImage: "https://picsum.photos/id/1011/200/200",
        ),
      ];

      when(mockRemoteDataSource.fetchMeetingRoom()).thenAnswer((_) async => mockResponse);

      final result = await meetingRepositoryImp.fetchMeetingRoom();

      // 결과 검증
      expect(result, isA<List<MeetingRoom>>());
      expect(result.length, 2);
      expect(result[0].roomName, '재무 보고서 검토');
      expect(result[1].roomName, '프로젝트 A 회의');
    });

    test('fetchMeetingRoom 실패 시 예외처리를 확인합니다.', () async {
      when(mockRemoteDataSource.fetchMeetingRoom()).thenThrow(Exception('Failed to load users'));

      // 실행 및 예외 확인
      expect(() => meetingRepositoryImp.fetchMeetingRoom(), throwsException);
    });
  });
}
