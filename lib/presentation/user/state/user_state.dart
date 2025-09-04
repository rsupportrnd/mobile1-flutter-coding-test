import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';

class UserState {
  final List<User> users;

  UserState({required this.users});

  UserState copyWith(
      {List<User>? users, bool? isLoading = false, String? code}) {
    return UserState(
      users: users ?? this.users,
    );
  }
}
