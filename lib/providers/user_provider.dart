import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../utils/logger.dart';
import 'repository_providers.dart';

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

class CurrentUserNotifier extends StateNotifier<CurrentUserState> {
  CurrentUserNotifier() : super(CurrentUserState()) {
    _initializeCurrentUser();
  }

  void _initializeCurrentUser() {
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

  void updateCurrentUser(User updatedUser) {
    state = state.copyWith(currentUser: updatedUser);
    Logger.userAction('사용자 정보 업데이트', details: {'userId': updatedUser.id});
  }
}

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

  List<User> get filteredUsers {
    if (searchQuery.isEmpty) return users;
    
    final query = searchQuery.toLowerCase();
    return users.where((user) {
      return user.name.toLowerCase().contains(query) ||
             user.email.toLowerCase().contains(query);
    }).toList();
  }
}

class UsersNotifier extends StateNotifier<UsersState> {
  final UserRepository _userRepository;

  UsersNotifier(this._userRepository) : super(UsersState());

  Future<void> loadUsers() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final users = await _userRepository.getUsers();
      state = state.copyWith(
        users: users,
        isLoading: false,
        error: null,
      );
      Logger.info('사용자 목록 로드 완료: ${users.length}명');
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      Logger.error('사용자 목록 로드 실패', error: e);
    }
  }

  void searchUsers(String query) {
    state = state.copyWith(searchQuery: query);
    Logger.debug('사용자 검색: "$query"');
  }

  Future<void> refreshUsers() async {
    Logger.info('사용자 목록 새로고침');
    await loadUsers();
  }

  User? getUserById(String userId) {
    try {
      return state.users.firstWhere((user) => user.id == userId);
    } on StateError {
      return null;
    }
  }
}

final currentUserProvider = StateNotifierProvider<CurrentUserNotifier, CurrentUserState>((ref) {
  return CurrentUserNotifier();
});

final usersProvider = StateNotifierProvider<UsersNotifier, UsersState>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UsersNotifier(userRepository);
});

final currentUserDataProvider = Provider<User?>((ref) {
  return ref.watch(currentUserProvider).currentUser;
});

final isLoggedInProvider = Provider<bool>((ref) {
  return ref.watch(currentUserProvider).isLoggedIn;
});

final currentUserIdProvider = Provider<String?>((ref) {
  return ref.watch(currentUserProvider).currentUser?.id;
});

final userByIdProvider = Provider.family<User?, String>((ref, userId) {
  final usersNotifier = ref.watch(usersProvider.notifier);
  return usersNotifier.getUserById(userId);
});

final filteredUsersProvider = Provider<List<User>>((ref) {
  return ref.watch(usersProvider).filteredUsers;
});

final userByIdProvider = Provider.family<User?, String>((ref, userId) {
  final usersNotifier = ref.watch(usersProvider.notifier);
  return usersNotifier.getUserById(userId);
}); 