import 'package:http/http.dart' as http;
import 'package:mobile1_flutter_coding_test/app/index.dart';

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

class MyApp extends HookWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(useMaterial3: true),
    );
  }
}
