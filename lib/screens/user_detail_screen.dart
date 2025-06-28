import 'package:flutter/material.dart';
import '../config/app_constants.dart';
import '../config/app_text_styles.dart';
import '../models/user.dart';
import '../utils/color_utils.dart';
import '../utils/icon_utils.dart';
import '../utils/logger.dart';
import '../widgets/common_widgets.dart';
import '../widgets/user_avatar.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    Logger.info('사용자 상세 화면 진입: ${user.name}');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('사용자 상세 정보'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 프로필 섹션
              _buildProfileSection(),
              const SizedBox(height: 32),
              
              // 기본 정보 섹션
              CommonWidgets.sectionHeader(title: '기본 정보'),
              const SizedBox(height: 16),
              _buildInfoCard(context, '이름', user.name),
              const SizedBox(height: 12),
              _buildInfoCard(context, '이메일', user.email),
              const SizedBox(height: 12),
              _buildInfoCard(context, 'ID', user.id),
              const SizedBox(height: 12),
              _buildStatusCard(context),
              const SizedBox(height: 12),
              _buildRoleCard(context),
              
              const SizedBox(height: 32),
              
              // 계정 정보 섹션
              CommonWidgets.sectionHeader(title: '계정 정보'),
              const SizedBox(height: 16),
              _buildInfoCard(
                context, 
                '가입일', 
                user.createdAt.toString().split(' ')[0],
              ),
              const SizedBox(height: 12),
              _buildInfoCard(
                context, 
                '마지막 업데이트', 
                user.updatedAt.toString().split(' ')[0],
              ),
              const SizedBox(height: 12),
              _buildAdminStatusCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Center(
      child: Column(
        children: [
          UserAvatar(
            user: user,
            radius: 60,
            showStatusIndicator: true,
            showRoleBadge: true,
          ),
          const SizedBox(height: 16),
          Text(
            user.name,
            style: AppTextStyles.pageTitle,
          ),
          const SizedBox(height: 8),
          Text(
            user.email,
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          CommonWidgets.statusChip(
            label: user.statusDisplayName,
            color: ColorUtils.getStatusColor(user.status),
            icon: IconUtils.getStatusIcon(user.status),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String label, String value) {
    return Card(
      elevation: AppConstants.cardElevation,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                label,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                value,
                style: AppTextStyles.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    return Card(
      elevation: AppConstants.cardElevation,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                '상태',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Icon(
              IconUtils.getStatusIcon(user.status),
              size: 20,
              color: ColorUtils.getStatusColor(user.status),
            ),
            const SizedBox(width: 8),
            Text(
              user.statusDisplayName,
              style: AppTextStyles.bodyMedium.copyWith(
                color: ColorUtils.getStatusColor(user.status),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context) {
    return Card(
      elevation: AppConstants.cardElevation,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                '역할',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(width: 16),
            CommonWidgets.statusChip(
              label: user.roleDisplayName,
              color: ColorUtils.getRoleColor(user.role),
              icon: IconUtils.getRoleIcon(user.role),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminStatusCard(BuildContext context) {
    return Card(
      elevation: AppConstants.cardElevation,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                '관리자',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Icon(
              user.isAdmin ? Icons.check_circle : Icons.cancel,
              size: 20,
              color: user.isAdmin ? Colors.green : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(
              user.isAdmin ? '예' : '아니오',
              style: AppTextStyles.bodyMedium.copyWith(
                color: user.isAdmin ? Colors.green : Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 