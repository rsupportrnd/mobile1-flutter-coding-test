part of 'users_bloc.dart';

@freezed
class UsersState with _$UsersState {
  const factory UsersState({
    @Default(false) bool loading,
    @Default([]) List<dynamic> users,
    @Default('') String currentUserId,
    String? error,
  }) = _UsersState;
} 