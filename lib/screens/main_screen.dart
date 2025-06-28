import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/logger.dart';
import 'user_list_screen.dart';
import 'room_list_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const UsersView(),
    const RoomsView(),
  ];

  final List<String> _screenNames = [
    '사용자',
    '룸',
  ];

  @override
  void initState() {
    super.initState();
    Logger.navigation('앱 시작', _screenNames[_currentIndex]);
    Logger.info('메인 화면 초기화 완료 - 현재 탭: ${_screenNames[_currentIndex]}');
  }

  void _onTabTapped(int index) {
    if (_currentIndex != index) {
      final fromScreen = _screenNames[_currentIndex];
      final toScreen = _screenNames[index];
      
      Logger.userAction('하단 네비게이션 탭 클릭', details: {
        'fromTab': fromScreen,
        'toTab': toScreen,
        'tabIndex': index,
      });
      Logger.navigation(fromScreen, toScreen);
      
      setState(() {
        _currentIndex = index;
      });
      
      Logger.info('화면 전환 완료: $toScreen');
    } else {
      Logger.userAction('동일한 탭 재클릭', details: {
        'currentTab': _screenNames[index],
        'tabIndex': index,
      });
    }
  }

  Future<bool> _showExitDialog() async {
    Logger.userAction('뒤로가기 버튼 클릭');
    Logger.info('앱 종료 확인 다이얼로그 표시');
    
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 16,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '앱을 종료하시겠습니까?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Logger.userAction('앱 종료 취소');
                            Navigator.of(context).pop(false);
                          },
                          child: Center(
                            child: Text(
                              '취소',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.red.shade400,
                            Colors.red.shade600,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Logger.userAction('앱 종료 확인');
                            Logger.lifecycle('사용자가 앱 종료를 선택함');
                            Navigator.of(context).pop(true);
                          },
                          child: const Center(
                            child: Text(
                              '종료',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (result == true) {
      Logger.lifecycle('앱 종료 시작');
      SystemNavigator.pop();
    } else {
      Logger.info('앱 종료 취소됨');
    }

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          await _showExitDialog();
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: '사용자',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.meeting_room),
              label: '룸',
            ),
          ],
        ),
      ),
    );
  }
} 