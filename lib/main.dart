import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/presentation/pages/home.dart';
import 'package:mobile1_flutter_coding_test/presentation/pages/room/room_page.dart';
import 'package:mobile1_flutter_coding_test/presentation/pages/room_list/room_list_page.dart';
import 'package:mobile1_flutter_coding_test/presentation/pages/user_list/user_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        UserListPage.routeName: (context) => const UserListPage(),
        RoomListPage.routeName: (context) => const RoomListPage(),
        RoomPage.routeName: (context) => const RoomPage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
