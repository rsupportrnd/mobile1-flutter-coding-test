part of 'rooms_bloc.dart';

@freezed
class RoomsEvent with _$RoomsEvent {
  const factory RoomsEvent.load() = _Load;
  const factory RoomsEvent.setCurrentUser(String userId) = _SetCurrentUser;
} 