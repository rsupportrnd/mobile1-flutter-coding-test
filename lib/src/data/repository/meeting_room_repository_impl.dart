import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/util/api_util.dart';
import 'package:mobile1_flutter_coding_test/src/data/datasource/meeting_room_datasource.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/meeting_room_list_response_model.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/message_list_response_model.dart';
import 'package:mobile1_flutter_coding_test/src/domain/repository/meeting_room_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meeting_room_repository_impl.g.dart';

@riverpod
MeetingRoomRepository meetingRoomRepository(Ref ref) {
  final MeetingRoomDatasource datasource = ref.read(meetingRoomDatasourceProvider);
  return MeetingRoomRepositoryImpl(datasource: datasource);
}

class MeetingRoomRepositoryImpl with ApiUtilMixin implements MeetingRoomRepository {
  final MeetingRoomDatasource _datasource;

  const MeetingRoomRepositoryImpl({
    required final MeetingRoomDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<MeetingRoomListResponseModel> getMeetingRoomList() {
    return safeApiCall(() => _datasource.getMeetingRoomList());
  }

  @override
  Future<MessageListResponseModel> getMessageList() {
    return safeApiCall(() => _datasource.getMessageList());
  }
}
