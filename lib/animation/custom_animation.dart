import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

import 'utils/animations.dart';

class CustomAnimationDemo extends StatelessWidget {
  CustomAnimationDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('自定义动画')),
      body: Container(
        padding: EdgeInsets.all(16),
        width: Utils.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text('AnimatedArrow'),
            SizedBox(
              height: 50,
              child: AnimatedArrow(
                  child: FlutterLogo(size: 50), direction: Direction.RIGHT),
            ),
            Line(color: Colors.grey),
            Text('BounceInAnimation'),
            BounceInAnimation(
              child: FlutterLogo(size: 50),
              duration: Duration(seconds: 1),
              delay: Duration(seconds: 1),
            ),
            Line(color: Colors.grey),
            Text('SlideInAnimation'),
            SizedBox(
              height: 50,
              child: Row(
                children: <Widget>[
                  SlideInAnimation(
                      child: Text('测'),
                      duration: Duration(seconds: 1),
                      delay: Duration(seconds: 1),
                      offset: Offset(0, -Utils.height)),
                  SlideInAnimation(
                      child: Text('试'),
                      duration: Duration(seconds: 1),
                      delay: Duration(milliseconds: 1200),
                      offset: Offset(0, -Utils.height)),
                  SlideInAnimation(
                      child: Text('掉'),
                      duration: Duration(seconds: 1),
                      delay: Duration(milliseconds: 1400),
                      offset: Offset(0, -Utils.height)),
                  SlideInAnimation(
                      child: Text('落'),
                      duration: Duration(seconds: 1),
                      delay: Duration(milliseconds: 1600),
                      offset: Offset(0, -Utils.height)),
                  SlideInAnimation(
                      child: Text('文'),
                      duration: Duration(seconds: 1),
                      delay: Duration(milliseconds: 1800),
                      offset: Offset(0, -Utils.height)),
                  SlideInAnimation(
                      child: Text('字'),
                      duration: Duration(seconds: 1),
                      delay: Duration(seconds: 2),
                      offset: Offset(0, -Utils.height)),
                ],
              ),
            ),
            Line(color: Colors.grey),
            Text('SlideFadeInAnimation'),
            SizedBox(
              height: 50,
              child: SlideFadeInAnimation(
                  child: FlutterLogo(size: 50),
                  duration: Duration(seconds: 2),
                  delay: Duration(seconds: 2),
                  offset: Offset(0, Utils.height)),
            ),
            Line(color: Colors.grey),
            Text('FadeOutWidget'),
            SizedBox(
              height: 50,
              child: FadeOutWidget(
                child: FlutterLogo(size: 50),
                duration: Duration(seconds: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
