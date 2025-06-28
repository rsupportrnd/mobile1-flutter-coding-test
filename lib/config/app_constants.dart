class AppConstants {
  // API 관련 상수
  static const String baseUrl = 'https://raw.githubusercontent.com/rsupportrnd/mobile1-flutter-coding-test/refs/heads/main/api';
  static const String usersEndpoint = '/users.json';
  static const String roomsEndpoint = '/rooms.json';
  static const String messagesEndpoint = '/messages.json';

  // 앱 정보
  static const String appTitle = 'RSUPPORT Coding Test';

  // 네트워크 Timeout
  static const Duration requestTimeout = Duration(seconds: 30);
  static const Duration connectionTimeout = Duration(seconds: 15);

  // UI 상수
  static const double defaultPadding = 16.0;
  static const double cardElevation = 2.0;
  static const double borderRadius = 12.0;
  static const double avatarRadius = 25.0;
  static const double statusIndicatorSize = 16.0;

  // 애니메이션 Duration
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration shortAnimationDuration = Duration(milliseconds: 150);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
  static const Duration snackBarDuration = Duration(seconds: 3);
  static const Duration dialogShowDuration = Duration(milliseconds: 200);

  static const int maxMessageLength = 1000;
  static const int messagesPerPage = 50;

  // 에러 메시지
  static const String networkErrorMessage = '네트워크 연결을 확인해주세요';
  static const String unknownErrorMessage = '알 수 없는 오류가 발생했습니다';
  static const String loadingUsersErrorMessage = '사용자 목록을 불러오는데 실패했습니다';
  static const String loadingRoomsErrorMessage = '회의실 목록을 불러오는데 실패했습니다';
  static const String loadingMessagesErrorMessage = '메시지를 불러오는데 실패했습니다';

  static const Duration userCacheValidDuration = Duration(minutes: 5);
  static const Duration roomCacheValidDuration = Duration(minutes: 5);
  static const Duration messageCacheValidDuration = Duration(minutes: 5);

  // Cache Key
  static const String cachedUsersKey = 'cached_users';
  static const String cachedRoomsKey = 'cached_rooms';
  static const String cachedMessagesKey = 'local_messages';
  static const String usersLastUpdateKey = 'users_last_update';
  static const String roomsLastUpdateKey = 'rooms_last_update';

  // Log Tag
  static const String appRouteObserverTag = 'AppRouteObserver';
  static const String routeManagerTag = 'RouteManager';
  static const String chatAppLoggerTag = 'ChatApp';

  // API URLs Helper
  static String getUsersUrl() => '$baseUrl$usersEndpoint';
  static String getRoomsUrl() => '$baseUrl$roomsEndpoint';
  static String getMessagesUrl() => '$baseUrl$messagesEndpoint';
}

/// 사용자 상태 관련 Config
class UserStatusConfig {
  static const String online = 'online';
  static const String offline = 'offline';
  static const String away = 'away';
  static const String doNotDisturb = 'do_not_disturb';
  
  static const Map<String, String> statusDisplayNames = {
    online: '온라인',
    offline: '오프라인',
    away: '자리비움',
    doNotDisturb: '방해금지',
  };
  
  static const List<String> allStatuses = [
    online,
    offline,
    away,
    doNotDisturb,
  ];
}

/// 사용자 역할 관련 Config
class UserRoleConfig {
  static const String admin = 'admin';
  static const String member = 'member';

  static const Map<String, String> roleDisplayNames = {
    admin: '관리자',
    member: '멤버',
  };
  
  static const List<String> allRoles = [
    admin,
    member,
  ];
}


/// 앱 테마 Config
class AppThemeConfig {
  static const int primaryColorValue = 0xFF161616;
  
  static const int onlineColorValue = 0xFF4CAF50;   // Green
  static const int offlineColorValue = 0xFF9E9E9E;  // Grey
  static const int awayColorValue = 0xFFFF9800;     // Orange
  static const int dndColorValue = 0xFFF44336;      // Red
  
  static const int adminColorValue = 0xFFFF9800;    // Orange
  static const int memberColorValue = 0xFF2196F3;   // Blue
  static const int moderatorColorValue = 0xFF9C27B0; // Purple
  
  static const double titleTextSize = 24.0;
  static const double subtitleTextSize = 18.0;
  static const double bodyTextSize = 16.0;
  static const double captionTextSize = 14.0;
  static const double smallTextSize = 12.0;
  static const double tinyTextSize = 10.0;
  
  static const Duration messageRefreshInterval = Duration(seconds: 30);
  static const Duration typingIndicatorDuration = Duration(seconds: 3);
  static const Duration messageCleanupMaxAge = Duration(days: 30);
} 