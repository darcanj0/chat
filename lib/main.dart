import 'package:chat/core/services/auth/infra/auth_service_firebase.dart';
import 'package:chat/core/services/notification/push_notification_service.dart';
import 'package:chat/firebase_options.dart';
import 'package:chat/interface/pages/app_proxy_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ChatNotificationService(),
      )
    ],
    child: const MyApp(),
  ));
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
        bodySmall: const TextStyle(
          fontSize: 13,
        ),
        bodyMedium: const TextStyle(
          fontSize: 17,
          color: Colors.black87,
          fontWeight: FontWeight.w400,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          color: colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
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
      home: AppProxyPage(authService: AuthServiceFirebase.instance),
      debugShowCheckedModeBanner: false,
    );
  }
}
