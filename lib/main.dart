import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'features/users/bloc/user_bloc.dart';
import 'features/users/data/datasources/user_remote_datasource.dart';
import 'features/users/data/repositories/user_repository_impl.dart';

import 'app/router.dart'; // router 파일

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userRepository = UserRepositoryImpl(
    remoteDataSource: UserRemoteDataSourceImpl(client: http.Client()),
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (_) =>
          UserBloc(userRepository: userRepository)..add(UserLoadRequested()),
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
