import 'package:chat/core/services/auth/infra/auth_service_mock.dart';
import 'package:chat/pages/app_proxy_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const seedColor = Color.fromARGB(255, 19, 231, 238);

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
    );

    final textTheme = TextTheme(
        displayLarge: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 40,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
        displayMedium: TextStyle(
          color: colorScheme.onBackground,
          fontSize: 30,
        ),
        displaySmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: colorScheme.onBackground,
        ));

    final darkTextTheme = TextTheme(
      displayMedium: TextStyle(
        color: colorScheme.onPrimary,
        fontSize: 30,
      ),
    );

    return MaterialApp(
      title: 'Talkative',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        textTheme: darkTextTheme,
      ),
      theme: ThemeData(
        primaryColor: seedColor,
        textTheme: textTheme,
        colorScheme: colorScheme,
        useMaterial3: true,
      ),
      home: AppProxyPage(authService: AuthServiceMock.instance),
      debugShowCheckedModeBanner: false,
    );
  }
}
