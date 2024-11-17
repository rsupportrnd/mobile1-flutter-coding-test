import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/common/common.dart';
import 'package:mobile1_flutter_coding_test/layers/domain/domain.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/meeting/meeting_room_list_view.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/meeting/meeting_room_list_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/meeting/widget/meeting_room_tile.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../mock/presentation/mock_meeting_room_list_viewmodel.dart';


@GenerateMocks([MeetingRoomListViewModel])
void main() {
  late MockMeetingRoomListViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockMeetingRoomListViewModel();
  });

  Widget createWidgetUnderTest() {
    return ChangeNotifierProvider<MeetingRoomListViewModel>(
      create: (_) => mockViewModel,
      child: const MaterialApp(
        home: Scaffold(
          body: MeetingRoomListView(),
        ),
      ),
    );
  }

  group('MeetingRoomListView Tests', () {
    testWidgets('로딩 중일 때 로딩 인디케이터가 표시되는지 확인한다.', (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      when(mockViewModel.isLoading).thenReturn(true);
      when(mockViewModel.isError).thenReturn(false);
      when(mockViewModel.errorMessage).thenReturn('');
      when(mockViewModel.meetingRoomList).thenReturn([]);

      await tester.pumpWidget(createWidgetUnderTest());

      // platform에 따라 로딩 상태 확인
      expect(mockViewModel.isLoading, true);
      expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      debugDefaultTargetPlatformOverride = null; // 환경 설정 초기화
    });

    testWidgets('오류가 발생했을 때 오류 메시지가 표시되는지 확인한다.', (WidgetTester tester) async {
      when(mockViewModel.isLoading).thenReturn(false);
      when(mockViewModel.isError).thenReturn(true);
      when(mockViewModel.errorMessage).thenReturn('An error occurred');
      when(mockViewModel.meetingRoomList).thenReturn([]);

      await tester.pumpWidget(createWidgetUnderTest());

      // 오류 메시지와 재시도 버튼 확인
      expect(find.text('An error occurred'), findsOneWidget);
      expect(find.text(AppStrings.retry), findsOneWidget);
    });

    testWidgets('회의 목록이 있을 때 사용자 항목이 표시되는지 확인한다.', (WidgetTester tester) async {
      when(mockViewModel.isLoading).thenReturn(false);
      when(mockViewModel.isError).thenReturn(false);
      when(mockViewModel.errorMessage).thenReturn('');
      when(mockViewModel.meetingRoomList).thenReturn([
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
      ]);

      await tester.pumpWidget(createWidgetUnderTest());

      // 사용자 항목이 2개 표시되는지 확인
      expect(find.byType(MeetingRoomTile), findsNWidgets(2));
      expect(find.text('재무 보고서 검토'), findsOneWidget);
      expect(find.text('프로젝트 A 회의'), findsOneWidget);
    });
  });
}
