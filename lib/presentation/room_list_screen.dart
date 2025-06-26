import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoomListScreen extends StatelessWidget {
  const RoomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 사용자 목록 화면으로 이동
            context.push('/rooms/3/chat');
          },
          child: const Text('메시지 목록'),
        ),
      ),
    );
  }
}
