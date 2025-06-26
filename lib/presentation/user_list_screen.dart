import 'package:flutter/material.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('사용자 목록'),
      ),
      body: const Center(
        child: Text(
          '사용자 목록 화면',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
