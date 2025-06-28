import 'package:flutter/material.dart';
import '../models/room.dart';
import '../config/app_constants.dart';
import '../utils/color_utils.dart';

class RoomIcon extends StatelessWidget {
  final Room room;
  final double radius;
  final bool showActiveIndicator;

  const RoomIcon({
    super.key,
    required this.room,
    this.radius = AppConstants.avatarRadius,
    this.showActiveIndicator = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: _getRoomColor(),
          child: Text(
            room.initials,
            style: TextStyle(
              fontSize: radius * 0.8,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        
        // 활성 상태 표시
        if (showActiveIndicator)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: AppConstants.statusIndicatorSize,
              height: AppConstants.statusIndicatorSize,
              decoration: BoxDecoration(
                color: room.isActive ? Colors.green : Colors.grey,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Color _getRoomColor() {
    // 룸 이름의 해시코드를 기반으로 색상 생성
    final hash = room.name.hashCode;
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
      Colors.cyan,
    ];
    
    return colors[hash.abs() % colors.length];
  }
} 