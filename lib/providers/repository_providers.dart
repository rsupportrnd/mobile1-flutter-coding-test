import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/user_repository.dart';
import '../repositories/room_repository.dart';
import '../repositories/message_repository.dart';
import '../data_sources/user_data_source.dart';
import '../data_sources/room_data_source.dart';
import '../data_sources/message_data_source.dart';
import '../data_sources/http_client.dart';

// =============================================================================
// HTTP Client Provider
// =============================================================================

/// HTTP 클라이언트 Provider
final httpClientProvider = Provider<HttpClient>((ref) {
  return HttpClient();
});

// =============================================================================
// Data Source Providers
// =============================================================================

/// 사용자 원격 데이터 소스 Provider
final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return UserRemoteDataSourceImpl(httpClient: httpClient);
});

/// 사용자 로컬 데이터 소스 Provider
final userLocalDataSourceProvider = Provider<UserLocalDataSource>((ref) {
  return UserLocalDataSourceImpl();
});

/// 룸 원격 데이터 소스 Provider
final roomRemoteDataSourceProvider = Provider<RoomRemoteDataSource>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return RoomRemoteDataSourceImpl(httpClient: httpClient);
});

/// 룸 로컬 데이터 소스 Provider
final roomLocalDataSourceProvider = Provider<RoomLocalDataSource>((ref) {
  return RoomLocalDataSourceImpl();
});

/// 메시지 원격 데이터 소스 Provider
final messageRemoteDataSourceProvider = Provider<MessageRemoteDataSource>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return MessageRemoteDataSourceImpl(httpClient: httpClient);
});

/// 메시지 로컬 데이터 소스 Provider
final messageLocalDataSourceProvider = Provider<MessageLocalDataSource>((ref) {
  return MessageLocalDataSourceImpl();
});

// =============================================================================
// Repository Providers
// =============================================================================

/// 사용자 Repository Provider
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final remoteDataSource = ref.watch(userRemoteDataSourceProvider);
  final localDataSource = ref.watch(userLocalDataSourceProvider);
  
  return UserRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});

/// 룸 Repository Provider
final roomRepositoryProvider = Provider<RoomRepository>((ref) {
  final remoteDataSource = ref.watch(roomRemoteDataSourceProvider);
  final localDataSource = ref.watch(roomLocalDataSourceProvider);
  
  return RoomRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});

/// 메시지 Repository Provider
final messageRepositoryProvider = Provider<MessageRepository>((ref) {
  final remoteDataSource = ref.watch(messageRemoteDataSourceProvider);
  final localDataSource = ref.watch(messageLocalDataSourceProvider);
  
  return MessageRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
}); 