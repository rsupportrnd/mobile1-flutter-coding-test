import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatefulWidget {
  final Widget child;
  final GoRouterState state;

  const AppScaffold({
    super.key,
    required this.child,
    required this.state,
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  static const List<String> tabs = ['/users', '/rooms'];

  int get _currentIndex {
    final location = widget.state.uri.toString();
    final index = tabs.indexWhere((path) => location.startsWith(path));
    return index == -1 ? 0 : index;
  }

  void _onTap(int index) {
    if (index == _currentIndex) return;
    context.go(tabs[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.meeting_room), label: 'Rooms'),
        ],
      ),
    );
  }
}
