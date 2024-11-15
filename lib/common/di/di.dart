import 'package:get_it/get_it.dart';
import '../../layers/data/data.dart';
import '../../layers/domain/domain.dart';

/// getIt, inject, locator
final locator = GetIt.instance;

initLocator() {
  locator.registerLazySingleton<RemoteDataSources>(() => RemoteDataSources());

  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImp(locator<RemoteDataSources>()));
  locator.registerLazySingleton<MeetingRepository>(() => MeetingRepositoryImp(locator<RemoteDataSources>()));
  locator.registerLazySingleton<ChatRepository>(() => ChatRepositoryImp(locator<RemoteDataSources>()));

  locator.registerLazySingleton<FetchUsersUseCase>(() => FetchUsersUseCase());
  locator.registerLazySingleton<FetchMeetingRoomUseCase>(() => FetchMeetingRoomUseCase());
  locator.registerLazySingleton<FetchChatMessageUseCase>(() => FetchChatMessageUseCase());
}
