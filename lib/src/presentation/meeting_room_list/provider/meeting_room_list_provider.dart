import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/meeting_room_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/message_list_response_entity.dart';
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
    MessageUseCase? messageUseCase,
  }) async {
    final MeetingRoomUseCase useCase =
        meetingRoomUseCase ?? ref.read(meetingRoomUseCaseProvider);
    final MessageUseCase msgUseCase =
        messageUseCase ?? ref.read(messageUseCaseProvider);

    final MeetingRoomListResponseEntity responseEntity =
        await useCase.getMeetingRoomList();

    // 로컬 메시지 기반 lastMessage 갱신
    final List<MeetingRoomEntity> updatedRooms = await Future.wait(
      responseEntity.meetingRooms.map((room) async {
        return await _updateRoomWithLocalLastMessage(
          room: room,
          messageUseCase: msgUseCase,
        );
      }),
    );

    final MeetingRoomListResponseEntity updatedEntity =
        responseEntity.copyWith(meetingRooms: updatedRooms);

    return _sortByRecentMessage(updatedEntity);
  }

  Future<void> getUserList() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchUserList());
  }

  void updateLastMessage({required MessageEntity messageEntity}) {
    final AsyncValue<MeetingRoomListResponseEntity> currentState = state;

    if (!currentState.hasValue) return;

    bool updated = false;

    final MeetingRoomListResponseEntity currentEntity =
        currentState.requireValue;

    final List<MeetingRoomEntity> updatedRooms = currentEntity.meetingRooms.map(
      (final MeetingRoomEntity room) {
        if (room.roomId == messageEntity.roomId) {
          updated = true;
          return room.copyWith(
              lastMessage: LastMessageEntity(
            sender: messageEntity.sender,
            content: messageEntity.content,
            timestamp: messageEntity.timestamp,
          ));
        }
        return room;
      },
    ).toList();

    //변경이 필요할때만 변경
    if (!updated) return;

    final MeetingRoomListResponseEntity updatedEntity =
        currentEntity.copyWith(meetingRooms: updatedRooms);

    state = AsyncData(_sortByRecentMessage(updatedEntity));
  }

  // 최근 메시지순으로 내림차순 정렬
  MeetingRoomListResponseEntity _sortByRecentMessage(
    final MeetingRoomListResponseEntity entity,
  ) {
    final List<MeetingRoomEntity> sortedRooms = [...entity.meetingRooms]..sort(
        (MeetingRoomEntity a, MeetingRoomEntity b) =>
            b.lastMessage.timestamp.compareTo(a.lastMessage.timestamp),
      );
    return entity.copyWith(meetingRooms: sortedRooms);
  }

  /// 로컬 메시지 기반 lastMessage 업데이트 함수
  Future<MeetingRoomEntity> _updateRoomWithLocalLastMessage({
    required MeetingRoomEntity room,
    required MessageUseCase messageUseCase,
  }) async {
    final List<MessageEntity> localMessages =
        await messageUseCase.getLocalMessages(roomId: room.roomId);

    if (localMessages.isEmpty) return room;

    final MessageEntity first = localMessages.first;

    final bool isSame = room.lastMessage.sender == first.sender &&
        room.lastMessage.content == first.content &&
        room.lastMessage.timestamp == first.timestamp;

    if (isSame) return room;

    return room.copyWith(
      lastMessage: LastMessageEntity(
        sender: first.sender,
        content: first.content,
        timestamp: first.timestamp,
      ),
    );
  }
}
