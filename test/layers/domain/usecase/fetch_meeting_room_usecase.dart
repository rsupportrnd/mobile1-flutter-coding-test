
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mobile1_flutter_coding_test/layers/domain/domain.dart';

import 'fetch_meeting_room_usecase.mocks.dart';

@GenerateMocks([MeetingRepository])
void main() {
  late FetchMeetingRoomUseCase fetchMeetingRoomUseCase;
  late MockMeetingRepository mockMeetingRepository;
  late List<MeetingRoom> mockMeetingRoom;

  setUp(() {
    mockMeetingRepository = MockMeetingRepository();
    fetchMeetingRoomUseCase = FetchMeetingRoomUseCase(mockMeetingRepository);

    // 테스트용 사용자 목록 생성
    mockMeetingRoom = [
      MeetingRoom(
        roomId: "room6",
        roomName: "재무 보고서 검토",
        creator: "user3",
        participants: ["user3", "user2", "user5"],
        createdAt: DateTime.parse("2024-11-08T08:00:00Z"),
        lastMessage: LastMessage(
            sender: "user5",
            content: "이번 분기 재무 보고서를 공유합니다.",
            timestamp: DateTime.parse("2024-11-08T08:30:00Z")),
        thumbnailImage: "https://picsum.photos/id/1016/200/200",
      ),
      MeetingRoom(
        roomId: "room1",
        roomName: "프로젝트 A 회의",
        creator: "user1",
        participants: ["user1", "user2", "user3"],
        createdAt: DateTime.parse("2024-11-08T08:00:00Z"),
        lastMessage: LastMessage(
            sender: "user2",
            content: "다음 회의는 언제로 할까요?",
            timestamp: DateTime.parse("2024-11-07T15:30:00Z")),
        thumbnailImage: "https://picsum.photos/id/1011/200/200",
      ),
    ];
  });

  group('FetchMeetingRoomUseCase Tests', () {
    test('fetchMeetingRoom가 성공하면 회의 목록을 반환을 확인한다.', () async {
      when(mockMeetingRepository.fetchMeetingRoom()).thenAnswer((_) async => mockMeetingRoom);

      // 유스케이스 실행
      final result = await fetchMeetingRoomUseCase.execute();

      // 결과 확인
      expect(result, mockMeetingRoom);
      verify(mockMeetingRepository.fetchMeetingRoom()).called(1);
    });

    test('fetchMeetingRoom 가  예외를 적용할 때 오류를 확인한다.', () async {
      when(mockMeetingRepository.fetchMeetingRoom()).thenThrow(Exception("Failed to fetch meeting room"));

      // 예외 발생 여부 검증
      expect(() => fetchMeetingRoomUseCase.execute(), throwsException);
      verify(mockMeetingRepository.fetchMeetingRoom()).called(1);
    });
  });
}
