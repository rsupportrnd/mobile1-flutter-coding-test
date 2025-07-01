import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/common/extensions/extensions.dart';

void main() {
  group('DateTimeExtensions', () {
    test('toYYYYMMDDHHMM', () {
      final DateTime inputDateTime = DateTime(2024, 6, 1, 15, 30);
      final String actualDateString = inputDateTime.toYYYYMMDDHHMM();
      expect(actualDateString, '2024-06-01 15:30');
    });
  });
}
