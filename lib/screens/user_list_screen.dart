import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_constants.dart';
import '../config/app_text_styles.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../utils/color_utils.dart';
import '../utils/icon_utils.dart';
import '../utils/logger.dart';
import '../widgets/common_widgets.dart';
import '../widgets/user_avatar.dart';
import 'user_detail_screen.dart';

class UserListScreen extends ConsumerStatefulWidget {
  const UserListScreen({super.key});

  @override
  ConsumerState<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> 
    with TickerProviderStateMixin {
  late AnimationController _refreshButtonController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Logger.info('사용자 목록 화면 진입');
    
    _refreshButtonController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    // 화면 초기화 시 사용자 목록 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(usersProvider.notifier).loadUsers();
    });
  }

  @override
  void dispose() {
    _refreshButtonController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onRefreshButtonPressed() async {
    Logger.userAction('새로고침 버튼 클릭', details: {'screen': '사용자 목록'});
    
    _refreshButtonController.repeat();
    
    try {
      await ref.read(usersProvider.notifier).refreshUsers();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text('사용자 목록이 업데이트되었습니다'),
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
      Logger.error('사용자 목록 새로고침 실패', error: e);
      
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
    Logger.userAction('Pull-to-refresh 액션', details: {'screen': '사용자 목록'});
    
    try {
      await ref.read(usersProvider.notifier).refreshUsers();
    } catch (e) {
      Logger.error('Pull-to-refresh 새로고침 실패', error: e);
      rethrow;
    }
  }

  void _onSearchChanged(String query) {
    ref.read(usersProvider.notifier).searchUsers(query);
  }

  void _onClearSearch() {
    _searchController.clear();
    ref.read(usersProvider.notifier).searchUsers('');
  }

  @override
  Widget build(BuildContext context) {
    final usersState = ref.watch(usersProvider);
    final filteredUsers = ref.watch(filteredUsersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('사용자 목록'),
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
            hintText: '사용자 검색...',
            onChanged: _onSearchChanged,
            onClear: _onClearSearch,
          ),
          
          // 사용자 목록
          Expanded(
            child: _buildBody(usersState, filteredUsers),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(UsersState usersState, List<User> filteredUsers) {
    if (usersState.isLoading && usersState.users.isEmpty) {
      return CommonWidgets.loadingIndicator();
    }

    if (usersState.error != null && usersState.users.isEmpty) {
      return CommonWidgets.errorWidget(
        message: '오류가 발생했습니다: ${usersState.error!}',
        onRetry: () => ref.read(usersProvider.notifier).refreshUsers(),
      );
    }

    if (filteredUsers.isEmpty) {
      return RefreshIndicator(
        onRefresh: _onPullToRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: CommonWidgets.emptyListWidget(
              icon: Icons.people,
              message: usersState.searchQuery.isEmpty 
                  ? '사용자가 없습니다'
                  : '검색 결과가 없습니다',
              description: usersState.searchQuery.isEmpty 
                  ? null
                  : '"${usersState.searchQuery}"에 대한 검색 결과가 없습니다',
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
        itemCount: filteredUsers.length,
        itemBuilder: (context, index) {
          final user = filteredUsers[index];
          return _buildUserCard(user);
        },
      ),
    );
  }

  Widget _buildUserCard(User user) {
    return CommonWidgets.commonCard(
      onTap: () {
        Logger.userAction('사용자 카드 클릭', details: {
          'userId': user.id,
          'userName': user.name,
          'userRole': user.role,
          'userStatus': user.status,
        });
        
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UserDetailScreen(user: user),
          ),
        );
      },
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppConstants.defaultPadding),
        leading: UserAvatar(
          user: user,
          radius: AppConstants.avatarRadius,
          showStatusIndicator: true,
          showRoleBadge: true,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                user.name,
                style: AppTextStyles.sectionTitle,
              ),
            ),
            // 역할 배지
            CommonWidgets.statusChip(
              label: user.roleDisplayName,
              color: ColorUtils.getRoleColor(user.role),
              icon: IconUtils.getRoleIcon(user.role),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              user.email,
              style: AppTextStyles.bodyMedium,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  IconUtils.getStatusIcon(user.status),
                  size: 14,
                  color: ColorUtils.getStatusColor(user.status),
                ),
                const SizedBox(width: 4),
                Text(
                  user.statusDisplayName,
                  style: AppTextStyles.caption.copyWith(
                    color: ColorUtils.getStatusColor(user.status),
                  ),
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