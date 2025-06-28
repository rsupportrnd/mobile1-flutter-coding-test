import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_constants.dart';
import '../config/app_text_styles.dart';
import '../models/room.dart';
import '../providers/room_provider.dart';
import '../utils/color_utils.dart';
import '../utils/format_helpers.dart';
import '../utils/icon_utils.dart';
import '../utils/logger.dart';
import '../widgets/common_widgets.dart';
import '../widgets/room_icon.dart';
import 'chat_screen.dart';

class RoomListScreen extends ConsumerStatefulWidget {
  const RoomListScreen({super.key});

  @override
  ConsumerState<RoomListScreen> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends ConsumerState<RoomListScreen> 
    with TickerProviderStateMixin {
  late AnimationController _refreshButtonController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Logger.info('룸 목록 화면 진입');
    
    _refreshButtonController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    // 화면 초기화 시 룸 목록 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(roomsProvider.notifier).loadRooms();
    });
  }

  @override
  void dispose() {
    _refreshButtonController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onRefreshButtonPressed() async {
    Logger.userAction('새로고침 버튼 클릭', details: {'screen': '룸 목록'});
    
    _refreshButtonController.repeat();
    
    try {
      await ref.read(roomsProvider.notifier).refreshRooms();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text('룸 목록이 업데이트되었습니다'),
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
      Logger.error('룸 목록 새로고침 실패', error: e);
      
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
      if (mounted) {
        _refreshButtonController.stop();
        _refreshButtonController.reset();
      }
    }
  }

  Future<void> _onPullToRefresh() async {
    Logger.userAction('Pull-to-refresh 액션', details: {'screen': '룸 목록'});
    
    try {
      await ref.read(roomsProvider.notifier).refreshRooms();
    } catch (e) {
      Logger.error('Pull-to-refresh 새로고침 실패', error: e);
      rethrow;
    }
  }

  void _onSearchChanged(String query) {
    ref.read(roomsProvider.notifier).searchRooms(query);
  }

  void _onClearSearch() {
    _searchController.clear();
    ref.read(roomsProvider.notifier).searchRooms('');
  }

  @override
  Widget build(BuildContext context) {
    final roomsState = ref.watch(roomsProvider);
    final filteredRooms = ref.watch(filteredRoomsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('룸 목록'),
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
          // 검색바
          CommonWidgets.searchBar(
            controller: _searchController,
            hintText: '룸 검색...',
            onChanged: _onSearchChanged,
            onClear: _onClearSearch,
          ),
          
          // 룸 목록
          Expanded(
            child: _buildBody(roomsState, filteredRooms),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(RoomsState roomsState, List<Room> filteredRooms) {
    if (roomsState.isLoading && roomsState.rooms.isEmpty) {
      return CommonWidgets.loadingIndicator();
    }

    if (roomsState.error != null && roomsState.rooms.isEmpty) {
      return CommonWidgets.errorWidget(
        message: '오류가 발생했습니다: ${roomsState.error!}',
        onRetry: () => ref.read(roomsProvider.notifier).refreshRooms(),
      );
    }

    if (filteredRooms.isEmpty) {
      return RefreshIndicator(
        onRefresh: _onPullToRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: CommonWidgets.emptyListWidget(
              icon: Icons.meeting_room,
              message: roomsState.searchQuery.isEmpty 
                  ? '룸이 없습니다'
                  : '검색 결과가 없습니다',
              description: roomsState.searchQuery.isEmpty 
                  ? null
                  : '"${roomsState.searchQuery}"에 대한 검색 결과가 없습니다',
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
        itemCount: filteredRooms.length,
        itemBuilder: (context, index) {
          final room = filteredRooms[index];
          return _buildRoomCard(room);
        },
      ),
    );
  }

  Widget _buildRoomCard(Room room) {
    return CommonWidgets.commonCard(
      onTap: () {
        Logger.userAction('룸 카드 클릭', details: {
          'roomId': room.id,
          'roomName': room.name,
          'isActive': room.isActive,
        });
        
        // 현재 룸 선택
        ref.read(currentRoomProvider.notifier).selectRoom(room.id);
        
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatScreen(room: room),
          ),
        );
      },
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppConstants.defaultPadding),
        leading: RoomIcon(
          room: room,
          radius: AppConstants.avatarRadius,
          showActiveIndicator: true,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                room.name,
                style: AppTextStyles.sectionTitle,
              ),
            ),
            // 활성 상태 표시
            CommonWidgets.statusChip(
              label: room.isActive ? '활성' : '비활성',
              color: room.isActive ? Colors.green : Colors.grey,
              icon: room.isActive ? Icons.circle : Icons.circle_outlined,
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              room.description,
              style: AppTextStyles.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 14,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  '생성자: ${room.creator}',
                  style: AppTextStyles.caption,
                ),
                const Spacer(),
                Text(
                  FormatHelpers.formatDateTime(room.createdAt),
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right, size: 16),
      ),
    );
  }
} 