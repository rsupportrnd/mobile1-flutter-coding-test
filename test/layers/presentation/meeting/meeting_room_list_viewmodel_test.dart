import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/common/common.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/meeting/meeting_room_list_viewmodel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mobile1_flutter_coding_test/layers/domain/domain.dart';

import 'meeting_room_list_viewmodel_test.mocks.dart';


@GenerateMocks([FetchMeetingRoomUseCase])
void main() {
  late MeetingRoomListViewModel viewModel;
  late MockFetchMeetingRoomUseCase mockFetchMeetingRoomUseCase;
  late List<MeetingRoom> mockMeetingRoom;

  setUp(() {
    mockFetchMeetingRoomUseCase = MockFetchMeetingRoomUseCase();
    viewModel = MeetingRoomListViewModel(mockFetchMeetingRoomUseCase);
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

  group('MeetingRoomListViewModel Tests', () {

    test('초기 상태 값과 fetchMeetingRoomList 호출 후 상태 변화를 확인합니다.', () async {
      when(mockFetchMeetingRoomUseCase.execute()).thenAnswer((_) async => mockMeetingRoom);
      // 초기 상태값 확인
      expect(viewModel.isLoading, true);
      expect(viewModel.isError, false);
      expect(viewModel.errorMessage, '');
      expect(viewModel.meetingRoomList, []);

      await viewModel.fetchMeetingRoomList();
      // fetchUserList 호출 시 상태가 올바르게 변하는지 확인
      expect(viewModel.isLoading, false);
      expect(viewModel.isError, false);
      expect(viewModel.errorMessage, '');
      expect(viewModel.meetingRoomList, mockMeetingRoom);
    });

    test('fetchMeetingRoomList 호출 시 에러가 발생하면 에러 상태, 메시지를 출력하는지 확인합니다.', () async {
      when(mockFetchMeetingRoomUseCase.execute()).thenThrow(Exception(AppStrings.unexpectedError));

      expect(viewModel.isLoading, true);
      expect(viewModel.isError, false);
      expect(viewModel.errorMessage, '');

      await viewModel.fetchMeetingRoomList();
      // 에러상태, 메시지 출력되는지 확인
      expect(viewModel.isLoading, false);
      expect(viewModel.isError, true);
      expect(viewModel.errorMessage, AppStrings.unexpectedError);
    });

    test('onRetry 호출 시 사용자 목록을 다시 가져오는지 확인합니다.', () async {
      when(mockFetchMeetingRoomUseCase.execute()).thenAnswer((_) async => mockMeetingRoom);

      await viewModel.onRetry();
      // 사용자 목록이 다시 로드되는지 확인
      expect(viewModel.isLoading, false);
      expect(viewModel.errorMessage, '');
      expect(viewModel.meetingRoomList, mockMeetingRoom);
    });
  });
}
