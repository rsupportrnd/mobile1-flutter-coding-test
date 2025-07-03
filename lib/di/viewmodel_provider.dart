import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/di/usecase_provider.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/chat/chat_state.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/chat/chat_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/loading_manager.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/home/home_state.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/home/home_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/meeting_list/meeting_list_state.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/meeting_list/meeting_list_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/user_list/user_list_state.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/user_list/user_list_viewmodel.dart';

final globalLoadingProvider = StateProvider<bool>((ref) => false);

final loadingManagerProvider = Provider<LoadingManager>((ref) {
  return LoadingManagerImpl(ref);
});

final homeViewModelProvider =
    StateNotifierProvider<HomeViewmodel, HomeState>((ref) {
  final getMessageUseCase = ref.watch(getMessageUseCaseProvider);
  final getRoomUseCase = ref.watch(getRoomUseCaseProvider);
  final getUserUseCase = ref.watch(getUserUseCaseProvider);

  return HomeViewmodel(
    getMessageUseCase: getMessageUseCase,
    getRoomUseCase: getRoomUseCase,
    getUserUseCase: getUserUseCase,
  );
});

final userListViewModelProvider =
    StateNotifierProvider<UserListViewModel, UserListState>((ref) {
  final selectUserUseCase = ref.watch(selectUserUseCaseProvider);
  final loadingManager = ref.read(loadingManagerProvider);

  return UserListViewModel(
    selectUserUseCase: selectUserUseCase,
    loadingManager: loadingManager,
  );
});

final meetingListViewModelProvider =
    StateNotifierProvider<MeetingListViewModel, MeetingListState>((ref) {
  final selectRoomUseCase = ref.watch(selectRoomUseCaseProvider);
  final loadingManager = ref.read(loadingManagerProvider);

  return MeetingListViewModel(
    selectRoomUseCase: selectRoomUseCase,
    loadingManager: loadingManager,
  );
});

final chatViewModelProvider =
    StateNotifierProvider.autoDispose<ChatViewModel, ChatState>((ref) {
  final selectMessageUseCase = ref.watch(selectMessageUseCaseProvider);
  final insertMessageUseCase = ref.watch(insertMessageUseCaseProvider);
  final loadingManager = ref.read(loadingManagerProvider);

  return ChatViewModel(
    selectMessageUseCase: selectMessageUseCase,
    insertMessageUseCase: insertMessageUseCase,
    loadingManager: loadingManager,
  );
});
