import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/presentation/pages/room_list/room_list_page.dart';
import 'package:mobile1_flutter_coding_test/presentation/pages/user_list/user_list_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const UserListPage(),
    const RoomListPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '유저',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.meeting_room),
            label: '회의',
          ),
        ],
      ),
    );
  }
}
