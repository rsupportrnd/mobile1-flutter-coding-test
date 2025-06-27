import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/data/data.dart';
import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meeting_room_usecase.g.dart';

@riverpod
MeetingRoomUseCase meetingRoomUseCase(Ref ref) {
  final MeetingRoomRepository meetingRoomRepository = ref.read(meetingRoomRepositoryProvider);
  return MeetingRoomUseCase(meetingRoomRepository: meetingRoomRepository);
}

class MeetingRoomUseCase {
  final MeetingRoomRepository meetingRoomRepository;

  MeetingRoomUseCase({required this.meetingRoomRepository});

  Future<MeetingRoomListResponseEntity> getMeetingRoomList() async {
    return await meetingRoomRepository.getMeetingRoomList();
  }
}
