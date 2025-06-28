import 'package:flutter/material.dart';
import '../config/app_constants.dart';
import '../config/app_text_styles.dart';
import '../utils/icon_utils.dart';

/// Common Widgets
class CommonWidgets {
  static Widget loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  static Widget errorWidget({
    required String message,
    VoidCallback? onRetry,
    String retryButtonText = '다시 시도',
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(IconUtils.error, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            message,
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: Text(retryButtonText),
            ),
          ],
        ],
      ),
    );
  }

  static Widget emptyListWidget({
    required IconData icon,
    required String message,
    String? description,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            message,
            style: AppTextStyles.sectionTitle.copyWith(color: Colors.grey),
          ),
          if (description != null) ...[
            const SizedBox(height: 8),
            Text(
              description,
              style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  static Widget searchBar({
    required TextEditingController controller,
    required String hintText,
    required ValueChanged<String> onChanged,
    VoidCallback? onClear,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: TextField(
        controller: controller,
        style: AppTextStyles.bodyMedium,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: onClear,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }

  static Widget commonCard({
    required Widget child,
    VoidCallback? onTap,
    EdgeInsetsGeometry? margin,
  }) {
    return Card(
      margin: margin ?? const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: 8,
      ),
      elevation: AppConstants.cardElevation,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: child,
      ),
    );
  }

  static Widget statusChip({
    required String label,
    required Color color,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: AppTextStyles.caption.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  /// 새로고침 버튼
  static Widget refreshButton({
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return IconButton(
      onPressed: isLoading ? null : onPressed,
      icon: isLoading 
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(IconUtils.refresh),
    );
  }

  static Widget sectionHeader({
    required String title,
    String? subtitle,
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: 8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.sectionTitle),
                if (subtitle != null)
                  Text(subtitle, style: AppTextStyles.caption),
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
} 