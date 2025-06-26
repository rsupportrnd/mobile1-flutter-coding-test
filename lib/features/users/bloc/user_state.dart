part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoadInProgress extends UserState {}

class UserLoadSuccess extends UserState {
  final List<User> users;

  const UserLoadSuccess({required this.users});

  @override
  List<Object?> get props => [users];
}

class UserLoadFailure extends UserState {
  final String errorMessage;

  const UserLoadFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
