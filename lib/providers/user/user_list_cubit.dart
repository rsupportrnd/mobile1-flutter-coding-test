import 'package:mobile1_flutter_coding_test/index.dart';

part 'user_list_state.dart';

part 'user_list_cubit.freezed.dart';

@injectable
class UserListCubit extends Cubit<UserListState> {
  final UserService _userService;

  UserListCubit(this._userService) : super(const UserListState.initial());

  Future<void> fetchUsers() async {
    emit(const UserListState.loading());
    try {
      List<UserModel> users = await _userService.fetUsers();
      if(!isClosed) {
        emit(UserListState.loaded(users));
      }
    } catch (e) {
      emit(UserListState.error(e.toString()));
    }
  }
}
