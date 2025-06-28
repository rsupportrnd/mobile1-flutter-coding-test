import 'package:mobile1_flutter_coding_test/app/index.dart';

class RoomRepositoryImpl implements RoomRepository {
  final RoomRemoteDataSource remoteDataSource;
  final RoomLocalDataSource localDataSource;

  RoomRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Room>> fetchRooms() async {
    // 1) 원격 API에서 방 목록 받아오기
    final remoteRooms = await remoteDataSource.fetchRooms();

    // 2) 로컬 DB에서 방별 마지막 메시지 모두 받아오기
    final localLastMessages = await localDataSource.fetchAllLastMessages();
    print("localLastMessages.length");
    print(localLastMessages.length);

    // 3) 로컬 DB에 저장된 lastMessage가 있으면 덮어씌움
    final updatedRooms = remoteRooms.map((room) {
      if (localLastMessages.containsKey(room.roomId)) {
        return room.copyWith(lastMessage: localLastMessages[room.roomId]!);
      }
      return room;
    }).toList();

    // 4) lastMessage.timestamp 기준으로 내림차순 정렬
    updatedRooms.sort(
          (a, b) => b.lastMessage.timestamp.compareTo(a.lastMessage.timestamp),
    );

    return updatedRooms;
  }

  @override
  Future<void> saveLastMessage(String roomId, LastMessage lastMessage) {
    return localDataSource.saveLastMessage(roomId, lastMessage);
  }
}
