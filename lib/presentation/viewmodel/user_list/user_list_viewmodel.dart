import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/get_user_usecase.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/my_logger.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/base_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/user_list/user_list_state.dart';

class UserListViewModel extends BaseViewModel<UserListState> {
  final GetUserUseCase _getUserUseCase;

  UserListViewModel({
    required GetUserUseCase getUserUseCase,
  })  : _getUserUseCase = getUserUseCase,
        super(const UserListState());

  @override
  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  _setItems({required List<User> list}) {
    state = state.copyWith(items: list);
  }

  Future<void> loadUsers() async {
    await runWithResult<List<User>>(() => _getUserUseCase(),
        onSuccess: (items) => _setItems(list: items),
        onFailure: (error) => Log.e(error.toString()));
  }
}
