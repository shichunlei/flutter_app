import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/splash_screen.dart';

void main() {
  setCustomErrorPage();
  _setTargetPlatformForDesktop();
  runApp(MyApp());
}

void setCustomErrorPage() {
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    print(flutterErrorDetails.toString());
    return Center(
      child: Text("Flutter 走神了"),
    );
  };
}

/// If the current platform is desktop, override the default platform to
/// a supported platform (iOS for macOS, Android for Linux and Windows).
/// Otherwise, do nothing.
void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

class MyApp extends StatelessWidget {
  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",

      /// 您可以通过配置ThemeData类轻松更改应用程序的主题
      theme: ThemeData(primaryColor: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: SplashScreenPage(),
    );
  }
}
