import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/core.dart';

void main() {
  group('BottomNavIndexProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() => container.dispose());

    test('initial tab is user', () {
      final BottomNavTabType result =
          container.read(bottomNavIndexProviderProvider);
      expect(result, BottomNavTabType.user);
    });

    test('setTab updates state', () {
      container
          .read(bottomNavIndexProviderProvider.notifier)
          .setTab(BottomNavTabType.meeting);

      final BottomNavTabType result =
          container.read(bottomNavIndexProviderProvider);
      expect(result, BottomNavTabType.meeting);
    });
  });
}
