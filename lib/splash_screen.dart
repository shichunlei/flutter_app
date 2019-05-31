import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/home_page.dart';
import 'package:flutter_app/intro_slide_page.dart';
import 'package:flutter_app/login/page/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/utils/route_util.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    checkFirstSeen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset("images/splash.jpg"),
    );
  }

  Future checkFirstSeen(context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool _seen = sp.getBool("first_open") ?? false;
    bool isLogin = sp.getBool("isLogin") ?? false;

    if (_seen) {
      if (isLogin) {
        pushAndRemovePage(context, HomePage());
      } else {
        pushAndRemovePage(context, LoginPage());
      }
    } else {
      sp.setBool("first_open", true);
      pushAndRemovePage(context, IntroSlidePage());
    }
  }
}
