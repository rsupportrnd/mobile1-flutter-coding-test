import 'package:get_it/get_it.dart';
import '../../layers/data/data.dart';
import '../../layers/domain/domain.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// getIt, inject, locator
final locator = GetIt.instance;

initLocator() async {

  await Hive.initFlutter(); // Hive 초기화
  Hive.registerAdapter(ChatMessageDAOAdapter()); // Message 모델 어댑터 등록
  var chatBox = await Hive.openBox<ChatMessageDAO>('chat'); // Hive Box 열기
  locator.registerSingleton<LocalDataSource>(LocalDataSource(chatBox));

  locator.registerLazySingleton<RemoteDataSources>(() => RemoteDataSources());

  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImp(locator<RemoteDataSources>()));
  locator.registerLazySingleton<MeetingRepository>(() => MeetingRepositoryImp(locator<RemoteDataSources>()));
  locator.registerLazySingleton<ChatRepository>(() => ChatRemoteRepositoryImp(locator<RemoteDataSources>()));
  locator.registerLazySingleton<ChatLocalRepository>(() => ChatLocalRepositoryImp(locator<LocalDataSource>()));

  locator.registerLazySingleton<FetchUsersUseCase>(() => FetchUsersUseCase());
  locator.registerLazySingleton<FetchMeetingRoomUseCase>(() => FetchMeetingRoomUseCase());
  locator.registerLazySingleton<FetchChatMessageUseCase>(() => FetchChatMessageUseCase());
  locator.registerLazySingleton<AddChatMessageUseCase>(() => AddChatMessageUseCase());
  locator.registerLazySingleton<GetAllChatMessageUseCase>(() => GetAllChatMessageUseCase());
}
