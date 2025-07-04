import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/data/utils/retry_when.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/exception.dart';

void main() {
  group('RetryFuture.retryWhen', () {
    test('성공하는 Future는 한 번만 실행된다', () async {
      int callCount = 0;
      Future<int> successfulFuture() async {
        callCount++;
        return 999;
      }

      final result = await (() => successfulFuture()).retryWhen(
        predicate: (error, count, delay) => Future.value(true),
      );

      expect(result, 999);
      expect(callCount, 1);
    });

    test('실패 후 재시도하고 결국 성공한다', () async {
      int callCount = 0;

      Future<int> sometimesFailingFuture() async {
        callCount++;
        if (callCount < 3) {
          throw Exception('fail');
        }
        return 100;
      }

      final result = await (() => sometimesFailingFuture()).retryWhen(
        predicate: (error, count, delay) {
          // 3번째 시도까지 재시도 허용
          return Future.value(count < 3);
        },
      );

      expect(result, 100);
      expect(callCount, 3);
    });

    test('재시도 횟수 초과 시 예외가 던져진다', () async {
      int callCount = 0;

      Future<int> alwaysFailingFuture() async {
        callCount++;
        throw const OverRetryException();
      }

      await expectLater(
        (() => alwaysFailingFuture()).retryWhen(
          predicate: (error, count, delay) => Future.value(count < 2),
        ),
        throwsA(isA<Exception>()),
      );

      expect(callCount, 3); // 0,1,2 번째 호출 (총 3번)
    });
  });
}
