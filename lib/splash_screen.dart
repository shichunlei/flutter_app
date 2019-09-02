import 'dart:async';

import 'package:custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/hitokoto.dart';
import 'package:flutter_app/login/page/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Hitokoto data;

  @override
  void initState() {
    super.initState();

    getHitokotoData();

    checkFirstSeen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Image.asset("images/splash.jpg", fit: BoxFit.cover)),
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
              }),
          top: 30,
          right: 30),
      Positioned(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: Text('${data?.hitokoto ?? ""}',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16,
                        height: 2.0,
                        decoration: TextDecoration.none))),
            Container(
                padding: EdgeInsets.only(right: 20),
                alignment: Alignment.centerRight,
                width: double.infinity,
                child:
                    Text('--${data?.from ?? ""}', style: TextStyles.textGrey14))
          ]),
          left: 0,
          right: 0,
          bottom: 300)
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

  void getHitokotoData() async {
    data = await ApiService.hitokoto();

    setState(() {});
  }
}
