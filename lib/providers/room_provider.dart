import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/room.dart';
import '../utils/logger.dart';
import 'repository_providers.dart';

// =============================================================================
// 룸 목록 상태 관리
// =============================================================================

/// 룸 목록 상태 클래스
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

  /// 필터링 및 정렬된 룸 목록
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

/// 룸 필터 타입
enum RoomFilter {
  all,
  active,
  inactive,
}

/// 룸 정렬 타입
enum RoomSortType {
  name,
  participantCount,
  lastActivity,
}

/// 룸 목록 관리 Notifier
class RoomsNotifier extends StateNotifier<RoomsState> {
  final RoomRepository _roomRepository;

  RoomsNotifier(this._roomRepository) : super(RoomsState());

  /// 룸 목록 로드
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

  /// 룸 검색
  void searchRooms(String query) {
    state = state.copyWith(searchQuery: query);
    Logger.debug('룸 검색: "$query"');
  }

  /// 필터 변경
  void setFilter(RoomFilter filter) {
    state = state.copyWith(filter: filter);
    Logger.debug('룸 필터 변경: $filter');
  }

  /// 정렬 타입 변경
  void setSortType(RoomSortType sortType) {
    state = state.copyWith(sortType: sortType);
    Logger.debug('룸 정렬 변경: $sortType');
  }

  /// 룸 목록 새로고침
  Future<void> refreshRooms() async {
    Logger.info('룸 목록 새로고침');
    await _roomRepository.refreshRooms();
    await loadRooms();
  }

  /// 특정 룸 조회
  Room? getRoomById(String roomId) {
    try {
      return state.rooms.firstWhere((room) => room.id == roomId);
    } on StateError {
      return null;
    }
  }

  /// 활성 룸만 조회
  List<Room> getActiveRooms() {
    return state.rooms.where((room) => room.isActive).toList();
  }

  /// 특정 사용자가 생성한 룸 조회
  List<Room> getRoomsByCreator(String userId) {
    return state.rooms.where((room) => room.creator == userId).toList();
  }
}

// =============================================================================
// 현재 선택된 룸 상태 관리
// =============================================================================

/// 현재 룸 상태 클래스
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

/// 현재 룸 관리 Notifier
class CurrentRoomNotifier extends StateNotifier<CurrentRoomState> {
  final RoomRepository _roomRepository;

  CurrentRoomNotifier(this._roomRepository) : super(CurrentRoomState());

  /// 룸 선택
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

  /// 룸 선택 해제
  void clearRoom() {
    state = state.copyWith(currentRoom: null);
    Logger.info('룸 선택 해제');
  }
}

// =============================================================================
// Provider 정의
// =============================================================================

/// 룸 목록 Provider
final roomsProvider = StateNotifierProvider<RoomsNotifier, RoomsState>((ref) {
  final roomRepository = ref.watch(roomRepositoryProvider);
  return RoomsNotifier(roomRepository);
});

/// 현재 룸 Provider
final currentRoomProvider = StateNotifierProvider<CurrentRoomNotifier, CurrentRoomState>((ref) {
  final roomRepository = ref.watch(roomRepositoryProvider);
  return CurrentRoomNotifier(roomRepository);
});

// =============================================================================
// 편의를 위한 개별 Provider들
// =============================================================================

/// 필터링된 룸 목록 Provider
final filteredRoomsProvider = Provider<List<Room>>((ref) {
  return ref.watch(roomsProvider).filteredAndSortedRooms;
});

/// 현재 룸 데이터 Provider
final currentRoomDataProvider = Provider<Room?>((ref) {
  return ref.watch(currentRoomProvider).currentRoom;
});

/// 현재 룸 ID Provider
final currentRoomIdProvider = Provider<String?>((ref) {
  return ref.watch(currentRoomProvider).currentRoom?.id;
});

/// 활성 룸 목록 Provider
final activeRoomsProvider = Provider<List<Room>>((ref) {
  final roomsNotifier = ref.watch(roomsProvider.notifier);
  return roomsNotifier.getActiveRooms();
});

/// 특정 룸 조회 Provider
final roomByIdProvider = Provider.family<Room?, String>((ref, roomId) {
  final roomsNotifier = ref.watch(roomsProvider.notifier);
  return roomsNotifier.getRoomById(roomId);
});

/// 사용자별 생성 룸 Provider
final roomsByCreatorProvider = Provider.family<List<Room>, String>((ref, userId) {
  final roomsNotifier = ref.watch(roomsProvider.notifier);
  return roomsNotifier.getRoomsByCreator(userId);
}); 