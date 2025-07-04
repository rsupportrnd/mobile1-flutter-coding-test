import 'dart:async';
import 'dart:math';

import 'package:mobile1_flutter_coding_test/domain/entity/exception.dart';

// initialDelay를 retryFactor배 만큼 증가시켜서 retry
extension RetryFuture<T> on Future<T> Function() {
  Future<T> retryWhen({
    double initialDelayMs = 100,
    double retryFactor = 2.0,
    required FutureOr<bool> Function(
            Object error, int retryCount, Duration delay)
        predicate,
  }) async {
    int retryCount = 0;

    while (true) {
      try {
        // this가 고정된 Future라서 첫 번째 호출 실패 후 재시도할 때 같은 Future 인스턴스를 재사용하여 한번 error 시 계속 error
        // this를 Function으로 받아야 함
        return await this();
      } catch (e) {
        final delayMs = initialDelayMs * pow(retryFactor, retryCount);
        final delay = Duration(milliseconds: delayMs.toInt());

        final shouldRetry = await predicate(e, retryCount, delay);
        if (!shouldRetry) throw const OverRetryException();

        retryCount++;
        await Future.delayed(delay);
      }
    }
  }
}
