import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/data/repository/message_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/data/repository/room_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/data/repository/user_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/domain/repository/message_repository.dart';
import 'package:mobile1_flutter_coding_test/domain/repository/room_repository.dart';
import 'package:mobile1_flutter_coding_test/domain/repository/user_repository.dart';
import 'package:mobile1_flutter_coding_test/presentation/provider/datasource_provider.dart';

final messageRepositoryProvider = Provider<MessageRepository>((ref) =>
    MessageRepositoryImpl(dataSource: ref.read(messageDataSourceProvider)));

final roomRepositoryProvider = Provider<RoomRepository>(
    (ref) => RoomRepositoryImpl(dataSource: ref.read(roomDataSourceProvider)));

final userRepositoryProvider = Provider<UserRepository>(
    (ref) => UserRepositoryImpl(dataSource: ref.read(userDataSourceProvider)));
