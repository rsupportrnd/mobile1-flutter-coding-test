part of 'users_bloc.dart';

@freezed
class UsersEvent with _$UsersEvent {
  const factory UsersEvent.load() = _Load;
  const factory UsersEvent.setCurrentUser(String userId) = _SetCurrentUser;
} 