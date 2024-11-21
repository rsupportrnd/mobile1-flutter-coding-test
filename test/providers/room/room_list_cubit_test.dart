import 'package:bloc_test/bloc_test.dart';
import 'package:mobile1_flutter_coding_test/models/room/room_model.dart';
import 'package:mobile1_flutter_coding_test/providers/room/room_list_cubit.dart';
import 'package:mobile1_flutter_coding_test/repositories/room/room_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/services/room/room_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';


class MockRoomRepository extends Mock implements RoomRepositoryImpl {}
class MockRoomModel extends Mock implements RoomModel {}


void main() {
  late RoomListCubit roomListCubit;
  late RoomService roomService;
  late MockRoomRepository mockRoomRepository;
  late List<RoomModel> rooms = [];

  setUp(() {
    mockRoomRepository = MockRoomRepository();
    roomService = RoomService(mockRoomRepository);
    roomListCubit = RoomListCubit(roomService);

    RoomModel room1 = MockRoomModel();
    RoomModel room2 = MockRoomModel();
    RoomModel room3 = MockRoomModel();
    rooms = [room1, room2, room3];
  });

  tearDown(() {
    roomListCubit.close();
  });

  group('RoomListCubit_Group', (){
    blocTest<RoomListCubit, RoomListState>(
      'RoomListCubit이 정상적으로 loading -> loaded로 변경 함',
      build: () {
        when(() => mockRoomRepository.fetchRooms()).thenAnswer((_) async => rooms);
        return roomListCubit;
      },
      act: (cubit) => cubit.fetchRooms(),
      expect: () => [
        const RoomListState.loading(),
        RoomListState.loaded(rooms),
      ],
    );

    blocTest<RoomListCubit, RoomListState>(
      'UserListCubit이 실패해서 loading -> error로 변경 함',
      build: () {
        when(() => mockRoomRepository.fetchRooms()).thenThrow(Exception('Failed to fetch rooms'));
        return roomListCubit;
      },
      act: (cubit) => cubit.fetchRooms(),
      expect: () => [
        const RoomListState.loading(),
        const RoomListState.error('Exception: Failed to fetch rooms'),
      ],
    );
  });
}