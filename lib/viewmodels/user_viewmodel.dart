import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';
import '../providers/repository_providers.dart';

// UserList State - 사용자 목록 상태 관리
class UserListState {
  final List<User> users;
  final bool isLoading;
  final String? error;
  final User? selectedUser;
  final String searchQuery;

  UserListState({
    this.users = const [],
    this.isLoading = false,
    this.error,
    this.selectedUser,
    this.searchQuery = '',
  });

  UserListState copyWith({
    List<User>? users,
    bool? isLoading,
    String? error,
    User? selectedUser,
    String? searchQuery,
    bool? clearSelectedUser,
  }) {
    return UserListState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      selectedUser: clearSelectedUser == true ? null : (selectedUser ?? this.selectedUser),
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  // 검색 결과 필터링
  List<User> get filteredUsers {
    if (searchQuery.isEmpty) return users;
    
    return users.where((user) {
      return user.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
             user.email.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  // 온라인 사용자만
  List<User> get onlineUsers {
    return users.where((user) => user.isOnline).toList();
  }

  // 관리자 사용자만
  List<User> get adminUsers {
    return users.where((user) => user.isAdmin).toList();
  }
}

// UserViewModel - Repository 패턴 사용
class UserViewModel extends StateNotifier<UserListState> {
  final UserRepository _userRepository;

  UserViewModel(this._userRepository) : super(UserListState());

  // 사용자 목록 로드
  Future<void> loadUsers() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final users = await _userRepository.getUsers();
      state = state.copyWith(
        users: users,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // 검색 쿼리 설정 (로컬 필터링)
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  // 검색 쿼리 클리어
  void clearSearchQuery() {
    state = state.copyWith(searchQuery: '');
  }

  // 사용자 선택
  void selectUser(User user) {
    state = state.copyWith(selectedUser: user);
  }

  // 사용자 선택 해제
  void clearSelectedUser() {
    state = state.copyWith(clearSelectedUser: true);
  }

  // 사용자 목록 새로고침
  Future<void> refreshUsers() async {
    await _userRepository.refreshUsers();
    await loadUsers();
  }

  // 상태별 사용자 필터링
  List<User> getUsersByStatus(String status) {
    return state.users.where((user) => user.status == status).toList();
  }

  // 역할별 사용자 필터링
  List<User> getUsersByRole(String role) {
    return state.users.where((user) => user.role == role).toList();
  }

  // 사용자 통계
  Map<String, int> get userStats {
    final stats = <String, int>{};
    
    // 상태별 통계
    for (final user in state.users) {
      final statusKey = 'status_${user.status}';
      stats[statusKey] = (stats[statusKey] ?? 0) + 1;
    }
    
    // 역할별 통계
    for (final user in state.users) {
      final roleKey = 'role_${user.role}';
      stats[roleKey] = (stats[roleKey] ?? 0) + 1;
    }
    
    // 전체 통계
    stats['total'] = state.users.length;
    stats['online'] = state.onlineUsers.length;
    stats['admin'] = state.adminUsers.length;
    
    return stats;
  }
}

// Provider 정의 (Repository 기반)
final userViewModelProvider = StateNotifierProvider<UserViewModel, UserListState>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserViewModel(userRepository);
});

// 편의를 위한 개별 Provider들
final usersProvider = Provider<List<User>>((ref) {
  return ref.watch(userViewModelProvider).filteredUsers;
});

final isLoadingProvider = Provider<bool>((ref) {
  return ref.watch(userViewModelProvider).isLoading;
});

final userErrorProvider = Provider<String?>((ref) {
  return ref.watch(userViewModelProvider).error;
});

final selectedUserProvider = Provider<User?>((ref) {
  return ref.watch(userViewModelProvider).selectedUser;
});

final onlineUsersProvider = Provider<List<User>>((ref) {
  return ref.watch(userViewModelProvider).onlineUsers;
});

final adminUsersProvider = Provider<List<User>>((ref) {
  return ref.watch(userViewModelProvider).adminUsers;
});

final userStatsProvider = Provider<Map<String, int>>((ref) {
  return ref.watch(userViewModelProvider.notifier).userStats;
}); 