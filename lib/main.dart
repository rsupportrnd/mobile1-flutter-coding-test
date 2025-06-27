import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'core/sqlite/chat_data_base.dart';
import 'features/messages/bloc/message_bloc.dart';
import 'features/messages/data/datasources/message_local_datasource.dart';
import 'features/messages/data/datasources/message_remote_datasource.dart';
import 'features/messages/data/repositories/message_repository.dart';
import 'features/messages/data/repositories/message_repository_impl.dart';
import 'features/rooms/bloc/room_event.dart';
import 'features/rooms/data/datasources/room_local_datasource.dart';
import 'features/rooms/data/repositories/room_repository.dart';
import 'features/users/bloc/user_bloc.dart';
import 'features/users/data/datasources/user_remote_datasource.dart';
import 'features/users/data/repositories/user_repository.dart';
import 'features/users/data/repositories/user_repository_impl.dart';
import 'features/rooms/bloc/room_bloc.dart';
import 'features/rooms/data/datasources/room_remote_datasource.dart';
import 'features/rooms/data/repositories/room_repository_impl.dart';

import 'app/router.dart'; // router 파일

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final client = http.Client();
  final chatDatabase = ChatDatabase();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (_) => UserRepositoryImpl(
            remoteDataSource: UserRemoteDataSourceImpl(client: client),
          ),
        ),
        RepositoryProvider<RoomRepository>(
          create: (_) => RoomRepositoryImpl(
            remoteDataSource: RoomRemoteDataSourceImpl(client: client),
            localDataSource: RoomLocalDataSourceImpl(chatDatabase: chatDatabase),
          ),
        ),
        RepositoryProvider<MessageRepository>(
          create: (_) => MessageRepositoryImpl(
            remoteDataSource: MessageRemoteDataSourceImpl(client: client),
            localDataSource: MessageLocalDataSourceImpl()
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(userRepository: context.read<UserRepository>())..add(UserLoadRequested())
          ),
          BlocProvider<RoomBloc>(
            create: (context) => RoomBloc(roomRepository: context.read<RoomRepository>())..add(RoomLoadRequested())
          ),
          BlocProvider<MessageBloc>(
            create: (context) => MessageBloc(
              messageRepository: context.read<MessageRepository>(),
              roomBloc: context.read<RoomBloc>()
            ),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
