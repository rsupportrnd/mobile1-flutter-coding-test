import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile1_flutter_coding_test/layers/domain/domain.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/main/main_frame_view.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/main/main_frame_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/meeting/meeting_room_list_view.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/meeting/meeting_room_list_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/user/user_list_view.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/user/user_list_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../mock/domain/usecase/mock_fetch_users_usecase.dart';
import '../meeting/meeting_room_list_viewmodel_test.mocks.dart';


void main() {
  final getIt = GetIt.instance;

  setUp(() {
    getIt.registerSingleton<FetchUsersUseCase>(MockFetchUsersUseCase());
    getIt.registerSingleton<FetchMeetingRoomUseCase>(MockFetchMeetingRoomUseCase());
  });

  tearDown(() {
    getIt.reset();
  });

  group('MainFrameView Tests', () {

    Widget createTestableWidget() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> MainFrameViewModel()),
          ChangeNotifierProvider(create: (_)=> UserListViewModel()),
          ChangeNotifierProvider(create: (_)=> MeetingRoomListViewModel()),
        ],
        child: const MaterialApp(
          home: MainFrameView(),
        ),
      );
    }

    testWidgets('MainFrameView에 BottomNavigationBar가 표시되는지 확인합니다.', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());

      // BottomNavigationBar가 한 개 존재하는지 확인 한다
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('MainFrameView에 BottomNavigationBar 탭 했을 때 화면이 전환되는지 확인합니다. ', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());

      final context = tester.element(find.byType(MainFrameView));
      final mainFrameViewModel = Provider.of<MainFrameViewModel>(context, listen: false);

      // widgetOptions 초기 값 사용자 목록인지 확인
      expect(mainFrameViewModel.widgetOptions[0], isA<UserListView>());

      // 두 번째 BottomNavigationBarItem(회의) 탭 이벤트
      await tester.tap(find.byIcon(Icons.chat).first);
      await tester.pumpAndSettle();

      // widgetOptions이 회의실 목록으로 변경되는지 확인
      expect(mainFrameViewModel.widgetOptions[1], isA<MeetingRoomListView>());
    });
  });
}
