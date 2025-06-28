import 'package:flutter/material.dart';

/// 앱 전체 텍스트 스타일 관리 클래스

class AppTextStyles {
  // =============================================================================
  // 기본 폰트 패밀리
  // =============================================================================
  static const String _poppins = 'Poppins';
  static const String _notoSans = 'NotoSans';
  static const String _montserrat = 'Montserrat';

  // =============================================================================
  // 헤더 스타일 (Montserrat - 우아하고 세련된 느낌)
  // =============================================================================
  
  /// 앱바 제목 (큰 헤더)
  static const TextStyle appBarTitle = TextStyle(
    fontFamily: _montserrat,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: Colors.black87,
  );

  /// 페이지 제목 (중간 헤더)
  static const TextStyle pageTitle = TextStyle(
    fontFamily: _montserrat,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
  );

  /// 섹션 제목 (작은 헤더)
  static const TextStyle sectionTitle = TextStyle(
    fontFamily: _montserrat,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
  );

  /// 카드 제목
  static const TextStyle cardTitle = TextStyle(
    fontFamily: _montserrat,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  // =============================================================================
  // 본문 스타일 (NotoSans - 한글 지원 우수)
  // =============================================================================

  /// 기본 본문 텍스트
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _notoSans,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// 중간 본문 텍스트
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _notoSans,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  /// 작은 본문 텍스트
  static const TextStyle bodySmall = TextStyle(
    fontFamily: _notoSans,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  /// 설명 텍스트
  static const TextStyle caption = TextStyle(
    fontFamily: _notoSans,
    fontSize: 12,
    fontWeight: FontWeight.w300,
    height: 1.2,
  );

  /// 라벨 텍스트
  static const TextStyle label = TextStyle(
    fontFamily: _notoSans,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  // =============================================================================
  // 버튼 스타일 (Poppins - 모던하고 깔끔함)
  // =============================================================================

  /// 큰 버튼 텍스트
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: _poppins,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  /// 중간 버튼 텍스트
  static const TextStyle buttonMedium = TextStyle(
    fontFamily: _poppins,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3,
  );

  /// 작은 버튼 텍스트
  static const TextStyle buttonSmall = TextStyle(
    fontFamily: _poppins,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3,
  );

  // =============================================================================
  // 특수 스타일 (Poppins - 강조 및 액션)
  // =============================================================================

  /// 강조 텍스트
  static const TextStyle emphasis = TextStyle(
    fontFamily: _poppins,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  /// 링크 텍스트
  static const TextStyle link = TextStyle(
    fontFamily: _poppins,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline,
  );

  /// 에러 텍스트
  static const TextStyle error = TextStyle(
    fontFamily: _notoSans,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.red,
  );

  // =============================================================================
  // 채팅 관련 스타일
  // =============================================================================

  /// 채팅 메시지 텍스트
  static const TextStyle chatMessage = TextStyle(
    fontFamily: _notoSans,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  /// 채팅 사용자 이름
  static const TextStyle chatUserName = TextStyle(
    fontFamily: _poppins,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  /// 채팅 시간
  static const TextStyle chatTime = TextStyle(
    fontFamily: _notoSans,
    fontSize: 10,
    fontWeight: FontWeight.w300,
    color: Colors.grey,
  );

  // =============================================================================
  // 리스트 아이템 스타일
  // =============================================================================

  /// 리스트 제목
  static const TextStyle listTitle = TextStyle(
    fontFamily: _poppins,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: Colors.black54,
  );

  /// 리스트 부제목
  static const TextStyle listSubtitle = TextStyle(
    fontFamily: _notoSans,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.3,
    color: Colors.black54,
  );

  /// 리스트 메타 정보
  static const TextStyle listMeta = TextStyle(
    fontFamily: _notoSans,
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: Colors.black54,
  );

  // =============================================================================
  // 상태 관련 스타일
  // =============================================================================

  /// 온라인 상태
  static const TextStyle statusOnline = TextStyle(
    fontFamily: _poppins,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: Colors.green,
  );

  /// 오프라인 상태
  static const TextStyle statusOffline = TextStyle(
    fontFamily: _poppins,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );

  /// 역할 배지
  static const TextStyle roleBadge = TextStyle(
    fontFamily: _poppins,
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  // =============================================================================
  // 폼 관련 스타일
  // =============================================================================

  /// 입력 필드 텍스트
  static const TextStyle inputText = TextStyle(
    fontFamily: _notoSans,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  /// 입력 필드 힌트
  static const TextStyle inputHint = TextStyle(
    fontFamily: _notoSans,
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: Colors.grey,
  );

  /// 입력 필드 라벨
  static const TextStyle inputLabel = TextStyle(
    fontFamily: _poppins,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3,
  );

  // =============================================================================
  // 유틸리티 메서드
  // =============================================================================

  /// 색상을 적용한 텍스트 스타일 생성
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// 크기를 조정한 텍스트 스타일 생성
  static TextStyle withSize(TextStyle style, double fontSize) {
    return style.copyWith(fontSize: fontSize);
  }

  /// 굵기를 조정한 텍스트 스타일 생성
  static TextStyle withWeight(TextStyle style, FontWeight fontWeight) {
    return style.copyWith(fontWeight: fontWeight);
  }

  /// 여러 속성을 한번에 조정한 텍스트 스타일 생성
  static TextStyle customize(
    TextStyle style, {
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) {
    return style.copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
    );
  }
} 