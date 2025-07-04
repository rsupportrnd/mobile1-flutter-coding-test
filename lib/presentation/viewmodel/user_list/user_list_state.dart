import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';

part 'user_list_state.freezed.dart';

@freezed
abstract class UserListState with _$UserListState {
  const factory UserListState({@Default([]) List<User> items}) = _UserListState;
}
