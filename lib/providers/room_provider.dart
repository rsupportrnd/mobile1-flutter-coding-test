import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/room.dart';
import '../utils/logger.dart';
import 'repository_providers.dart';

// Room 상태 관리

class RoomsState {
  final List<Room> rooms;
  final bool isLoading;
  final String? error;
  final String searchQuery;
  final RoomFilter filter;
  final RoomSortType sortType;

  RoomsState({
    this.rooms = const [],
    this.isLoading = false,
    this.error,
    this.searchQuery = '',
    this.filter = RoomFilter.all,
    this.sortType = RoomSortType.lastActivity,
  });

  RoomsState copyWith({
    List<Room>? rooms,
    bool? isLoading,
    String? error,
    String? searchQuery,
    RoomFilter? filter,
    RoomSortType? sortType,
  }) {
    return RoomsState(
      rooms: rooms ?? this.rooms,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      searchQuery: searchQuery ?? this.searchQuery,
      filter: filter ?? this.filter,
      sortType: sortType ?? this.sortType,
    );
  }

  List<Room> get filteredAndSortedRooms {
    var filteredRooms = rooms;

    // 검색 필터링
    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filteredRooms = filteredRooms.where((room) {
        return room.name.toLowerCase().contains(query) ||
               (room.description?.toLowerCase().contains(query) ?? false) ||
               room.creator.toLowerCase().contains(query);
      }).toList();
    }

    // 상태 필터링
    switch (filter) {
      case RoomFilter.active:
        filteredRooms = filteredRooms.where((room) => room.isActive).toList();
        break;
      case RoomFilter.inactive:
        filteredRooms = filteredRooms.where((room) => !room.isActive).toList();
        break;
      case RoomFilter.all:
        break;
    }

    // 정렬
    switch (sortType) {
      case RoomSortType.name:
        filteredRooms.sort((a, b) => a.name.compareTo(b.name));
        break;
      case RoomSortType.participantCount:
        filteredRooms.sort((a, b) => b.participantCount.compareTo(a.participantCount));
        break;
      case RoomSortType.lastActivity:
        filteredRooms.sort((a, b) {
          final aTime = a.lastMessageTime;
          final bTime = b.lastMessageTime;
          
          if (aTime == null && bTime == null) return 0;
          if (aTime == null) return 1;
          if (bTime == null) return -1;
          
          return bTime.compareTo(aTime);
        });
        break;
    }

    return filteredRooms;
  }
}

/// Room 필터 타입
enum RoomFilter {
  all,
  active,
  inactive,
}

/// Room 정렬 타입
enum RoomSortType {
  name,
  participantCount,
  lastActivity,
}

/// Room 목록 관리 Notifier
class RoomsNotifier extends StateNotifier<RoomsState> {
  final RoomRepository _roomRepository;

  RoomsNotifier(this._roomRepository) : super(RoomsState());

  /// Room 목록 로드
  Future<void> loadRooms() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      Logger.info('룸 목록 로드 시작');
      final rooms = await _roomRepository.getRooms();
      state = state.copyWith(
        rooms: rooms,
        isLoading: false,
      );
      Logger.info('룸 목록 로드 완료: ${rooms.length}개');
    } catch (e) {
      Logger.error('룸 목록 로드 실패', error: e);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Room 검색
  void searchRooms(String query) {
    state = state.copyWith(searchQuery: query);
    Logger.debug('룸 검색: "$query"');
  }

  /// 룸 목록 새로고침
  Future<void> refreshRooms() async {
    Logger.info('룸 목록 새로고침');
    await _roomRepository.refreshRooms();
    await loadRooms();
  }
}

// 현재 선택된 Room 상태 관리

class CurrentRoomState {
  final Room? currentRoom;
  final bool isLoading;
  final String? error;

  CurrentRoomState({
    this.currentRoom,
    this.isLoading = false,
    this.error,
  });

  CurrentRoomState copyWith({
    Room? currentRoom,
    bool? isLoading,
    String? error,
  }) {
    return CurrentRoomState(
      currentRoom: currentRoom ?? this.currentRoom,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class CurrentRoomNotifier extends StateNotifier<CurrentRoomState> {
  final RoomRepository _roomRepository;

  CurrentRoomNotifier(this._roomRepository) : super(CurrentRoomState());

  /// Room 선택
  Future<void> selectRoom(String roomId) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      Logger.info('룸 선택: $roomId');
      final room = await _roomRepository.getRoomById(roomId);
      
      if (room != null) {
        state = state.copyWith(
          currentRoom: room,
          isLoading: false,
        );
        Logger.info('룸 선택 완료: ${room.name}');
      } else {
        state = state.copyWith(
          isLoading: false,
          error: '룸을 찾을 수 없습니다',
        );
        Logger.warning('룸을 찾을 수 없음: $roomId');
      }
    } catch (e) {
      Logger.error('룸 선택 실패', error: e);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Room 선택 해제
  void clearRoom() {
    state = state.copyWith(currentRoom: null);
    Logger.info('룸 선택 해제');
  }
}

// Provider 정의

final roomsProvider = StateNotifierProvider<RoomsNotifier, RoomsState>((ref) {
  final roomRepository = ref.watch(roomRepositoryProvider);
  return RoomsNotifier(roomRepository);
});

final currentRoomProvider = StateNotifierProvider<CurrentRoomNotifier, CurrentRoomState>((ref) {
  final roomRepository = ref.watch(roomRepositoryProvider);
  return CurrentRoomNotifier(roomRepository);
});

final filteredRoomsProvider = Provider<List<Room>>((ref) {
  return ref.watch(roomsProvider).filteredAndSortedRooms;
});

final currentRoomDataProvider = Provider<Room?>((ref) {
  return ref.watch(currentRoomProvider).currentRoom;
});

final currentRoomIdProvider = Provider<String?>((ref) {
  return ref.watch(currentRoomProvider).currentRoom?.id;
});

final activeRoomsProvider = Provider<List<Room>>((ref) {
  final roomsNotifier = ref.watch(roomsProvider.notifier);
  return roomsNotifier.getActiveRooms();
});

final roomByIdProvider = Provider.family<Room?, String>((ref, roomId) {
  final roomsNotifier = ref.watch(roomsProvider.notifier);
  return roomsNotifier.getRoomById(roomId);
});

final roomsByCreatorProvider = Provider.family<List<Room>, String>((ref, userId) {
  final roomsNotifier = ref.watch(roomsProvider.notifier);
  return roomsNotifier.getRoomsByCreator(userId);
}); 