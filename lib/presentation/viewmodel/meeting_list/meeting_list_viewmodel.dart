import 'package:mobile1_flutter_coding_test/domain/entity/room.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/select_room_usecase.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/my_logger.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/base_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/loading_manager.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/meeting_list/meeting_list_state.dart';

class MeetingListViewModel extends BaseViewModel<MeetingListState> {
  final SelectRoomUseCase _selectRoomUseCase;
  final LoadingManager _loadingManager;

  MeetingListViewModel({
    required SelectRoomUseCase selectRoomUseCase,
    required LoadingManager loadingManager,
  })  : _selectRoomUseCase = selectRoomUseCase,
        _loadingManager = loadingManager,
        super(const MeetingListState());

  @override
  void setLoading(bool isLoading) {
    _loadingManager.isLoading = isLoading;
  }

  _setItems({required List<ChatRoom> list}) {
    Log.d("_setItems ${list.length}");
    state = state.copyWith(items: list);
  }

  Future<void> loadMeetings() async {
    Log.d("loadMeetings");
    await runWithResult<List<ChatRoom>, void>(() => _selectRoomUseCase(),
        onSuccess: (items) => _setItems(list: items),
        onFailure: (error) => Log.e(error.toString()));
  }
}
