import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../page_index.dart';
import 'index.dart';

class QDailySplashPage extends StatefulWidget {
  QDailySplashPage({Key key}) : super(key: key);

  @override
  createState() => _QDailySplashPageState();
}

class _QDailySplashPageState extends State<QDailySplashPage>
    with SingleTickerProviderStateMixin {
  String logoUrl =
      'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1830402097,3777822172&fm=58&s=21D47F829AD9C49A91BDA5D2010010B3&bpow=121&bpoh=75';

  String logo = 'http://www.qdaily.com/images/icon-login-logo.png';

  AnimationController _controller;
  Animation _animation;

  bool showTimer = false;

  bool showGuidePages = false;
  bool isFirst = true;

  List<Widget> _bannerList = [];

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          showTimer = true;
          setState(() {});
        }
      });

    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      isFirst = SpUtil.getBool('qdaily_isFirst', defValue: true);
      debugPrint('===================$isFirst');

      if (isFirst) {
        /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
        guideList.forEach((image) => precacheImage(AssetImage(image), context));
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
                            Visibility(
                                visible: showTimer,
                                child: CountdownWidget(
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
                                    }))
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
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity),
          Container(
              child: Button(
                  borderRadius: 10,
                  onPressed: () {
                    SpUtil.setBool('qdaily_isFirst', false);
                    pushReplacement(context, QDailyIndexPage());
                  },
                  child: Text("立即体验", style: TextStyle(fontSize: 18))),
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
