// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rsupport/main.dart';

void main() {
  testWidgets('앱 기본 위젯 테스트', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Verify that our app loads properly
    expect(find.byType(MaterialApp), findsOneWidget);
    
    // 잠시 대기하여 앱이 완전히 로드되도록 함
    await tester.pump();
  });

  testWidgets('메인 스크린 네비게이션 바 테스트', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    
    // 앱이 완전히 로드될 때까지 대기
    await tester.pumpAndSettle();

    // 네비게이션 바가 있는지 확인
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });
}
