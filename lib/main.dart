import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/di/service_provider.dart';
import 'package:mobile1_flutter_coding_test/presentation/screen/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat App',
      home: const HomeScreen(),
      builder: (context, child) {
        return GlobalLoadingWrapper(
            child: child ??
                const SizedBox.shrink(
                  child: Text("화면을 불러올 수 없습니다."),
                ));
      },
    );
  }
}

class GlobalLoadingWrapper extends ConsumerWidget {
  final Widget child;

  const GlobalLoadingWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        child,
        if (ref.watch(globalLoadingProvider))
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0x99F6F7F8),
            child: const Center(
              child: IgnorePointer(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );
  }
}
