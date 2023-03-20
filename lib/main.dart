import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rs_flutter_test/blocs/theme_cubit.dart';
import 'package:rs_flutter_test/pages/my_home_page.dart';
import 'package:rs_flutter_test/styles/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      supportedLocales: const [Locale('en', 'US'), Locale('ko', 'KR')],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<bool> switchinitials = [false, true, false, false, false, false, false, false];

    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state,
            home: MyHomePage(
              switchinitials: switchinitials,
              onChangeTheme: BlocProvider.of<ThemeCubit>(context).switchThemeMode,
            ),
          );
        },
      ),
    );
  }
}
