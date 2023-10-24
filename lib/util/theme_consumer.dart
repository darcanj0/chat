import 'package:flutter/material.dart';

mixin ThemeConsumer {
  ThemeData getTheme(BuildContext context) {
    return Theme.of(context);
  }

  TextTheme getTextTheme(BuildContext context) {
    return getTheme(context).textTheme;
  }

  ColorScheme getColorScheme(BuildContext context) {
    return getTheme(context).colorScheme;
  }

  Color getPrimaryColor(BuildContext context) {
    return getTheme(context).primaryColor;
  }
}
