import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/di/service_provider.dart';
import 'package:mobile1_flutter_coding_test/di/usecase_provider.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/chat/chat_state.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/chat/chat_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/home/home_state.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/home/home_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/meeting_list/meeting_list_state.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/meeting_list/meeting_list_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/user_list/user_list_state.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/user_list/user_list_viewmodel.dart';

final homeViewModelProvider =
    StateNotifierProvider<HomeViewmodel, HomeState>((ref) {
  final getMessageUseCase = ref.watch(getMessageUseCaseProvider);
  final getRoomUseCase = ref.watch(getRoomUseCaseProvider);
  final getUserUseCase = ref.watch(getUserUseCaseProvider);
  final selectMessageUseCase = ref.watch(selectMessageUseCaseProvider);
  final selectRoomUseCase = ref.watch(selectRoomUseCaseProvider);
  final selectUserUseCase = ref.watch(selectUserUseCaseProvider);
  final toastService = ref.read(toastServiceProvider);

  return HomeViewmodel(
    getMessageUseCase: getMessageUseCase,
    getRoomUseCase: getRoomUseCase,
    getUserUseCase: getUserUseCase,
    selectMessageUseCase: selectMessageUseCase,
    selectRoomUseCase: selectRoomUseCase,
    selectUserUseCase: selectUserUseCase,
    toastService: toastService,
  );
});

final userListViewModelProvider =
    StateNotifierProvider<UserListViewModel, UserListState>((ref) {
  final selectUserUseCase = ref.watch(selectUserUseCaseProvider);
  final loadingManager = ref.read(loadingManagerProvider);
  final toastService = ref.read(toastServiceProvider);

  return UserListViewModel(
    selectUserUseCase: selectUserUseCase,
    loadingManager: loadingManager,
    toastService: toastService,
  );
});

final meetingListViewModelProvider =
    StateNotifierProvider<MeetingListViewModel, MeetingListState>((ref) {
  final selectRoomUseCase = ref.watch(selectRoomUseCaseProvider);
  final loadingManager = ref.read(loadingManagerProvider);
  final toastService = ref.read(toastServiceProvider);

  return MeetingListViewModel(
    selectRoomUseCase: selectRoomUseCase,
    loadingManager: loadingManager,
    toastService: toastService,
  );
});

final chatViewModelProvider =
    StateNotifierProvider.autoDispose<ChatViewModel, ChatState>((ref) {
  final selectMessageUseCase = ref.watch(selectMessagesByRoomIdUseCaseProvider);
  final insertMessageUseCase = ref.watch(insertMessageUseCaseProvider);
  final loadingManager = ref.read(loadingManagerProvider);
  final toastService = ref.read(toastServiceProvider);

  return ChatViewModel(
    selectMessageUseCase: selectMessageUseCase,
    insertMessageUseCase: insertMessageUseCase,
    loadingManager: loadingManager,
    toastService: toastService,
  );
});
