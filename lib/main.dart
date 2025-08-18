import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/injector.dart';
import 'core/routes.dart';
import 'presentation/startup/startup_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final GoRouter router = createRouter();
    return MultiBlocProvider(
      providers: [
        BlocProvider<StartupCubit>(
          create: (_) => StartupCubit()..start(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Mobile1 Chat',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}

