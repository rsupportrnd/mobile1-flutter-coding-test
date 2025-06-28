import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/room.dart';
import '../config/app_constants.dart';
import '../utils/color_utils.dart';

class RoomIcon extends StatefulWidget {
  final Room room;
  final double radius;

  const RoomIcon({
    super.key,
    required this.room,
    this.radius = 20,
  });

  @override
  State<RoomIcon> createState() => _RoomIconState();
}

class _RoomIconState extends State<RoomIcon> {
  bool _hasImageError = false;

  @override
  void didUpdateWidget(RoomIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    // room이 변경되면 에러 상태 초기화
    if (oldWidget.room != widget.room) {
      _hasImageError = false;
    }
  }

  void _onImageError() {
    if (mounted && !_hasImageError) {
      setState(() {
        _hasImageError = true;
      });
    }
  }

  Widget _buildDefaultRoomIcon() {
    return Container(
      width: widget.radius * 2,
      height: widget.radius * 2,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.meeting_room,
        size: widget.radius,
        color: Colors.blue[700],
      ),
    );
  }

  Widget _buildRoomInitials() {
    return Container(
      width: widget.radius * 2,
      height: widget.radius * 2,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          widget.room.initials,
          style: TextStyle(
            fontSize: widget.radius * 0.8,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 이미지 URL이 없거나 에러가 발생한 경우
    if (widget.room.thumbnailImage == null || _hasImageError) {
      return widget.room.initials.isNotEmpty
          ? _buildRoomInitials()
          : _buildDefaultRoomIcon();
    }

    // 이미지가 있는 경우 (이미 위에서 null 체크 완료)
    final thumbnailImage = widget.room.thumbnailImage!;
    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: Colors.grey[300],
      child: ClipOval(
        child: Image.network(
          thumbnailImage,
          width: widget.radius * 2,
          height: widget.radius * 2,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _onImageError();
            });
            return widget.room.initials.isNotEmpty
                ? _buildRoomInitials()
                : _buildDefaultRoomIcon();
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              width: widget.radius * 2,
              height: widget.radius * 2,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SizedBox(
                  width: widget.radius,
                  height: widget.radius,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}