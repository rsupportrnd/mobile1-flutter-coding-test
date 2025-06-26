import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/util/api_util.dart';
import 'package:mobile1_flutter_coding_test/src/data/datasource/local_message_datasource.dart';
import 'package:mobile1_flutter_coding_test/src/data/datasource/meeting_room_datasource.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/meeting_room_list_response_model.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/message_list_response_model.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/message_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/domain/repository/meeting_room_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meeting_room_repository_impl.g.dart';

@riverpod
MeetingRoomRepository meetingRoomRepository(Ref ref) {
  final MeetingRoomDatasource meetingRoomDatasource = ref.read(meetingRoomDatasourceProvider);
  final LocalMessageDatasource localMessageDatasource = ref.read(localMessageDatasourceProvider);
  return MeetingRoomRepositoryImpl(
    meetingRoomDatasource: meetingRoomDatasource,
    localMessageDatasource: localMessageDatasource,
  );
}

class MeetingRoomRepositoryImpl with ApiUtilMixin implements MeetingRoomRepository {
  final MeetingRoomDatasource _meetingRoomDatasource;
  final LocalMessageDatasource _localMessageDatasource;
  const MeetingRoomRepositoryImpl({
    required MeetingRoomDatasource meetingRoomDatasource,
    required LocalMessageDatasource localMessageDatasource,
  })  : _meetingRoomDatasource = meetingRoomDatasource,
        _localMessageDatasource = localMessageDatasource;

  @override
  Future<MeetingRoomListResponseModel> getMeetingRoomList() {
    return safeApiCall(() => _meetingRoomDatasource.getMeetingRoomList());
  }

  @override
  Future<MessageListResponseModel> getMessageList() {
    return safeApiCall(() => _meetingRoomDatasource.getMessageList());
  }

  @override
  Future<List<MessageEntity>> getLocalMessageList({required String roomId}) {
    return _localMessageDatasource.getMessages(roomId: roomId);
  }

  @override
  Future<void> saveMessages({
    required String roomId,
    required List<MessageEntity> messages,
  }) {
    return _localMessageDatasource.saveMessages(
      roomId: roomId,
      messages: messages,
    );
  }
}
