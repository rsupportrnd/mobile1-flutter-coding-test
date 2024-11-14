import '../model/model.dart';

abstract interface class MeetingRepository {
  Future<List<MeetingRoom>> fetchMeetingRoom();
}