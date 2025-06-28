import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../router/navigation_helper.dart';
import '../viewmodels/user_viewmodel.dart';
import 'user_detail_screen.dart';
import '../config/app_constants.dart';
import '../config/app_text_styles.dart';
import '../utils/color_utils.dart';
import '../utils/icon_utils.dart';
import '../utils/logger.dart';
import '../widgets/user_icon.dart';
import '../widgets/common_widgets.dart';
import '../models/user.dart';

class UsersView extends ConsumerStatefulWidget {
  const UsersView({super.key});

  @override
  ConsumerState<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends ConsumerState<UsersView> with TickerProviderStateMixin {
  late AnimationController _refreshButtonController;

  @override
  void initState() {
    super.initState();
    Logger.info('사용자 목록 화면 진입');

    // Refresh 버튼 애니메이션 컨트롤러
    _refreshButtonController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // 화면 초기화 시 사용자 목록 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Logger.info('사용자 목록 로드 시작');
      ref.read(userViewModelProvider.notifier).loadUsers();
    });
  }

  @override
  void dispose() {
    _refreshButtonController.dispose();
    super.dispose();
  }

  // Refresh 함수 (버튼 클릭 시)
  Future<void> _onRefreshButtonPressed() async {
    Logger.userAction('새로고침 버튼 클릭', details: {'screen': '사용자 목록'});
    final userViewModel = ref.read(userViewModelProvider.notifier);

    // 회전 애니메이션 시작
    _refreshButtonController.repeat();

    try {
      await userViewModel.refreshUsers();
      Logger.info('사용자 목록 새로고침 성공');

      // 성공 시 스낵바 표시
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
    Logger.userAction('Pull-to-refresh 액션', details: {'screen': '사용자 목록'});
    final userViewModel = ref.read(userViewModelProvider.notifier);

    try {
      await userViewModel.refreshUsers();
      Logger.info('Pull-to-refresh 새로고침 성공');
    } catch (e) {
      Logger.error('Pull-to-refresh 새로고침 실패', error: e);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userViewModelProvider);
    final userViewModel = ref.read(userViewModelProvider.notifier);

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
      body: _buildBody(userState, userViewModel),
    );
  }

  Widget _buildBody(UserListState userState, UserViewModel userViewModel) {
    if (userState.isLoading && userState.users.isEmpty) {
      return CommonWidgets.loadingIndicator();
    }

    if (userState.error != null && userState.users.isEmpty) {
      return CommonWidgets.errorWidget(
        message: '오류가 발생했습니다: ${userState.error!}',
        onRetry: () => userViewModel.refreshUsers(),
      );
    }

    if (userState.users.isEmpty) {
      return RefreshIndicator(
        onRefresh: _onPullToRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: CommonWidgets.emptyListWidget(
              icon: Icons.people,
              message: '사용자가 없습니다',
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
        itemCount: userState.users.length,
        itemBuilder: (context, index) {
          final user = userState.users[index];
          return _buildUserCard(user, userViewModel);
        },
      ),
    );
  }

  Widget _buildUserCard(User user, UserViewModel userViewModel) {
    return CommonWidgets.commonCard(
      onTap: () {
        Logger.userAction('사용자 카드 클릭', details: {
          'userId': user.id,
          'userName': user.name,
          'userRole': user.role,
          'userStatus': user.status,
        });
        Logger.navigation('사용자 목록', '사용자 상세: ${user.name}');

        userViewModel.selectUser(user);
        NavigationHelper.to(
          UserDetailScreen(user: user),
          routeName: '/user/${user.id}',
        );
      },
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppConstants.defaultPadding),
        leading: UserIcon(
          user: user,
          radius: AppConstants.avatarRadius,
          showStatusIndicator: true,
          showRoleBadge: true,
        ),
        title: Row(
          spacing: 12,
          children: [
            Text(
              user.name,
              style: AppTextStyles.listTitle,
            ),
            // 역할 배지
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: ColorUtils.getRoleColor(user.role),
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
              child: Text(
                user.roleDisplayName,
                style: AppTextStyles.withColor(
                  AppTextStyles.roleBadge,
                  ColorUtils.getTextColor(ColorUtils.getRoleColor(user.role)),
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              user.email,
              style: AppTextStyles.listSubtitle,
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
                  style: AppTextStyles.withColor(
                    AppTextStyles.emphasis,
                    ColorUtils.getStatusColor(user.status),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(IconUtils.forward, size: 16),
      ),
    );
  }
} 