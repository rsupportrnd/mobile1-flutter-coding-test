import 'package:mobile1_flutter_coding_test/index.dart';
import 'package:mobile1_flutter_coding_test/services/user/user_service.dart';

part 'user_list_state.dart';

part 'user_list_cubit.freezed.dart';

@injectable
class UserListCubit extends Cubit<UserListState> {
  final UserService _userService;

  UserListCubit(this._userService) : super(const UserListState.initial());

  Future<void> fetchUsers() async {
    emit(const UserListState.loading());
    try {
      List<UserModel> response = await _userService.fetUsers();
      emit(UserListState.loaded(response));
    } catch (e) {
      emit(UserListState.error(e.toString()));
    }
  }
}
