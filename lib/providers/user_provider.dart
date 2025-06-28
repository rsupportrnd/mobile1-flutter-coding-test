import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../utils/logger.dart';
import 'repository_providers.dart';

// =============================================================================
// 현재 사용자 상태 관리
// =============================================================================

/// 현재 사용자 상태 클래스
class CurrentUserState {
  final User? currentUser;
  final bool isLoggedIn;

  CurrentUserState({
    this.currentUser,
    this.isLoggedIn = false,
  });

  CurrentUserState copyWith({
    User? currentUser,
    bool? isLoggedIn,
  }) {
    return CurrentUserState(
      currentUser: currentUser ?? this.currentUser,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}

/// 현재 사용자 관리 Notifier
class CurrentUserNotifier extends StateNotifier<CurrentUserState> {
  CurrentUserNotifier() : super(CurrentUserState()) {
    _initializeCurrentUser();
  }

  void _initializeCurrentUser() {
    // 앱 시작 시 임시 사용자로 로그인 (실제 앱에서는 인증 로직 필요)
    const currentUser = User(
      id: "HYW",
      name: "현영우",
      email: "ieeh0122@naver.com",
      profilePicture: null,
      status: "online",
      role: "admin",
    );
    
    state = state.copyWith(
      currentUser: currentUser,
      isLoggedIn: true,
    );
    
    Logger.info('현재 사용자 초기화: ${currentUser.name} (${currentUser.id})');
  }

  /// 사용자 로그인
  void loginUser(User user) {
    state = state.copyWith(
      currentUser: user,
      isLoggedIn: true,
    );
    Logger.userAction('로그인', details: {'userId': user.id, 'userName': user.name});
  }

  /// 사용자 로그아웃
  void logoutUser() {
    final currentUserId = state.currentUser?.id;
    state = state.copyWith(
      currentUser: null,
      isLoggedIn: false,
    );
    Logger.userAction('로그아웃', details: {'userId': currentUserId});
  }

  /// 현재 사용자 정보 업데이트
  void updateCurrentUser(User updatedUser) {
    state = state.copyWith(currentUser: updatedUser);
    Logger.userAction('사용자 정보 업데이트', details: {'userId': updatedUser.id});
  }
}

// =============================================================================
// 사용자 목록 상태 관리
// =============================================================================

/// 사용자 목록 상태 클래스
class UsersState {
  final List<User> users;
  final bool isLoading;
  final String? error;
  final String searchQuery;

  UsersState({
    this.users = const [],
    this.isLoading = false,
    this.error,
    this.searchQuery = '',
  });

  UsersState copyWith({
    List<User>? users,
    bool? isLoading,
    String? error,
    String? searchQuery,
  }) {
    return UsersState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  /// 필터링된 사용자 목록
  List<User> get filteredUsers {
    if (searchQuery.isEmpty) return users;
    
    final query = searchQuery.toLowerCase();
    return users.where((user) {
      return user.name.toLowerCase().contains(query) ||
             user.email.toLowerCase().contains(query);
    }).toList();
  }
}

/// 사용자 목록 관리 Notifier
class UsersNotifier extends StateNotifier<UsersState> {
  final UserRepository _userRepository;

  UsersNotifier(this._userRepository) : super(UsersState());

  /// 사용자 목록 로드
  Future<void> loadUsers() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      Logger.info('사용자 목록 로드 시작');
      final users = await _userRepository.getUsers();
      state = state.copyWith(
        users: users,
        isLoading: false,
      );
      Logger.info('사용자 목록 로드 완료: ${users.length}명');
    } catch (e) {
      Logger.error('사용자 목록 로드 실패', error: e);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// 사용자 검색
  void searchUsers(String query) {
    state = state.copyWith(searchQuery: query);
    Logger.debug('사용자 검색: "$query"');
  }

  /// 사용자 목록 새로고침
  Future<void> refreshUsers() async {
    Logger.info('사용자 목록 새로고침');
    await _userRepository.refreshUsers();
    await loadUsers();
  }

  /// 특정 사용자 조회
  User? getUserById(String userId) {
    try {
      return state.users.firstWhere((user) => user.id == userId);
    } on StateError {
      return null;
    }
  }
}

// =============================================================================
// Provider 정의
// =============================================================================

/// 현재 사용자 Provider
final currentUserProvider = StateNotifierProvider<CurrentUserNotifier, CurrentUserState>((ref) {
  return CurrentUserNotifier();
});

/// 사용자 목록 Provider
final usersProvider = StateNotifierProvider<UsersNotifier, UsersState>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UsersNotifier(userRepository);
});

// =============================================================================
// 편의를 위한 개별 Provider들
// =============================================================================

/// 현재 사용자 데이터 Provider
final currentUserDataProvider = Provider<User?>((ref) {
  return ref.watch(currentUserProvider).currentUser;
});

/// 로그인 상태 Provider
final isLoggedInProvider = Provider<bool>((ref) {
  return ref.watch(currentUserProvider).isLoggedIn;
});

/// 현재 사용자 ID Provider
final currentUserIdProvider = Provider<String?>((ref) {
  return ref.watch(currentUserProvider).currentUser?.id;
});

/// 필터링된 사용자 목록 Provider
final filteredUsersProvider = Provider<List<User>>((ref) {
  return ref.watch(usersProvider).filteredUsers;
});

/// 특정 사용자 조회 Provider
final userByIdProvider = Provider.family<User?, String>((ref, userId) {
  final usersNotifier = ref.watch(usersProvider.notifier);
  return usersNotifier.getUserById(userId);
}); 