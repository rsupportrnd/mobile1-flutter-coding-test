import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/meeting_room_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/domain/usecase/meeting_room_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meeting_room_list_provider.g.dart';

@Riverpod(keepAlive: true)
class MeetingRoomList extends _$MeetingRoomList {
  @override
  Future<MeetingRoomListResponseEntity> build() async {
    return await _fetchUserList();
  }

  Future<MeetingRoomListResponseEntity> _fetchUserList({
    MeetingRoomUseCase? meetingRoomUseCase,
  }) async {
    final MeetingRoomUseCase useCase =
        meetingRoomUseCase ?? ref.read(meetingRoomUseCaseProvider);
    return await useCase.getMeetingRoomList();
  }

  Future<void> getUserList() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchUserList());
  }
}
