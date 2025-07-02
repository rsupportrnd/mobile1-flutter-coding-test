import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MainTab { users, meetings }

class HomeViewmodel extends StateNotifier<MainTab> {
  HomeViewmodel() : super(MainTab.users);

  @override
  set state(MainTab value) {
    super.state = value;
  }
}
