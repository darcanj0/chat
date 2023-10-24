import 'package:chat/pages/loading_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 67, 218, 238)),
        useMaterial3: true,
      ),
      home: const LoadingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
