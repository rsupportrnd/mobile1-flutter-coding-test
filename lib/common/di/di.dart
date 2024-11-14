import 'package:get_it/get_it.dart';

import '../../layers/data/data.dart';
import '../../layers/domain/domain.dart';

/// getIt, inject, locator
final locator = GetIt.instance;

initLocator() {
  locator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSource());
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImp(locator<RemoteDataSource>()));
  locator.registerLazySingleton<FetchUsersUseCase>(() => FetchUsersUseCase());
}
