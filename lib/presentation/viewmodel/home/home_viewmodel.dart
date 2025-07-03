import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/room.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/get_message_usecase.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/get_room_usecase.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/my_logger.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/base_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/loading_manager.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/home/home_state.dart';

class HomeViewmodel extends BaseViewModel<HomeState> {
  final GetMessageUseCase _getMessageUseCase;
  final GetRoomUseCase _getRoomUseCase;
  final LoadingManager _loadingManager;

  HomeViewmodel({
    required GetMessageUseCase getMessageUseCase,
    required GetRoomUseCase getRoomUseCase,
    required LoadingManager loadingManager,
  })  : _getMessageUseCase = getMessageUseCase,
        _getRoomUseCase = getRoomUseCase,
        _loadingManager = loadingManager,
        super(const HomeState());

  @override
  void setLoading(bool isLoading) {
    _loadingManager.isLoading = isLoading;
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
    runWithResult<List<Message>, void>(() => _getMessageUseCase(),
        onSuccess: (items) {
          Log.d("Load Messages 성공!");
        },
        onFailure: (error) => Log.e(error.toString()));
    runWithResult<List<ChatRoom>, void>(() => _getRoomUseCase(),
        onSuccess: (items) {
          Log.d("Load rooms 성공!");
        },
        onFailure: (error) => Log.e(error.toString()));
  }
}
