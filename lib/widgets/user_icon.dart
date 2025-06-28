import 'package:flutter/material.dart';
import '../models/user.dart';
import '../config/app_constants.dart';
import '../utils/color_utils.dart';
import '../utils/icon_utils.dart';

class UserIcon extends StatefulWidget {
  final User? user;
  final String? imageUrl;
  final String? fallbackText;
  final double radius;
  final bool showStatusIndicator;
  final bool showRoleBadge;

  const UserIcon({
    super.key,
    this.user,
    this.imageUrl,
    this.fallbackText,
    this.radius = AppConstants.avatarRadius,
    this.showStatusIndicator = false,
    this.showRoleBadge = false,
  });

  @override
  State<UserIcon> createState() => _UserIconState();
}

class _UserIconState extends State<UserIcon> {
  bool _hasImageError = false;

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.imageUrl ?? widget.user?.profilePicture;
    final shouldShowImage = imageUrl != null && imageUrl.isNotEmpty && !_hasImageError;

    return Stack(
      children: [
        CircleAvatar(
          radius: widget.radius,
          backgroundColor: Colors.grey[300],
          backgroundImage: shouldShowImage 
              ? NetworkImage(imageUrl)
              : null,
          onBackgroundImageError: shouldShowImage
              ? (exception, stackTrace) {
                  if (mounted) {
                    setState(() {
                      _hasImageError = true;
                    });
                  }
                  debugPrint('UserAvatar 이미지 로딩 실패: $imageUrl, 오류: $exception');
                }
              : null,
          child: !shouldShowImage
              ? _buildFallbackContent()
              : null,
        ),
        
        // 상태 표시 점
        if (widget.showStatusIndicator && widget.user != null)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: AppConstants.statusIndicatorSize,
              height: AppConstants.statusIndicatorSize,
              decoration: BoxDecoration(
                color: ColorUtils.getStatusColor(widget.user!.status),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
        
        // 역할 배지
        if (widget.showRoleBadge && widget.user?.isAdmin == true)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: ColorUtils.getRoleColor(widget.user!.role),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Icon(
                IconUtils.getRoleIcon(widget.user!.role),
                size: 10,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFallbackContent() {
    final text = widget.fallbackText ?? 
                 (widget.user?.name.isNotEmpty == true 
                     ? widget.user!.name[0].toUpperCase()
                     : '?');

    return Text(
      text,
      style: TextStyle(
        fontSize: widget.radius * 0.8,
        fontWeight: FontWeight.bold,
        color: Colors.grey[600],
      ),
    );
  }

  @override
  void didUpdateWidget(UserIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    final oldUrl = oldWidget.imageUrl ?? oldWidget.user?.profilePicture;
    final newUrl = widget.imageUrl ?? widget.user?.profilePicture;
    
    if (oldUrl != newUrl) {
      _hasImageError = false;
    }
  }
} 