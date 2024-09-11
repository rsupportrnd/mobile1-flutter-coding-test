import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'switch_notifier.g.dart';

@riverpod
class SwitchNotifier extends _$SwitchNotifier {
  @override
  bool build() {
    return false;
  }

  setSwitch(bool value) {
    state = value;
  }
}
