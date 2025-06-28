import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/room.dart';
import '../config/app_constants.dart';
import '../providers/repository_providers.dart';
import 'package:flutter/foundation.dart';

// 회의실 목록 상태 관리
class RoomListState {
  final List<Room> rooms;
  final bool isLoading;
  final String? error;
  final Room? selectedRoom;
  final String searchQuery;

  RoomListState({
    this.rooms = const [],
    this.isLoading = true,
    this.error,
    this.selectedRoom,
    this.searchQuery = '',
  });

  RoomListState copyWith({
    List<Room>? rooms,
    bool? isLoading,
    String? error,
    Room? selectedRoom,
    String? searchQuery,
    bool clearError = false,
    bool clearSelectedRoom = false,
  }) {
    return RoomListState(
      rooms: rooms ?? this.rooms,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      selectedRoom: clearSelectedRoom ? null : (selectedRoom ?? this.selectedRoom),
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  // 최신 활동 시간 순으로 정렬하는 정적 메서드
  static List<Room> _sortRoomsByLastActivity(List<Room> rooms) {
    final sortedRooms = List<Room>.from(rooms);
    sortedRooms.sort((a, b) {
      final aTime = a.lastMessageTime;
      final bTime = b.lastMessageTime;

      // 둘 다 null인 경우 방 생성 시간으로 비교
      if (aTime == null && bTime == null) {
        final aCreated = a.createdAt;
        final bCreated = b.createdAt;

        if (aCreated == null && bCreated == null) return 0;
        if (aCreated == null) return 1;
        if (bCreated == null) return -1;

        return bCreated.compareTo(aCreated); // 최신 생성순
      }

      // 한쪽만 null인 경우
      if (aTime == null) return 1;  // null은 뒤로
      if (bTime == null) return -1; // null은 뒤로

      // 둘 다 null이 아닌 경우 최신 메시지 시간 비교
      return bTime.compareTo(aTime); // 최신순 (내림차순)
    });

    return sortedRooms;
  }

  // 필터링된 방목록 (검색만)
  List<Room> get filteredRooms {
    if (searchQuery.isEmpty) return rooms;

    final filtered = rooms.where((room) {
      return room.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          (room.description?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false);
    }).toList();

    // 검색 결과도 최신 메시지 순으로 정렬 유지
    return _sortRoomsByLastActivity(filtered);
  }

  // 활성 방 목록
  List<Room> get activeRooms {
    return rooms.where((room) => room.isActive).toList();
  }

  // 최근 생성된 방 목록
  List<Room> get recentRooms {
    final sortedRooms = List<Room>.from(rooms);
    sortedRooms.sort((a, b) {
      if (a.createdAt == null && b.createdAt == null) return 0;
      if (a.createdAt == null) return 1;
      if (b.createdAt == null) return -1;
      return b.createdAt!.compareTo(a.createdAt!);
    });
    return sortedRooms.take(5).toList();
  }
}

// RoomViewModel - 회의실 관련 비즈니스 로직 처리
class RoomViewModel extends StateNotifier<RoomListState> {
  final Ref _ref;

  RoomViewModel(this._ref) : super(RoomListState());

  // 회의실 목록 로드
  Future<void> loadRooms() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final roomRepository = _ref.read(roomRepositoryProvider);
      final rooms = await roomRepository.getRooms();

      // 각 방의 실제 최신 메시지로 업데이트
      final updatedRooms = await _updateRoomsWithLatestMessages(rooms);

      // 최신 메시지 시간 순으로 정렬 (최신순)
      final sortedRooms = RoomListState._sortRoomsByLastActivity(updatedRooms);

      state = state.copyWith(
        rooms: sortedRooms,
        isLoading: false,
        clearError: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppConstants.loadingRoomsErrorMessage,
      );
    }
  }

  // 각 방의 실제 최신 메시지로 업데이트
  Future<List<Room>> _updateRoomsWithLatestMessages(List<Room> rooms) async {
    final messageRepository = _ref.read(messageRepositoryProvider);
    final updatedRooms = <Room>[];

    for (final room in rooms) {
      try {
        // 해당 방의 최신 메시지 1개 가져오기
        final recentMessages = await messageRepository.getRecentMessages(room.id, 1);

        if (recentMessages.isNotEmpty) {
          final latestMessage = recentMessages.first;

          // lastMessage 맵 생성
          final lastMessageMap = {
            'sender': latestMessage.userName ?? latestMessage.userId,
            'content': latestMessage.content,
            'timestamp': latestMessage.timestamp.toIso8601String(),
          };

          // Room 객체 업데이트
          final updatedRoom = room.copyWith(lastMessage: lastMessageMap);
          updatedRooms.add(updatedRoom);
        } else {
          // 메시지가 없는 경우 원본 그대로
          updatedRooms.add(room);
        }
      } catch (e) {
        // 에러 발생 시 원본 그대로
        debugPrint('방 ${room.id}의 최신 메시지 로드 실패: $e');
        updatedRooms.add(room);
      }
    }

    return updatedRooms;
  }

