import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/di/usecase_provider.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/select_message_usecase.dart';
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

  return HomeViewmodel(getMessageUseCase: getMessageUseCase);
});

final userListViewModelProvider =
    StateNotifierProvider<UserListViewModel, UserListState>((ref) {
  final getUserUseCase = ref.watch(getUserUseCaseProvider);

  return UserListViewModel(
    getUserUseCase: getUserUseCase,
  );
});

final meetingListViewModelProvider =
    StateNotifierProvider<MeetingListViewModel, MeetingListState>((ref) {
  final getRoomUseCase = ref.watch(getRoomUseCaseProvider);

  return MeetingListViewModel(
    getRoomUseCase: getRoomUseCase,
  );
});

final chatViewModelProvider =
    StateNotifierProvider<ChatViewModel, ChatState>((ref) {
  final selectMessageUseCase = ref.watch(selectMessageUseCaseProvider);
  final insertMessageUseCase = ref.watch(insertMessageUseCaseProvider);

  return ChatViewModel(
      selectMessageUseCase: selectMessageUseCase,
      insertMessageUseCase: insertMessageUseCase);
});
