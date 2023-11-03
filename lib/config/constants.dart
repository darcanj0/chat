import 'package:envied/envied.dart';
part 'constants.g.dart';

@Envied(requireEnvFile: true, path: '.env.dev')
abstract class Env {
  // global
  @EnviedField(varName: 'PROJECT_ID')
  static const String projectId = _Env.projectId;

  @EnviedField(varName: 'MESSAGING_SENDER_ID')
  static const String messagingSenderId = _Env.messagingSenderId;

  // web
  @EnviedField(varName: 'WEB_API_KEY')
  static const String webApiKey = _Env.webApiKey;

  @EnviedField(varName: 'WEB_APP_ID')
  static const String webAppId = _Env.webAppId;

  @EnviedField(varName: 'MEASUREMENT_ID')
  static const String measurementId = _Env.measurementId;

  // android
  @EnviedField(varName: 'ANDROID_APP_ID')
  static const String androidAppId = _Env.androidAppId;

  @EnviedField(varName: 'ANDROID_API_KEY')
  static const String androidApiKey = _Env.androidApiKey;

  // ios
  @EnviedField(varName: 'IOS_APP_ID')
  static const String iosAppId = _Env.iosAppId;

  @EnviedField(varName: 'IOS_API_KEY')
  static const String iosApiKey = _Env.iosApiKey;
}
