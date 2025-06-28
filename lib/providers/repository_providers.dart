import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/user_repository.dart';
import '../repositories/room_repository.dart';
import '../repositories/message_repository.dart';
import '../data_sources/user_data_source.dart';
import '../data_sources/room_data_source.dart';
import '../data_sources/message_data_source.dart';
import '../data_sources/http_client.dart';

/// HTTP 클라이언트 Provider
final httpClientProvider = Provider<HttpClient>((ref) {
  return HttpClient();
});

// Data Source Providers

final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return UserRemoteDataSourceImpl(httpClient: httpClient);
});

final userLocalDataSourceProvider = Provider<UserLocalDataSource>((ref) {
  return UserLocalDataSourceImpl();
});

final roomRemoteDataSourceProvider = Provider<RoomRemoteDataSource>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return RoomRemoteDataSourceImpl(httpClient: httpClient);
});

final roomLocalDataSourceProvider = Provider<RoomLocalDataSource>((ref) {
  return RoomLocalDataSourceImpl();
});

final messageRemoteDataSourceProvider = Provider<MessageRemoteDataSource>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return MessageRemoteDataSourceImpl(httpClient: httpClient);
});

final messageLocalDataSourceProvider = Provider<MessageLocalDataSource>((ref) {
  return MessageLocalDataSourceImpl();
});



// Repository Providers

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final remoteDataSource = ref.watch(userRemoteDataSourceProvider);
  final localDataSource = ref.watch(userLocalDataSourceProvider);
  
  return UserRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});

final roomRepositoryProvider = Provider<RoomRepository>((ref) {
  final remoteDataSource = ref.watch(roomRemoteDataSourceProvider);
  final localDataSource = ref.watch(roomLocalDataSourceProvider);
  
  return RoomRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});

final messageRepositoryProvider = Provider<MessageRepository>((ref) {
  final remoteDataSource = ref.watch(messageRemoteDataSourceProvider);
  final localDataSource = ref.watch(messageLocalDataSourceProvider);
  
  return MessageRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
}); 