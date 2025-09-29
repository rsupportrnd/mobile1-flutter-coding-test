import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/core/router/app_router.dart';

void main() async {
  await initialize();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // 빌드 모드에 따른 환경변수 파일 로드
    if (kReleaseMode) {
      // 프로덕션 모드
      await dotenv.load(fileName: ".env.prod");
      print('✅ 프로덕션 환경변수 로드됨');
    } else {
      // 개발 모드 (debug)
      await dotenv.load(fileName: ".env.dev");
      print('✅ 개발 환경변수 로드됨');
    }

    // 환경변수 로드 확인
    final apiBaseUrl = dotenv.env['API_BASE_URL'];
    final debugMode = dotenv.env['DEBUG_MODE'];
    print('📡 API Base URL: $apiBaseUrl');
    print('🐛 Debug Mode: $debugMode');

  } catch (e) {
    print('❌ 환경변수 파일 로드 실패: $e');
    print('앱을 시작할 수 없습니다.');
    throw Exception('환경변수 파일을 로드할 수 없습니다: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'RSUPPORT Coding Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: AppRouter.router,
    );
  }
}
