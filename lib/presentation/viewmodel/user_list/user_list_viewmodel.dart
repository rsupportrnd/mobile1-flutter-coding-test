import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/select_user_usecase.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/my_logger.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/base_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/loading_manager.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/user_list/user_list_state.dart';

class UserListViewModel extends BaseViewModel<UserListState> {
  final SelectUserUseCase _selectUserUseCase;
  final LoadingManager _loadingManager;

  UserListViewModel({
    required SelectUserUseCase selectUserUseCase,
    required LoadingManager loadingManager,
  })  : _selectUserUseCase = selectUserUseCase,
        _loadingManager = loadingManager,
        super(const UserListState());

  @override
  void setLoading(bool isLoading) {
    _loadingManager.isLoading = isLoading;
  }

  _setItems({required List<User> list}) {
    state = state.copyWith(items: list);
  }

  Future<void> loadUsers() async {
    Log.d("loadUsers");
    await runWithResult<List<User>, void>(() => _selectUserUseCase(),
        onSuccess: (items) => _setItems(list: items),
        onFailure: (error) => Log.e(error.toString()));
  }
}
