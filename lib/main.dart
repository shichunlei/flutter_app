import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/splash_screen.dart';
import 'package:flutter_app/utils/log_util.dart';
import 'package:flutter_app/utils/sp_util.dart';

void main() async {
  int themeIndex = await getTheme();
  setCustomErrorPage();
  _setTargetPlatformForDesktop();
  runZoned(() {
    runApp(MyApp(themeIndex));
  }, onError: (dynamic error, dynamic stack) {
    LogUtil.e(error);
    LogUtil.e(stack);
  });
}

void setCustomErrorPage() {
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    LogUtil.e(flutterErrorDetails.toString());
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

Future<int> getTheme() async {
  int themeIndex = SPUtil.getInt('themeIndex');
  if (themeIndex != null) {
    return themeIndex;
  }
  return 0;
}

class MyApp extends StatefulWidget {
  int themeIndex;

  MyApp(this.themeIndex, {Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color themeColor;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// 任务管理器显示的标题
      title: "Flutter Demo",

      /// 您可以通过配置ThemeData类轻松更改应用程序的主题
      theme: ThemeData(
          primaryColor: Colors.pinkAccent,
          primaryColorLight: Colors.purpleAccent,
          bottomAppBarColor: Colors.deepOrange,
          buttonColor: Colors.tealAccent,
          backgroundColor: Colors.teal),

      /// 右上角显示一个debug的图标
      debugShowCheckedModeBanner: false,

      /// 主页
      home: SplashScreenPage(),

      /// 打开一个覆盖图，显示框架报告的可访问性信息 显示边框
      showSemanticsDebugger: false,

      /// 打开性能监视，覆盖在屏幕最上面
      showPerformanceOverlay: false,

      /// 显示网格
      debugShowMaterialGrid: false,
    );
  }
}
