import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/baixing_life/index.dart';
import 'package:flutter_app/lang/config.dart';
import 'package:flutter_app/lang/index.dart';
import 'package:flutter_app/splash_screen.dart';
import 'package:flutter_app/store/index.dart';
import 'package:flutter_app/store/models/config_state_model.dart';
import 'package:flutter_app/utils/log_util.dart';

import 'package:flutter/services.dart';
import 'package:flutter_app/utils/sp_util.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'global/theme.dart';

void main() async {
  setCustomErrorPage();
  _setTargetPlatformForDesktop();
  await SPUtil.getInstance();
  runZoned(() {
    /// 强制竖屏
    SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
        .then((_) {
      runApp(Store.init(child: MyApp()));

      if (Platform.isAndroid) {
        // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
        // SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
        // SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      }
    });
  }, onError: (Object error, StackTrace stack) {
    LogUtil.e(error);
    LogUtil.e(stack);
  });
}

void setCustomErrorPage() {
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    LogUtil.e(flutterErrorDetails.toString());
    return Center(child: Text("Flutter 走神了"));
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

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 定义全局 语言代理
  AppLocalizationsDelegate _delegate;

  @override
  void initState() {
    super.initState();
    _delegate = AppLocalizationsDelegate();
    Store.setStoreCtx(context); // 初始化数据层
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Store.value<ConfigModel>(context).$getTheme();

    return Store.connect<ConfigModel>(builder: (context, child, model) {
      return MaterialApp(
        /// 任务管理器显示的标题
        title: "Flutter Demo",

        /// 您可以通过配置ThemeData类轻松更改应用程序的主题
        theme: AppTheme.getThemeData(model.theme),

        /// 右上角显示一个debug的图标
        debugShowCheckedModeBanner: false,

        /// 主页
        home: SplashScreenPage(),

        /// locale: Locale('zh', 'CH'),
        localeResolutionCallback: (deviceLocale, supportedLocal) {
          print(
              '当前设备语种 deviceLocale: $deviceLocale, 支持语种 supportedLocale: $supportedLocal}');
          // 判断传入语言是否支持
          Locale _locale = supportedLocal.contains(deviceLocale)
              ? deviceLocale
              : Locale('zh', 'CH');
          return _locale;
        },
        onGenerateTitle: (context) {
          // 设置多语言代理
          AppLocalizations.setProxy(setState, _delegate);
          return 'flutter';
        },

        /// localizationsDelegates 列表中的元素时生成本地化集合的工厂
        localizationsDelegates: [
          // 为Material Components库提供本地化的字符串和其他值
          GlobalMaterialLocalizations.delegate,

          // 定义widget默认的文本方向，从左往右或从右往左
          GlobalWidgetsLocalizations.delegate,

          _delegate
        ],
        supportedLocales: LanguageConfig.supportedLocales,

        routes: <String, WidgetBuilder>{
          '/shopCart': (BuildContext context) => IndexPage(index: 2)
        },
      );
    });
  }
}
