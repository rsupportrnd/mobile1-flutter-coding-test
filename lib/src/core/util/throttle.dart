import 'dart:async';

/// [Throttle] 은 지정된 시간동안 이벤트를 제한하는 클래스
class Throttle {
  Throttle({required this.delay});
  final Duration delay;
  bool waiting = false;
  // ignore: unused_field
  Timer? _timer;

  void run(Function action) {
    // 타이머를 기다리지 않을 때만
    if (!waiting) {
      // action을 실행하고 이벤트를 기다림
      action();
      waiting = true;

      // 지정된 시간이 지나면 waiting을 풀어줌
      _timer = Timer(delay, () {
        waiting = false;
      });
    }
  }
}
