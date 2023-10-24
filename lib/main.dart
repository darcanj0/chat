import 'package:chat/pages/auth_page.dart';
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
    );

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
      home: const AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
