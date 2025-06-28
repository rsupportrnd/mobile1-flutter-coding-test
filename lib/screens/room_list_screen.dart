import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/room.dart';
import '../router/navigation_helper.dart';
import '../utils/logger.dart';
import '../viewmodels/room_viewmodel.dart';
import '../widgets/common_widgets.dart';
import '../widgets/room_icon.dart';
import 'chat_screen.dart';

class RoomsView extends ConsumerStatefulWidget {
  const RoomsView({super.key});

  @override
  ConsumerState<RoomsView> createState() => _RoomsViewState();
}

class _RoomsViewState extends ConsumerState<RoomsView> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _refreshButtonController;

  @override
  void initState() {
    super.initState();
    Logger.info('회의실 목록 화면 진입');

    // Refresh 버튼 애니메이션 컨트롤러
    _refreshButtonController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // 화면 초기화 시 회의실 목록 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Logger.info('회의실 목록 로드 시작');
      ref.read(roomViewModelProvider.notifier).loadRooms();
    });

    // 검색 컨트롤러 리스너 추가
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _refreshButtonController.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {}); // suffixIcon 업데이트를 위해
  }

  // 시간을 "몇 분 전" 형식으로 포맷하는 함수
  String _formatTimeAgo(DateTime? time) {
    if (time == null) return '';

    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inDays > 7) {
      return '${time.month}/${time.day}';
    } else if (diff.inDays > 0) {
      return '${diff.inDays}일 전';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}시간 전';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }

  // Refresh 함수 (버튼 클릭 시)
  Future<void> _onRefreshButtonPressed() async {
    Logger.userAction('새로고침 버튼 클릭', details: {'screen': '회의실 목록'});
    final roomViewModel = ref.read(roomViewModelProvider.notifier);

    // 회전 애니메이션 시작
    _refreshButtonController.repeat();

    try {
      await roomViewModel.refreshRooms();
      Logger.info('회의실 목록 새로고침 성공');

      // 성공 시 스낵바 표시
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text('회의실 목록이 업데이트되었습니다'),
              ],
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } catch (e) {
      Logger.error('회의실 목록 새로고침 실패', error: e);
      // 실패 시 에러 스낵바 표시
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Expanded(child: Text('업데이트 실패: $e')),
              ],
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } finally {
      // 애니메이션 정지
      if (mounted) {
        _refreshButtonController.stop();
        _refreshButtonController.reset();
      }
    }
  }

  // Pull-to-refresh 함수
  Future<void> _onPullToRefresh() async {
    Logger.userAction('Pull-to-refresh 액션', details: {'screen': '회의실 목록'});
    final roomViewModel = ref.read(roomViewModelProvider.notifier);

    try {
      await roomViewModel.refreshRooms();
      Logger.info('Pull-to-refresh 새로고침 성공');
    } catch (e) {
      Logger.error('Pull-to-refresh 새로고침 실패', error: e);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final roomState = ref.watch(roomViewModelProvider);
    final roomViewModel = ref.read(roomViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('회의실 목록'),
        actions: [
          AnimatedBuilder(
            animation: _refreshButtonController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _refreshButtonController.value * 2 * 3.14159,
                child: IconButton(
                  onPressed: _onRefreshButtonPressed,
                  icon: const Icon(Icons.refresh),
                  tooltip: '새로고침',
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          CommonWidgets.searchBar(
            controller: _searchController,
            hintText: '회의실 검색...',
            onChanged: (value) {
              if (value.length >= 2) {
                Logger.userAction('회의실 검색', details: {
                  'searchQuery': value,
                  'queryLength': value.length,
                });
              }
              roomViewModel.setSearchQuery(value);
            },
            onClear: () {
              Logger.userAction('검색어 초기화', details: {'screen': '회의실 목록'});
              _searchController.clear();
              roomViewModel.clearSearchQuery();
            },
          ),
          Expanded(
            child: _buildBody(roomState, roomViewModel),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(RoomListState roomState, RoomViewModel roomViewModel) {
    if (roomState.isLoading && roomState.rooms.isEmpty) {
      return CommonWidgets.loadingIndicator();
    }

    if (roomState.error != null && roomState.rooms.isEmpty) {
      return CommonWidgets.errorWidget(
        message: '오류가 발생했습니다: ${roomState.error!}',
        onRetry: () => roomViewModel.refreshRooms(),
      );
    }

    final rooms = roomState.filteredRooms;

    if (rooms.isEmpty) {
      return RefreshIndicator(
        onRefresh: _onPullToRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: CommonWidgets.emptyListWidget(
              icon: Icons.meeting_room,
              message: '회의실이 없습니다',
            ),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _onPullToRefresh,
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          return _buildRoomCard(room, roomViewModel);
        },
      ),
    );
  }

  Widget _buildRoomCard(Room room, RoomViewModel roomViewModel) {
    final lastMessageTime = room.lastMessageTime;
    final lastMessageContent = room.lastMessageContent;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: RoomIcon(room: room, radius: 20),
        title: Text(
          room.name,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            if (lastMessageContent != null && lastMessageContent.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: Text(
                      lastMessageContent,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (lastMessageTime != null) ...[
                    const SizedBox(width: 8),
                    Text(
                      _formatTimeAgo(lastMessageTime),
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ],
              )
            else if (room.description != null && room.description!.isNotEmpty)
              Text(
                room.description!,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[700],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            else
              Text(
                '아직 메시지가 없습니다',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[500],
                  fontStyle: FontStyle.italic,
                ),
              ),
            const SizedBox(height: 4),
            Row(
              children: [
                if (room.createdAt != null) ...[
                  Icon(Icons.access_time, size: 12, color: Colors.grey[500]),
                  const SizedBox(width: 2),
                  Text(
                    '${_formatTimeAgo(room.createdAt)}에 생성',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Icon(Icons.people, size: 12, color: Colors.grey[500]),
                const SizedBox(width: 2),
                Text(
                  '${room.participants.length}명',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                  ),
                ),
                const Spacer(),
                // 활성/비활성 상태 표시
                if (room.isActive)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.green[200]!,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.green[500],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '활성',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.green[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          lastMessageTime != null
                              ? '비활성 (${_formatTimeAgo(lastMessageTime)})'
                              : '비활성',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
        trailing: const Icon(
          Icons.chat,
          color: Colors.blue,
          size: 20,
        ),
        onTap: () async {
          Logger.userAction('회의실 카드 클릭', details: {
            'roomId': room.id,
            'roomName': room.name,
            'participantCount': room.participants.length,
            'isActive': room.isActive,
          });
          Logger.navigation('회의실 목록', '채팅방: ${room.name}');

          roomViewModel.selectRoom(room);

          // 채팅 화면으로 이동하고 돌아올 때까지 대기
          await NavigationHelper.to(
            ChatScreen(room: room),
            routeName: '/chat/${room.id}',
          );

          Logger.navigation('채팅방: ${room.name}', '회의실 목록');
          Logger.info('채팅방에서 회의실 목록으로 복귀');

          // 채팅 화면에서 돌아온 후 해당 방의 최신 메시지 업데이트
          await roomViewModel.refreshRoomAfterChat(room.id);
        },
      ),
    );
  }
} 