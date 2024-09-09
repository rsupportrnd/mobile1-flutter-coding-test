

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'option_list_notifier_provider.g.dart';

@riverpod
class OptionStateListNotifierProvider extends _$OptionStateListNotifierProvider {
  List<bool> _stateList = [false, true, false, false, false, false, false, false];
  @override
  List<bool> build() {
    return _stateList;
  }

  void toggleAtIndex(int index) {
    _stateList[index] = !_stateList[index];
    state = _stateList;
  }
}
