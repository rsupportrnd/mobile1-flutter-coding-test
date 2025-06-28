import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';
import '../repositories/user_repository.dart';
import '../repositories/room_repository.dart';
import '../repositories/message_repository.dart';

// Data Source Providers

/// 사용자 원격 데이터 소스 Provider
final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  return UserRemoteDataSourceImpl();
});

/// 사용자 로컬 데이터 소스 Provider
final userLocalDataSourceProvider = Provider<UserLocalDataSource>((ref) {
  return UserLocalDataSourceImpl();
});

/// 회의실 원격 데이터 소스 Provider
final roomRemoteDataSourceProvider = Provider<RoomRemoteDataSource>((ref) {
  return RoomRemoteDataSourceImpl();
});

/// 회의실 로컬 데이터 소스 Provider
final roomLocalDataSourceProvider = Provider<RoomLocalDataSource>((ref) {
  return RoomLocalDataSourceImpl();
});

/// 메시지 원격 데이터 소스 Provider
final messageRemoteDataSourceProvider = Provider<MessageRemoteDataSource>((ref) {
  return MessageRemoteDataSourceImpl();
});

/// 메시지 로컬 데이터 소스 Provider
///
final messageLocalDataSourceProvider = Provider<MessageLocalDataSource>((ref) {
  return MessageLocalDataSourceImpl();
});


// Repository Providers

/// 사용자 Repository Provider
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final remoteDataSource = ref.watch(userRemoteDataSourceProvider);
  final localDataSource = ref.watch(userLocalDataSourceProvider);

  return UserRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});

/// 회의실 Repository Provider
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
