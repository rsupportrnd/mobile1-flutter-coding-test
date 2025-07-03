import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/di/viewmodel_provider.dart';
import 'package:mobile1_flutter_coding_test/presentation/screen/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Chat App',
      home: GlobalLoadingWrapper(child: MainScreen()),
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
