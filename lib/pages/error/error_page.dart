import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile1_flutter_coding_test/routers/router_util.dart';

class ErrorPage extends StatelessWidget {
  final String errorString;
  const ErrorPage({super.key, required this.errorString});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error: $errorString',
              style: const TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () => context.go(AppPath.main.toPath),
              child: const Text('Go to Main Page'),
            ),
          ],
        ),
      ),
    );
  }
}
