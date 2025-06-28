import 'package:flutter/material.dart';
import '../models/user.dart';
import '../config/app_constants.dart';
import '../utils/color_utils.dart';
import '../utils/icon_utils.dart';
import '../widgets/user_icon.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('사용자 상세 정보'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 프로필 섹션
              _buildProfileSection(),
              const SizedBox(height: 24),

              // 기본 정보 섹션
              _buildSectionHeader('기본 정보'),
              const SizedBox(height: 12),
              _buildInfoCard('이름', user.name),
              const SizedBox(height: 12),
              _buildInfoCard('이메일', user.email),
              const SizedBox(height: 12),
              _buildStatusCard(),
              const SizedBox(height: 12),
              _buildRoleCard(),
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
          UserIcon(
            user: user,
            radius: 60,
            showStatusIndicator: true,
            showRoleBadge: true,
          ),
          const SizedBox(height: 16),
          Text(
            user.name,
            style: const TextStyle(
              fontSize: AppThemeConfig.titleTextSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            user.email,
            style: const TextStyle(
              fontSize: AppThemeConfig.bodyTextSize,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: AppThemeConfig.subtitleTextSize,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      elevation: AppConstants.cardElevation,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: AppThemeConfig.bodyTextSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: AppThemeConfig.bodyTextSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      elevation: AppConstants.cardElevation,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Row(
          children: [
            const SizedBox(
              width: 80,
              child: Text(
                '상태',
                style: TextStyle(
                  fontSize: AppThemeConfig.bodyTextSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
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
              style: TextStyle(
                fontSize: AppThemeConfig.bodyTextSize,
                color: ColorUtils.getStatusColor(user.status),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard() {
    return Card(
      elevation: AppConstants.cardElevation,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Row(
          children: [
            const SizedBox(
              width: 80,
              child: Text(
                '역할',
                style: TextStyle(
                  fontSize: AppThemeConfig.bodyTextSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: ColorUtils.getRoleColor(user.role),
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    IconUtils.getRoleIcon(user.role),
                    size: 16,
                    color: ColorUtils.getTextColor(ColorUtils.getRoleColor(user.role)),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    user.roleDisplayName,
                    style: TextStyle(
                      fontSize: AppThemeConfig.smallTextSize,
                      color: ColorUtils.getTextColor(ColorUtils.getRoleColor(user.role)),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 