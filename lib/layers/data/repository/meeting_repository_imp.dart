import 'package:mobile1_flutter_coding_test/common/common.dart';
import 'package:mobile1_flutter_coding_test/layers/data/mapper/user_mapper.dart';
import 'package:mobile1_flutter_coding_test/layers/domain/model/user.dart';

import '../../domain/domain.dart';
import '../../domain/repository/user_repository.dart';
import '../data.dart';
import '../source/source.dart';

class MeetingRepositoryImp implements MeetingRepository {
  final RemoteDataSources _remoteDataSource;

  MeetingRepositoryImp([RemoteDataSources? dataSource])
      : _remoteDataSource = dataSource ?? locator();

  @override
  Future<List<MeetingRoom>> fetchMeetingRoom() async {
      try {
        final response = await _remoteDataSource.fetchMeetingRoom();
        return MeetingMapper.toDomainList(response);
      } catch (e) {
        throw Exception('Failed to load users : $e');
      }
  }
}
