import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile1_flutter_coding_test/app/index.dart';
import 'package:bloc_test/bloc_test.dart';

class MockUserBloc extends Mock implements UserBloc {}

void main() {
  late UserBloc mockUserBloc;

  setUp(() {
    mockUserBloc = MockUserBloc();

    // stream, state 모킹 필수
    when(() => mockUserBloc.state).thenReturn(const UserLoadSuccess(users: []));
    whenListen(
      mockUserBloc,
      Stream<UserState>.fromIterable([const UserLoadSuccess(users: [])]),
    );
  });

  testWidgets('UserListScreen 기본 UI 테스트', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<UserBloc>.value(
          value: mockUserBloc,
          child: const UserListScreen(),
        ),
      ),
    );

    expect(find.text('사용자 목록'), findsOneWidget);
  });
}
