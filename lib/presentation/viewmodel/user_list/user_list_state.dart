import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/base_state.dart';

part 'user_list_state.freezed.dart';

@freezed
abstract class UserListState with _$UserListState implements BaseState {
  const factory UserListState(
      {@Default(false) bool isLoading,
      @Default([]) List<User> items}) = _UserListState;
}
