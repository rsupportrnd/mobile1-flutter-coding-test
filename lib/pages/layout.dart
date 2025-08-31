import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile1_flutter_coding_test/values/routes.dart';

class Layout extends ConsumerStatefulWidget {
  const Layout(this.chiid, {super.key});
  final Widget chiid;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LayoutState();
}

class _LayoutState extends ConsumerState<Layout> {
  int currentIndex = 0;
  final List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: '사용자',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.chat),
      label: '채팅',
    ),
  ];
  Map<int, String> pages = {
    0: Routes.userList.path,
    1: Routes.chatList.path,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            context.go(pages[index]!);
          });
        },
        items: items,
      ),
      appBar: AppBar(
        title: const Text('Mobile1 Flutter Coding Test'),
      ),
      body: widget.chiid,
    );
  }
}
