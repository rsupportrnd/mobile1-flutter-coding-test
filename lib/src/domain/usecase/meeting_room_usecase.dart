import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/meeting_room_list_response_model.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/message_list_response_model.dart';
import 'package:mobile1_flutter_coding_test/src/data/repository/meeting_room_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/src/domain/repository/meeting_room_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meeting_room_usecase.g.dart';

@riverpod
Future<MeetingRoomListResponseModel> getMeetingRoomListUseCase(Ref ref) {
  final MeetingRoomRepository repository = ref.read(meetingRoomRepositoryProvider);
  return repository.getMeetingRoomList();
}

@riverpod
Future<MessageListResponseModel> getMessageListUseCase(Ref ref) {
  final MeetingRoomRepository repository = ref.read(meetingRoomRepositoryProvider);
  return repository.getMessageList();
}
