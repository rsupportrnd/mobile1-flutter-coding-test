import 'package:mobile1_flutter_coding_test/index.dart';


part 'user_list_state.dart';
part 'user_list_cubit.freezed.dart';

class UserListCubit extends Cubit<UserListState> {
  // final UserRepository _userRepository;
  // UserListCubit(this._userRepository) : super(const UserListState.initial());
  UserListCubit() : super(const UserListState.initial());

  UserRepository _userRepository = UserRepositoryImpl();
  set userRepository(UserRepository userRepository) {
    _userRepository = userRepository;
  }

  Future<void> fetchUsers() async {
    emit(const UserListState.loading());
    try {
      _userRepository.fetchUsers().then((users) {
        emit(UserListState.loaded(users));
      });
    } catch (e) {
      emit(UserListState.error(e.toString()));
    }
  }
}
