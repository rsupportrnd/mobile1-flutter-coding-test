import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'features/rooms/bloc/room_event.dart';
import 'features/users/bloc/user_bloc.dart';
import 'features/users/data/datasources/user_remote_datasource.dart';
import 'features/users/data/repositories/user_repository_impl.dart';

import 'features/rooms/bloc/room_bloc.dart';
import 'features/rooms/data/datasources/room_remote_datasource.dart';
import 'features/rooms/data/repositories/room_repository_impl.dart';

import 'app/router.dart'; // router 파일

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final client = http.Client();

  final userRepository = UserRepositoryImpl(
    remoteDataSource: UserRemoteDataSourceImpl(client: client),
  );

  final roomRepository = RoomRepositoryImpl(
    remoteDataSource: RoomRemoteDataSourceImpl(client: client),
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (_) =>
          UserBloc(userRepository: userRepository)..add(UserLoadRequested()),
        ),
        BlocProvider<RoomBloc>(
          create: (_) =>
          RoomBloc(roomRepository: roomRepository)..add(RoomLoadRequested()),
        ),
      ],
      child: const MyApp(),
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
