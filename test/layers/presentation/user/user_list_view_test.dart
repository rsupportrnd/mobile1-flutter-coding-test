import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/common/common.dart';
import 'package:mobile1_flutter_coding_test/layers/domain/domain.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/user/user_list_view.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/user/user_list_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/user/widget/user_tile.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import '../../../mock/presentation/mock_user_list_viewmodel.dart';

@GenerateMocks([UserListViewModel])
void main() {
  late MockUserListViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockUserListViewModel();
  });

  Widget createWidgetUnderTest() {
    return ChangeNotifierProvider<UserListViewModel>(
      create: (_) => mockViewModel,
      child: const MaterialApp(
        home: Scaffold(
          body: UserListView(),
        ),
      ),
    );
  }

  group('UserListView Tests', () {
    testWidgets('로딩 중일 때 로딩 인디케이터가 표시되는지 확인한다.', (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      when(mockViewModel.isLoading).thenReturn(true);
      when(mockViewModel.isError).thenReturn(false);
      when(mockViewModel.errorMessage).thenReturn('');
      when(mockViewModel.userList).thenReturn([]);

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
      when(mockViewModel.userList).thenReturn([]);

      await tester.pumpWidget(createWidgetUnderTest());

      // 오류 메시지와 재시도 버튼 확인
      expect(find.text('An error occurred'), findsOneWidget);
      expect(find.text(AppStrings.retry), findsOneWidget);
    });

    testWidgets('사용자 리스트가 있을 때 사용자 항목이 표시되는지 확인한다.', (WidgetTester tester) async {
      when(mockViewModel.isLoading).thenReturn(false);
      when(mockViewModel.isError).thenReturn(false);
      when(mockViewModel.errorMessage).thenReturn('');
      when(mockViewModel.userList).thenReturn([
        User(
          id: '1',
          name: 'Test User',
          email: 'admin@admin.com',
          profilePictureUrl: 'https://test.com1',
          status: UserStatus.online,
          role: UserRole.admin,
        ),
        User(
          id: '2',
          name: 'Test User2',
          email: 'member@member.com',
          profilePictureUrl: 'https://test.com2',
          status: UserStatus.online,
          role: UserRole.member,
        )
      ]);

      await tester.pumpWidget(createWidgetUnderTest());

      // 사용자 항목이 2개 표시되는지 확인
      expect(find.byType(UserTile), findsNWidgets(2));
      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('Test User2'), findsOneWidget);
    });
  });
}
