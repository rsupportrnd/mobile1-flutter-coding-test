import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/get_message_usecase.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/my_logger.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/base_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/home/home_state.dart';

class HomeViewmodel extends BaseViewModel<HomeState> {
  final GetMessageUseCase _getMessageUseCase;

  HomeViewmodel({required GetMessageUseCase getMessageUseCase})
      : _getMessageUseCase = getMessageUseCase,
        super(const HomeState());

  @override
  void setLoading(bool isLoading) {}

  _setTab({required MainTab tab}) {
    state = state.copyWith(tab: tab);
  }

  void changeTab({required MainTab tab}) {
    Log.d("changeTab");
    _setTab(tab: tab);
  }

  Future<void> loadMessages() async {
    await runWithResult<List<Message>>(() => _getMessageUseCase(),
        onSuccess: (items) => Log.d("Load Message Success"),
        onFailure: (error) => Log.e(error.toString()));
  }
}