  // 특정 방의 최신 메시지만 업데이트
  Future<void> updateRoomLatestMessage(String roomId) async {
    final messageRepository = _ref.read(messageRepositoryProvider);

    try {
      // 해당 방의 최신 메시지 1개 가져오기
      final recentMessages = await messageRepository.getRecentMessages(roomId, 1);

      // 현재 방 목록에서 해당 방 찾기
      final currentRooms = List<Room>.from(state.rooms);
      final roomIndex = currentRooms.indexWhere((room) => room.id == roomId);

      if (roomIndex != -1 && recentMessages.isNotEmpty) {
        final latestMessage = recentMessages.first;

        // lastMessage 맵 생성
        final lastMessageMap = {
          'sender': latestMessage.userName ?? latestMessage.userId,
          'content': latestMessage.content,
          'timestamp': latestMessage.timestamp.toIso8601String(),
        };

        // Room 객체 업데이트
        final updatedRoom = currentRooms[roomIndex].copyWith(lastMessage: lastMessageMap);
        currentRooms[roomIndex] = updatedRoom;

        // 업데이트 후 다시 정렬
        final sortedRooms = RoomListState._sortRoomsByLastActivity(currentRooms);

        state = state.copyWith(rooms: sortedRooms);
      }
    } catch (e) {
      debugPrint('방 $roomId의 최신 메시지 업데이트 실패: $e');
    }
  }

  // 회의실 선택
  void selectRoom(Room room) {
    state = state.copyWith(selectedRoom: room);
  }

  // 회의실 선택 해제
  void clearSelectedRoom() {
    state = state.copyWith(clearSelectedRoom: true);
  }

  // 회의실 목록 새로고침 (실제 메시지 반영)
  Future<void> refreshRooms() async {
    await loadRooms();
  }

  // 채팅 화면에서 돌아올 때 호출 (특정 방만 업데이트)
  Future<void> refreshRoomAfterChat(String roomId) async {
    // 메시지 캐시 무효화
    final messageRepository = _ref.read(messageRepositoryProvider);
    await messageRepository.refreshMessages(roomId);

    // 해당 방의 최신 메시지 업데이트 (정렬 포함)
    await updateRoomLatestMessage(roomId);
  }

  // 검색 쿼리 설정
  void setSearchQuery(String query) {
    debugPrint('검색 쿼리 설정: "$query"');
    state = state.copyWith(searchQuery: query);
  }

  // 검색 쿼리 초기화
  void clearSearchQuery() {
    debugPrint('검색 쿼리 초기화');
    state = state.copyWith(searchQuery: '');
  }

  // 특정 사용자가 참여한 방 목록
  List<Room> getRoomsByUser(String userId) {
    return state.rooms.where((room) {
      return room.participants.contains(userId);
    }).toList();
  }

  // 특정 사용자가 생성한 방 목록
  List<Room> getRoomsByCreator(String userId) {
    return state.rooms.where((room) => room.creator == userId).toList();
  }

  // 참여자 수별로 정렬
  void sortByParticipantCount({bool ascending = false}) {
    final sortedRooms = List<Room>.from(state.rooms);
    sortedRooms.sort((a, b) {
      final result = a.participantCount.compareTo(b.participantCount);
      return ascending ? result : -result;
    });
    state = state.copyWith(rooms: sortedRooms);
  }

  // 최근 활동별로 정렬
  void sortByLastActivity() {
    final sortedRooms = RoomListState._sortRoomsByLastActivity(state.rooms);
    state = state.copyWith(rooms: sortedRooms);
  }
}

// Provider 정의 (Ref 주입)
final roomViewModelProvider = StateNotifierProvider<RoomViewModel, RoomListState>((ref) {
  return RoomViewModel(ref);
});

// 편의를 위한 개별 Provider들
final roomsProvider = Provider<List<Room>>((ref) {
  return ref.watch(roomViewModelProvider).filteredRooms;
});

final roomsLoadingProvider = Provider<bool>((ref) {
  return ref.watch(roomViewModelProvider).isLoading;
});

final roomsErrorProvider = Provider<String?>((ref) {
  return ref.watch(roomViewModelProvider).error;
});

final selectedRoomProvider = Provider<Room?>((ref) {
  return ref.watch(roomViewModelProvider).selectedRoom;
});

final activeRoomsProvider = Provider<List<Room>>((ref) {
  return ref.watch(roomViewModelProvider).activeRooms;
});

final recentRoomsProvider = Provider<List<Room>>((ref) {
  return ref.watch(roomViewModelProvider).recentRooms;
}); 