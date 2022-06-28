import 'package:flutter/material.dart';
import 'package:flutter_app/login/page/login_page.dart';

import 'store/index.dart';
import 'page_index.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key key}) : super(key: key);

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

    /// 设置是否已经包含高德隐私政策并弹窗展示显示用户查看，如果未包含或者没有弹窗展示，高德定位SDK将不会工作
    ///
    /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
    /// <b>必须保证在调用定位功能之前调用， 建议首次启动App时弹出《隐私政策》并取得用户同意</b>
    ///
    /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
    ///
    /// [hasContains] 隐私声明中是否包含高德隐私政策说明
    ///
    /// [hasShow] 隐私权政策是否弹窗展示告知用户
    AMapFlutterLocation.updatePrivacyShow(true, true);

    /// 设置是否已经取得用户同意，如果未取得用户同意，高德定位SDK将不会工作
    ///
    /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
    ///
    /// <b>必须保证在调用定位功能之前调用, 建议首次启动App时弹出《隐私政策》并取得用户同意</b>
    ///
    /// [hasAgree] 隐私权政策是否已经取得用户同意
    AMapFlutterLocation.updatePrivacyAgree(true);

    requestPermission();

    getHitokotoData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      ConstrainedBox(
          constraints: const BoxConstraints.expand(), child: Image.asset("images/splash.jpg", fit: BoxFit.cover)),
      Positioned(
          child: SkipDownTimeProgress(
              color: Colors.red,
              radius: 22.0,
              duration: const Duration(seconds: 5),
              size: const Size(25.0, 25.0),
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
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: Text('${data?.hitokoto ?? ""}',
                    style: const TextStyle(
                        color: Colors.redAccent, fontSize: 16, height: 2.0, decoration: TextDecoration.none))),
            Container(
                padding: const EdgeInsets.only(right: 20),
                alignment: Alignment.centerRight,
                width: double.infinity,
                child: Text('--${data?.from ?? ""}', style: TextStyles.textGrey14))
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
        pushAndRemovePage(context, const HomePage());
      } else {
        pushAndRemovePage(context, LoginPage());
      }
    } else {
      SpUtil.setBool("first_open", false);
      pushAndRemovePage(context, IntroSlidePage());
    }
  }

  void getHitokotoData() async {
    data = await OtherRepository.hitokoto();
    if (mounted) {
      setState(() {});
    }
  }

  /// 动态申请定位权限
  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      Log.d("定位权限申请通过");
    } else {
      Log.d("定位权限申请不通过");
    }
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
