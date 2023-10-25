import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/util/theme_consumer.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget with ThemeConsumer {
  const AppDrawer({required this.authService, super.key});

  final IAuthService authService;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.only(bottom: 15, left: 30),
            color: getPrimaryColor(context),
            child: Text(
              'Talkative',
              style: getTextTheme(context).displayMedium,
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) => null,
            itemCount: 0,
          )),
          ListTile(
            onTap: () => authService.logout(),
            leading: Icon(
              Icons.exit_to_app,
              color: getColorScheme(context).error,
            ),
            title: Text(
              'Logout',
              style: TextStyle(color: getColorScheme(context).error),
            ),
          )
        ],
      ),
    );
  }
}
