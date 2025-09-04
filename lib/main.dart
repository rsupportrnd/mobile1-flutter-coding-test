import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile1_flutter_coding_test/core/router/router.dart';
import 'package:mobile1_flutter_coding_test/core/storage/hive_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 한국어 로케일 데이터 초기화
  await initializeDateFormatting('ko', null);

  // Hive 스토리지 초기화
  await HiveStorage.instance.init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mobile1 Flutter Coding Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
