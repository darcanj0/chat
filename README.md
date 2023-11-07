
# Chat App

A fully functional chat app built with Flutter


## Live Demo

You will likely experience issues in this demo, for it is not meant for web. In this case, there's issues with the Flutter [image-picker](https://pub.dev/packages/image_picker) library running in web browsers. The purpose of this demo is to preview how the app would work in a mobile device.


## Running locally

Firsts things first, you will need to have installed on your computer

- [VSCode](https://code.visualstudio.com/) with both official Dart and Flutter extensions installed
- [Dart SDK](https://dart.dev/get-dart)
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Android Studio](https://developer.android.com/studio/install?hl=pt-br) with a proper android emulator (or any Ios emulator)
- [Flutter Doctor ready for development](https://docs.flutter.dev/get-started/install/windows#run-flutter-doctor)

Clone

```bash
  git clone https://github.com/darcanj0/chat.git
```

Go to the project folder

```bash
  cd chat
```

Install dependencies

```bash
  flutter pub get
```

Before running the following command, checkout the Environments Variables setup and also the Firebase setup 

Run project

```bash
  flutter run lib/main.dart
```


## Environment Variables
First thing you will need to do is create a Firebase Project and add your app to it.

After acquiring the needed variables, do the following:

In the project root folder, create a .env.dev file and add the following variables.

- Global Variables
`PROJECT_ID`
`MESSAGING_SENDER_ID`

- Web Variables
`MEASUREMENT_ID`
`WEB_APP_ID`
`WEB_API_KEY`


- Android Variables
`ANDROID_API_KEY`
`ANDROID_APP_ID`

- Ios Variables
`IOS_APP_ID`
`IOS_API_KEY`

Now, build the constants file with the following command. Make sure to run this after installing the projects dependencies, or else it wont generate the constants file.

```bash
  dart run build_runner build
```





## Roadmap

- Create contacts pages

- Separate conversations between contacts

- Implement media sharing in conversations


## Authors

- [@darcanj0](https://www.github.com/darcanj0)

