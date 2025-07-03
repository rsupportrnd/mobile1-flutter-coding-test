import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/room.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/get_message_usecase.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/get_room_usecase.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/get_user_usecase.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/my_logger.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/base_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/home/home_state.dart';

class HomeViewmodel extends BaseViewModel<HomeState> {
  final GetMessageUseCase _getMessageUseCase;
  final GetRoomUseCase _getRoomUseCase;
  final GetUserUseCase _getUserUseCase;

  HomeViewmodel({
    required GetMessageUseCase getMessageUseCase,
    required GetRoomUseCase getRoomUseCase,
    required GetUserUseCase getUserUseCase,
  })  : _getMessageUseCase = getMessageUseCase,
        _getRoomUseCase = getRoomUseCase,
        _getUserUseCase = getUserUseCase,
        super(const HomeState());

  @override
  void setLoading(bool isLoading) {
    // _loadingManager.isLoading = isLoading;
  }

  _setTab({required MainTab tab}) {
    Log.d("setTab $tab");
    if (state.tab != tab) {
      state = state.copyWith(tab: tab);
    }
  }

  void changeTab({required MainTab tab}) {
    _setTab(tab: tab);
  }

  Future<void> loadData() async {
    await Future.wait([getMessage(), getRoom(), getUser()]).then((_) {
      Log.d("laodData End");
    });
  }

  Future<void> getMessage() async {
    Log.d("getMessage");
    await runWithResult<List<Message>, void>(() => _getMessageUseCase(),
        onSuccess: (items) {
          Log.d("Load Messages 성공!");
        },
        onFailure: (error) => Log.e(error.toString()));
  }

  Future<void> getRoom() async {
    Log.d("getRoom");
    await runWithResult<List<ChatRoom>, void>(() => _getRoomUseCase(),
        onSuccess: (items) {
          Log.d("Load rooms 성공!");
        },
        onFailure: (error) => Log.e(error.toString()));
  }

  Future<void> getUser() async {
    Log.d("getUser");
    await runWithResult<List<User>, void>(() => _getUserUseCase(),
        onSuccess: (items) {
          Log.d("Load users 성공!");
        },
        onFailure: (error) => Log.e(error.toString()));
  }
}
