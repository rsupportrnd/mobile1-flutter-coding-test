import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

enum MainTab { users, meetings }

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({@Default(MainTab.users) MainTab tab}) = _HomeState;
}
