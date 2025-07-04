import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/data/database/local_database.dart';
import 'package:mobile1_flutter_coding_test/data/remote/dio_client.dart';
import 'package:mobile1_flutter_coding_test/data/remote/dio_client_impl.dart';
import 'package:mobile1_flutter_coding_test/data/remote/rsupport_api_service.dart';
import 'package:mobile1_flutter_coding_test/data/utils/id_generator.dart';
import 'package:mobile1_flutter_coding_test/data/utils/id_generator_impl.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/loading_manager.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/toast_service.dart';

final idGeneratorProvider = Provider<IdGenerator>(
    (ref) => IdGeneratorImpl(database: ref.watch(localDatabaseProvider)));

// final jsonLoaderProvider = Provider<IJsonLoader>((ref) => JsonLoader());

final localDatabaseProvider = Provider<LocalDatabase>((ref) => LocalDatabase());

final globalLoadingProvider = StateProvider<bool>((ref) => false);

final loadingManagerProvider = Provider<LoadingManager>((ref) {
  return LoadingManagerImpl(ref);
});

final toastServiceProvider = Provider<ToastService>((ref) {
  return ToastServiceImpl();
});

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClientImpl();
});

// Dio Provider
final dioProvider = Provider<Dio>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return dioClient.create();
});

final rsupportApiServiceProvider = Provider<RSupportApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return RSupportApiService(dio);
});
