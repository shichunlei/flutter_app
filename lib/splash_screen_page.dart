import 'package:flutter/material.dart';
import 'package:flutter_app/intro_slide_page.dart';
import 'home_page.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  createState() => SplashScreenStatePage();
}

class SplashScreenStatePage extends State<SplashScreenPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 3000),
    );

    animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(controller);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            /// builder 是一个WidgetBuilder类型的回调函数，它的作用是构建路由页面的具体内容，返回值是一个widget。我们通常要实现此回调，返回新路由的实例。
            builder: (context) => IntroSlidePage(),
          ),
          (route) => route == null,
        );
      }
    });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FadeTransition(
      opacity: animation,
      child: Image.asset(
        'images/splash.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
