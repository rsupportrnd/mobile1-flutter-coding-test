import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/features/user/data/models/user_model.dart';
import 'package:mobile1_flutter_coding_test/features/user/data/models/user_status.dart';
import 'package:mobile1_flutter_coding_test/features/user/data/models/user_role.dart';

class UserDetailModal extends StatelessWidget {
  final User user;

  const UserDetailModal({
    super.key,
    required this.user,
  });

  static void show(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (context) => UserDetailModal(user: user),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('사용자 정보'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              _buildProfileSection(),
              const SizedBox(height: 32),

              // Contact Information
              _buildContactSection(),
              const SizedBox(height: 32),

              // Status and Role
              _buildStatusSection(),
              const SizedBox(height: 32),
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
          // Profile Image
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey[300]!,
                width: 3,
              ),
            ),
            child: ClipOval(
              child: Image.network(
                user.profilePicture,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Name
          Text(
            user.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // User ID
          Text(
            'ID: ${user.userId}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '연락처 정보',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildInfoTile(
          icon: Icons.email,
          title: '이메일',
          value: user.email,
          onTap: () {
            // TODO: 이메일 앱 열기
          },
        ),
      ],
    );
  }

  Widget _buildStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '상태 정보',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: _buildStatusCard(
                title: '상태',
                child: _buildStatusChip(user.status),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatusCard(
                title: '역할',
                child: _buildRoleChip(user.role),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.blue[600],
                  size: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        value,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onTap != null)
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(UserStatus status) {
    Color backgroundColor;
    Color textColor;
    String statusText;
    IconData icon;

    switch (status) {
      case UserStatus.online:
        backgroundColor = Colors.green;
        textColor = Colors.white;
        statusText = '온라인';
        icon = Icons.circle;
        break;
      case UserStatus.offline:
        backgroundColor = Colors.grey;
        textColor = Colors.white;
        statusText = '오프라인';
        icon = Icons.circle;
        break;
      case UserStatus.away:
        backgroundColor = Colors.orange;
        textColor = Colors.white;
        statusText = '자리비움';
        icon = Icons.access_time;
        break;
      case UserStatus.doNotDisturb:
        backgroundColor = Colors.red;
        textColor = Colors.white;
        statusText = '방해금지';
        icon = Icons.do_not_disturb;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: textColor,
            size: 12,
          ),
          const SizedBox(width: 6),
          Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleChip(UserRole role) {
    String roleText;
    Color backgroundColor;
    IconData icon;

    switch (role) {
      case UserRole.admin:
        roleText = '관리자';
        backgroundColor = Colors.blue;
        icon = Icons.admin_panel_settings;
        break;
      case UserRole.member:
        roleText = '멤버';
        backgroundColor = Colors.teal;
        icon = Icons.person;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 12,
          ),
          const SizedBox(width: 6),
          Text(
            roleText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

}