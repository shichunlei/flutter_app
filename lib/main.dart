import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/baixing_life/index.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/bloc/setting_bloc.dart';
import 'package:flutter_app/splash_screen.dart';
import 'package:flutter_app/utils/log_util.dart';

import 'package:flutter/services.dart';
import 'package:flutter_app/utils/sp_util.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  setCustomErrorPage();
  _setTargetPlatformForDesktop();
  await SPUtil.getInstance();
  runZoned(() {
    /// 强制竖屏
    SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
        .then((_) {
      runApp(MyApp());

      if (Platform.isAndroid) {
        // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
        // SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
        // SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      }
    });
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

class MyApp extends StatelessWidget {
  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: SettingBloc(), // 主题色切换 BLoC
        child: MaterialApp(
          /// 任务管理器显示的标题
          title: "Flutter Demo",

          /// 您可以通过配置ThemeData类轻松更改应用程序的主题
          theme: ThemeData(
            primaryColor: Colors.pinkAccent,

            /// 高亮颜色
            highlightColor: Color.fromRGBO(255, 255, 255, 0.5),

            /// 水波纹颜色
            splashColor: Colors.grey,
          ),

          /// 右上角显示一个debug的图标
          debugShowCheckedModeBanner: false,

          /// 主页
          home: SplashScreenPage(),

          supportedLocales: const [const Locale('zh')],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],

          routes: <String, WidgetBuilder>{
            '/shopCart': (BuildContext context) => IndexPage(index: 2),
          },
        ));
  }
}
