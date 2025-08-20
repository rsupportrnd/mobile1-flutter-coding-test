import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/core/injector.dart';
import 'package:mobile1_flutter_coding_test/repository/user_repositoy.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeEvent>((event, emit) {
      event.when(
        start: () async {
          await _setupUser();
          emit(state.copyWith(navIdx: 0)); // 기본적으로 유저 탭
        },
        move: (int idx) {
          if (idx != state.navIdx) {
            emit(state.copyWith(navIdx: idx));
          }
        },
        switchUser: (String userId) async {
          await _switchUser(userId);
        },
      );
    });
  }

  final UserRepository _userRepo = injector<UserRepository>();

  Future<void> _setupUser() async {
    // 저장된 마지막 유저가 없다면 첫번째 유저를 설정
    await _userRepo.load();
    late final last;
    if (_userRepo.lastSession != null) {
      last = _userRepo.lastSession;
    } else {
      last = _userRepo.users.isNotEmpty ? _userRepo.users.first : null;
    }
    if (last != null) {
      emit(
        state.copyWith(currentUserId: last.userId, currentUserName: last.name),
      );
    }
  }

  Future<void> _switchUser(String userId) async {
    // 유저 전환 시 필요한 로직
    final users = _userRepo.users;
    final user = users.firstWhere(
      (u) => u.userId == userId,
      orElse: () => users.first,
    );
    await _userRepo.setLastSession(user.userId);
    emit(
      state.copyWith(currentUserId: user.userId, currentUserName: user.name),
    );
  }
}
