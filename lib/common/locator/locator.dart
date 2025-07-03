import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:mobile1_flutter_coding_test/data/datasources/user_local_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/datasources/user_remote_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/repositories/message_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/data/repositories/room_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/data/repositories/user_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/domain/repositories/message_repository.dart';
import 'package:mobile1_flutter_coding_test/domain/repositories/room_repository.dart';
import 'package:mobile1_flutter_coding_test/domain/repositories/user_repository.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_room_message_usecase.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_rooms_usecase.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_users_usecase.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/post_room_message_usecase.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSource(
      dio: locator<Dio>(),
    ),
  );
  locator.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSource(),
  );
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: locator<UserRemoteDataSource>(),
    ),
  );
  locator.registerLazySingleton<RoomRepository>(
    () => RoomRepositoryImpl(
      remoteDataSource: locator<UserRemoteDataSource>(),
      localDataSource: locator<UserLocalDataSource>(), // 필요에 따라 RoomLocalDataSource로 교체
    ),
  );
  locator.registerLazySingleton<MessageRepository>(
    () => MessageRepositoryImpl(
      remoteDataSource: locator<UserRemoteDataSource>(),
      localDataSource: locator<UserLocalDataSource>(),
    ),
  );

  locator.registerLazySingleton<GetUsersUseCase>(
    () => GetUsersUseCase(locator<UserRepository>()),
  );
  locator.registerLazySingleton<GetRoomsUseCase>(
    () => GetRoomsUseCase(locator<RoomRepository>()),
  );
  locator.registerLazySingleton<GetRoomMessageUseCase>(
    () => GetRoomMessageUseCase(locator<MessageRepository>()),
  );
  locator.registerLazySingleton<PostRoomMessageUseCase>(
    () => PostRoomMessageUseCase(locator<MessageRepository>()),
  );
}
