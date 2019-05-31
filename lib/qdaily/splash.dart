import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/qdaily/index.dart';
import 'package:flutter_app/utils/route_util.dart';

class QdailySplashPage extends StatefulWidget {
  QdailySplashPage({Key key}) : super(key: key);

  @override
  createState() => _QdailySplashPageState();
}

class _QdailySplashPageState extends State<QdailySplashPage>
    with SingleTickerProviderStateMixin {
  String logoUrl =
      'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1830402097,3777822172&fm=58&s=21D47F829AD9C49A91BDA5D2010010B3&bpow=121&bpoh=75';

  String logo = 'http://www.qdaily.com/images/icon-login-logo.png';

  AnimationController _controller;
  Animation _animation;

  Timer timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: 3, milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        timer = Timer(
            Duration(seconds: 1), () => pushReplacement(context, IndexPage()));
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return Transform.scale(
            scale: _animation.value,
            child: Scaffold(
              backgroundColor: Color(0xFF010101),
              body: Container(
                padding: EdgeInsets.only(top: 50, bottom: 50),
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset('images/qdaily/qdaily_logo.jpeg'),
                      Text('「好奇驱动你的世界」',
                          style: TextStyle(color: Colors.white, fontSize: 20))
                    ]),
              ),
            ),
          );
        });
  }
}
