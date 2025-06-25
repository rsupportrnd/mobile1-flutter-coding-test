import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_nav_index_provider.g.dart';

enum BottomNavTabType {
  user,
  meeting,
}

@Riverpod(keepAlive: true)
class BottomNavIndexProvider extends _$BottomNavIndexProvider {
  @override
  BottomNavTabType build() {
    return BottomNavTabType.user;
  }

  void setTab(BottomNavTabType tab) {
    state = tab;
  }
}
