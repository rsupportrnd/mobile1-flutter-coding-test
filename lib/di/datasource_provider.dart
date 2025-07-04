import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/local_database_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/local_database_datasource_impl.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/message_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/message_datasource_impl.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/room_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/room_datasource_impl.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/user_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/user_datasource_impl.dart';
import 'package:mobile1_flutter_coding_test/di/service_provider.dart';

final messageDataSourceProvider = Provider<MessageDataSource>((ref) =>
    MessageDataSourceImpl(service: ref.read(rsupportApiServiceProvider)));

final roomDataSourceProvider = Provider<RoomDataSource>(
    (ref) => RoomDataSourceImpl(service: ref.read(rsupportApiServiceProvider)));

final userDataSourceProvider = Provider<UserDataSource>(
    (ref) => UserDataSourceImpl(service: ref.read(rsupportApiServiceProvider)));

final localDatabaseDataSourceProvider = Provider<LocalDatabaseDataSource>(
    (ref) => LocalDatabaseDataSourceImpl(
        database: ref.read(localDatabaseProvider),
        idGenerator: ref.read(idGeneratorProvider)));
