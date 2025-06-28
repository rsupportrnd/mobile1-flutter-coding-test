import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

// 현재 사용자 상태 관리
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

// CurrentUserNotifier - 현재 사용자 관리
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
  }
}

// Provider 정의
final currentUserProvider = StateNotifierProvider<CurrentUserNotifier, CurrentUserState>((ref) {
  return CurrentUserNotifier();
});

// 편의를 위한 개별 Provider들
final currentUserDataProvider = Provider<User?>((ref) {
  return ref.watch(currentUserProvider).currentUser;
});