import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../repository/message_repository.dart';
import '../repository/room_repository.dart';
import '../repository/user_repositoy.dart';

final GetIt injector = GetIt.instance;

Future<void> setupDependencies() async {
  // 로컬 데이터가 있어서 필요는 없지만, 네트워크 통신을 위해 사용
  injector.registerLazySingleton<Dio>(() => Dio());

  // repo
  injector
      .registerLazySingleton<UserRepository>(() => UserRepository(injector()));
  injector
      .registerLazySingleton<RoomRepository>(() => RoomRepository(injector()));
  injector.registerLazySingleton<MessageRepository>(
      () => MessageRepository(injector()));
}
