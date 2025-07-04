import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/select_user_usecase.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/my_logger.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/toast_service.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/base_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/loading_manager.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/user_list/user_list_state.dart';

class UserListViewModel extends BaseViewModel<UserListState> {
  final SelectUserUseCase _selectUserUseCase;
  final LoadingManager _loadingManager;
  final ToastService _toastService;

  UserListViewModel({
    required SelectUserUseCase selectUserUseCase,
    required LoadingManager loadingManager,
    required ToastService toastService,
  })  : _selectUserUseCase = selectUserUseCase,
        _loadingManager = loadingManager,
        _toastService = toastService,
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
        onFailure: (error) {
          Log.e(error.toString());
          _toastService.show("데이터베이스에서 User 데이터를 불러오지 못했습니다.");
        });
  }
}
