import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/meeting_room_list_response_model.dart';
import 'package:mobile1_flutter_coding_test/src/data/repository/meeting_room_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/meeting_room_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/domain/repository/meeting_room_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meeting_room_usecase.g.dart';

@riverpod
MeetingRoomUseCase meetingRoomUseCase(Ref ref) {
  final MeetingRoomRepository meetingRoomRepository =
      ref.read(meetingRoomRepositoryProvider);
  return MeetingRoomUseCase(meetingRoomRepository: meetingRoomRepository);
}

class MeetingRoomUseCase {
  final MeetingRoomRepository meetingRoomRepository;

  MeetingRoomUseCase({required this.meetingRoomRepository});

  Future<MeetingRoomListResponseEntity> getMeetingRoomList() async {
    final MeetingRoomListResponseModel response =
        await meetingRoomRepository.getMeetingRoomList();
    return MeetingRoomListResponseEntity.fromModel(response);
  }
}
