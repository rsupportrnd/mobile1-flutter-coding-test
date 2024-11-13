import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/user/user_list_view.dart';

/// ChangeNotifier를 사용하여 BottomNavigationBar의
/// 선택된 항목을 관리하는 ViewModel입니다.
class MainFrameViewModel extends ChangeNotifier {

  /// BottomNavigationBar 선택된 항목 인덱스
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  /// BottomNavigationBar 아이템 구성
  final List<Widget> _widgetOptions = [];
  List<Widget> get widgetOptions => _widgetOptions;

  MainFrameViewModel() {
    _widgetOptions.add(const UserListView());
    _widgetOptions.add(const UserListView());
  }

  /// Handles item selection in the bottom navigation bar.
  onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}