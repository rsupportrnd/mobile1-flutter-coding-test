import 'package:mobile1_flutter_coding_test/common/network/custom_exceptions.dart';
import 'package:mobile1_flutter_coding_test/common/viewmodel/base_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/common/viewmodel/viewmodel_state.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/user_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_users_usecase.dart';

class UserListViewModel extends BaseViewModel {
  final GetUsersUseCase getUsersUseCase;
  ViewModelState<List<UserEntity>> _users = ViewModelState.loading();
  ViewModelState<List<UserEntity>> get usersState => _users;

  UserListViewModel({
    required this.getUsersUseCase,
  }) {
    fetchUsers();
  }

  void setUsers(ViewModelState<List<UserEntity>> state) {
    _users = state;
    notifyListeners();
  }

  void fetchUsers() async {
    try {
      setUsers(ViewModelState.success(data: await getUsersUseCase.call()));
    } on NetworkException catch (e) {
      setUsers(ViewModelState.error(error: e.message));
    } on UnknownException catch (e) {
      setUsers(ViewModelState.error(error: e.message));
    } catch (e) {
      setUsers(ViewModelState.error(error: e.toString()));
    }
  }
}
