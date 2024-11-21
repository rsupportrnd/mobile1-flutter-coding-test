import 'package:mobile1_flutter_coding_test/index.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(color: Colors.grey),
        canvasColor: Colors.white,
        highlightColor: Colors.white,
        brightness: Brightness.light,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      routerConfig: router,
    );
  }
}
