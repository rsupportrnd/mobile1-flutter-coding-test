import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String roomId;

  const ChatScreen({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          '채팅 화면 (메시지 목록 & 입력창)',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
