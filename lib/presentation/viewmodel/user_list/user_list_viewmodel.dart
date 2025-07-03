import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/get_user_usecase.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/my_logger.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/base_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/loading_manager.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/user_list/user_list_state.dart';

class UserListViewModel extends BaseViewModel<UserListState> {
  final GetUserUseCase _getUserUseCase;
  final LoadingManager _loadingManager;

  UserListViewModel({
    required GetUserUseCase getUserUseCase,
    required LoadingManager loadingManager,
  })  : _getUserUseCase = getUserUseCase,
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
    await runWithResult<List<User>, void>(() => _getUserUseCase(),
        onSuccess: (items) => _setItems(list: items),
        onFailure: (error) => Log.e(error.toString()));
  }
}
