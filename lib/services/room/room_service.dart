import 'package:mobile1_flutter_coding_test/index.dart';

@injectable
class RoomService {
  final RoomRepository _roomRepository;

  RoomService(this._roomRepository);

  Future<List<RoomModel>> fetchRooms() async {
    return await _roomRepository.fetchRooms();
  }

  String convertFormatTimeDiff(String timestamp) {
    final now = DateTime.now();
    final diff = now.difference(DateTime.parse(timestamp));

    if (diff.inMinutes < 1) {
      return 'Just now';
    } else if (diff.inHours < 1) {
      return '${diff.inMinutes}분전';
    } else if (diff.inDays < 1) {
      return '${diff.inHours}시간전';
    } else if (diff.inDays <= 31) {
      return '${diff.inDays}일전';
    } else {
      return '옛날';
    }
  }
}
