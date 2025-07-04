import 'dart:async';
import 'dart:math';

// initialDelay를 retryFactor배 만큼 증가시켜서 retry
extension RetryFuture<T> on Future<T> {
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
        return await this;
      } catch (e) {
        final delayMs = initialDelayMs * pow(retryFactor, retryCount);
        final delay = Duration(milliseconds: delayMs.toInt());

        final shouldRetry = await predicate(e, retryCount, delay);
        if (!shouldRetry) rethrow;

        retryCount++;
        await Future.delayed(delay);
      }
    }
  }
}
