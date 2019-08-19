import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/login/page/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custom_widgets/skip_down_time_progress.dart';
import 'store/index.dart';
import 'page_index.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  /// 是否第一次打开APP
  bool firstOpen = true;

  /// 是否登录
  bool isLogin = false;

  SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    checkFirstSeen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Image.asset("images/splash.jpg", fit: BoxFit.cover),
      ),
      Positioned(
        child: SkipDownTimeProgress(
          color: Colors.red,
          radius: 22.0,
          duration: Duration(seconds: 5),
          size: Size(25.0, 25.0),
          skipText: "跳过",
          onTap: () => goToHomePage(),
          onFinishCallBack: (bool value) {
            if (value) goToHomePage();
          },
        ),
        top: 30,
        right: 30,
      ),
    ]);
  }

  Future checkFirstSeen(context) async {
    _prefs = await SharedPreferences.getInstance();
    firstOpen = _prefs.getBool("first_open") ?? true;
  }

  void goToHomePage() {
    if (!firstOpen) {
      if (Store.value<UserModel>(context).isLogin()) {
        pushAndRemovePage(context, HomePage());
      } else {
        pushAndRemovePage(context, LoginPage());
      }
    } else {
      _prefs.setBool("first_open", false);
      pushAndRemovePage(context, IntroSlidePage());
    }
  }
}
