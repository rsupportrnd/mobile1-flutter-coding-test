part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.start() = _Start;
  const factory HomeEvent.move(int idx) = _Move;
  const factory HomeEvent.switchUser(String userId) = _SwitchUser;
}
