import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/util/api_util.dart';
import 'package:mobile1_flutter_coding_test/src/data/data.dart';
import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meeting_room_repository_impl.g.dart';

@riverpod
MeetingRoomRepository meetingRoomRepository(Ref ref) {
  final MeetingRoomDatasource meetingRoomDatasource = ref.read(meetingRoomDatasourceProvider);
  return MeetingRoomRepositoryImpl(meetingRoomDatasource: meetingRoomDatasource);
}

class MeetingRoomRepositoryImpl with ApiUtilMixin implements MeetingRoomRepository {
  final MeetingRoomDatasource _meetingRoomDatasource;
  const MeetingRoomRepositoryImpl({
    required MeetingRoomDatasource meetingRoomDatasource,
  }) : _meetingRoomDatasource = meetingRoomDatasource;

  @override
  Future<MeetingRoomListResponseEntity> getMeetingRoomList() {
    return safeApiCall<MeetingRoomListResponseEntity>(() async {
      final MeetingRoomListResponseModel model = await _meetingRoomDatasource.getMeetingRoomList();
      return MeetingRoomMapper.meetingRoomListModelToEntity(model);
    });
  }
}
