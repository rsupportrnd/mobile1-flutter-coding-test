
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/common/common.dart';
import 'package:mobile1_flutter_coding_test/layers/domain/domain.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/user/user_detail_view.dart';

void main() {
  testWidgets('DserDetail 화면에서 user 정보를 확인한다.', (WidgetTester tester) async {
    final mockUsers = [
      User(
        id: 'user1',
        name: 'Alice Kim',
        email: 'alice.kim@example.com',
        profilePictureUrl: 'https://picsum.photos/id/1011/200/200',
        status: UserStatus.online,
        role: UserRole.admin,
      ),
    ];
    // UserTile 위젯을 테스트 환경에 추가
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UserDetailView(user: mockUsers[0]),
        ),
      ),
    );

    expect(find.text('user1'), findsOneWidget);
    expect(find.text('Alice Kim'), findsOneWidget);
    expect(find.text('alice.kim@example.com'), findsOneWidget);
    expect(find.text(AppStrings.admin), findsOneWidget);
    expect(find.text('● ${AppStrings.onlineLabel}'), findsOneWidget);
  });
}