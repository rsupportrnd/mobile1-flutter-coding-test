import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'option_list_notifier_provider.g.dart';

@riverpod
class OptionStateListNotifier extends _$OptionStateListNotifier {
  @override
  List<bool> build() {
    /// init state
    return [false, true, false, false, false, false, false, false];
  }

  void setOptionAtIndex(int index, value) {
    final tempList = <bool>[];
    tempList.addAll(state);

    tempList[index] = value;
    state = tempList;
  }
}
