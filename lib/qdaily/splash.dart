import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../page_index.dart';
import 'index.dart';

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

  bool showTimer = false;

  bool showGuidePages = false;
  bool isFirst = true;

  List<Widget> _bannerList = new List();

  @override
  void initState() {
    super.initState();
    isFirst = SpUtil.getBool('qdaily_isFirst', defValue: true);
    debugPrint('===================$isFirst');

    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: 3, milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        showTimer = true;
        setState(() {});
      }
    });

    _initBannerData();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color(0xFF010101),
        child: Stack(children: <Widget>[
          /// 启动页
          AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return Transform.scale(
                    scale: _animation.value,
                    child: SafeArea(
                      child: Stack(
                          alignment: Alignment.topRight,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(top: 50, bottom: 50),
                                alignment: Alignment.center,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Image.asset(
                                          'images/qdaily/qdaily_logo.jpeg'),
                                      Text('「好奇驱动你的世界」',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20))
                                    ])),
                            showTimer
                                ? CountdownWidget(
                                    seconds: 3,
                                    onCountdownFinishCallBack: (bool value) {
                                      if (value) {
                                        if (isFirst) {
                                          setState(() => showGuidePages = true);
                                        } else {
                                          pushReplacement(
                                              context, QDailyIndexPage());
                                        }
                                      }
                                    })
                                : SizedBox()
                          ]),
                    ));
              }),

          /// 引导页
          Offstage(
              offstage: !(isFirst && showGuidePages),
              child: Swiper(
                  loop: false,
                  itemCount: guideList.length,
                  itemBuilder: (context, index) => _bannerList[index]))
        ]));
  }

  void _initBannerData() {
    for (int i = 0, length = guideList.length; i < length; i++) {
      if (i == length - 1) {
        _bannerList.add(Stack(children: <Widget>[
          Image.asset(guideList[i],
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity),
          Container(
              child: Button(
                  borderRadius: 10,
                  onPressed: () {
                    SpUtil.setBool('qdaily_isFirst', false);
                    pushReplacement(context, QDailyIndexPage());
                  },
                  text: '立即体验'),
              width: 200,
              height: 48,
              margin: EdgeInsets.only(bottom: 30))
        ], alignment: Alignment.bottomCenter));
      } else {
        _bannerList.add(Image.asset(guideList[i],
            fit: BoxFit.fill, width: double.infinity, height: double.infinity));
      }
    }
  }
}
