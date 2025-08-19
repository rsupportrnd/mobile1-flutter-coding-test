// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/core/injector.dart';
import 'package:mobile1_flutter_coding_test/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await setupDependencies();
  });
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // 템플릿 Counter 테스트는 삭제하고, 앱이 부팅되는지만 확인
    await tester.pumpWidget(const MyApp()); // 또는 const App()
    await tester.pump(); // 1 프레임
    await tester
        .pump(const Duration(milliseconds: 400)); // StartupCubit delay 통과

    // 하단 탭/Users 화면 존재 확인(프로젝트 구조에 맞게 문구 조정)
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.text('Users'), findsWidgets);
  });
}
