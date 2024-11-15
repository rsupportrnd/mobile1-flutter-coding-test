import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../layers/domain/model/chat_message.dart';


class Etc {
  /// 채팅 메시지 생성 날짜
  static chatTimeAgoDisplay(DateTime? targetDate){
    final now = DateTime.now();
    final difference = now.difference(targetDate?? now);

    if (difference.inSeconds < 60) {
      return DateFormat('a hh:mm', 'ko_KR').format(targetDate?? now);
    } else if (difference.inMinutes < 60) {
      return DateFormat('a hh:mm', 'ko_KR').format(targetDate?? now);
    } else if (difference.inHours < 24) {
      return DateFormat('a hh:mm', 'ko_KR').format(targetDate?? now);
    } else if (difference.inDays < 10) {
      return '${difference.inDays}일 전';
    } else if (difference.inDays < 30) {
      return DateFormat('MM. dd.').format(targetDate?? now);
    } else if (difference.inDays < 60) {
      return '1개월 전';
    } else if (difference.inDays < 180) {
      final monthsAgo = (difference.inDays / 30).floor();
      return '$monthsAgo개월 전';
    } else {
      return DateFormat('yyyy. MM. dd.').format(targetDate?? now);
    }
  }

  /// font size fixation
  static MediaQueryData getScaleFontSize(BuildContext context, {double fontSize = 1.0}){
    final mqData = MediaQuery.of(context);
    return mqData.copyWith(textScaler: TextScaler.linear(fontSize));
  }

  /// ISO 8601 형식으로 변환
  static String timestampFormatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
    return formatter.format(dateTime.toUtc()); // UTC 시간으로 변환하여 'Z'를 붙임
  }

  /// datetime을 string으로 변환
  static String timestampToDateString(DateTime timestamp) {
    return DateFormat('yyyy.MM.dd\na hh:mm', 'ko_KR').format(timestamp);
  }

  /// roomId 기준으로 메시지를 필터링하는 함수
  static List<ChatMessage> filterMessagesByRoomId(List<ChatMessage> chatMessages, String roomId) {
    return chatMessages.where((message) => message.roomId == roomId).toList();
  }


}