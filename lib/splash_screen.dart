import 'package:flutter/material.dart';
import 'package:flutter_app/bean/hitokoto.dart';
import 'package:flutter_app/login/page/login_page.dart';

import 'store/index.dart';
import 'page_index.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  /// 是否第一次打开APP
  bool firstOpen;

  Hitokoto data;

  @override
  void initState() {
    super.initState();

    getHitokotoData();
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
              onTap: () => goToHomePage(context),
              onFinishCallBack: (bool value) {
                if (value) goToHomePage(context);
              }),
          top: Utils.topSafeHeight + 20,
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
          bottom: Utils.height / 2.2)
    ]);
  }

  void goToHomePage(BuildContext context) async {
    firstOpen = SpUtil.getBool('first_open', defValue: true);

    debugPrint("$firstOpen");
    if (!firstOpen) {
      if (Store.value<UserModel>(context, listen: false).isLogin()) {
        pushAndRemovePage(context, HomePage());
      } else {
        pushAndRemovePage(context, LoginPage());
      }
    } else {
      SpUtil.setBool("first_open", false);
      pushAndRemovePage(context, IntroSlidePage());
    }
  }

  void getHitokotoData() async {
    data = await ApiService.hitokoto();
    if (mounted) {
      setState(() {});
    }
  }
}
