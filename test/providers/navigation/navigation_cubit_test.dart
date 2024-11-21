import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';
import 'package:mobile1_flutter_coding_test/providers/navigation/navigation_cubit.dart';

void main() {
  group('NavigationCubit', () {
    late NavigationCubit navigationCubit;

    setUp(() {
      navigationCubit = NavigationCubit();
    });

    tearDown(() {
      navigationCubit.close();
    });

    test('초기 상태인 initial 상태로 0이 제대로 들어갔는지 보자', () {
      expect(navigationCubit.state, const NavigationState.initial(0));
    });

    blocTest<NavigationCubit, NavigationState>(
      'changePage를 통해 1이 들어갔을 때 initial 상태로 변경되는지 확인',
      build: () => navigationCubit,
      act: (cubit) => cubit.changePage(1),
      expect: () => [const NavigationState.initial(1)],
    );
  });
}
