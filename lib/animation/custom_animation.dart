import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

import 'utils/animations.dart';

class CustomAnimationDemo extends StatelessWidget {
  const CustomAnimationDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('自定义动画')),
      body: Container(
        padding: const EdgeInsets.all(16),
        width: Utils.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const Text('AnimatedArrow'),
            SizedBox(
              height: 50,
              child: AnimatedArrow(child: const FlutterLogo(size: 50), direction: Direction.RIGHT),
            ),
            Line(color: Colors.grey),
            const Text('BounceInAnimation'),
            const BounceInAnimation(
              child: FlutterLogo(size: 50),
              duration: Duration(seconds: 1),
              delay: Duration(seconds: 1),
            ),
            Line(color: Colors.grey),
            const Text('SlideInAnimation'),
            SizedBox(
              height: 50,
              child: Row(
                children: <Widget>[
                  SlideInAnimation(
                      child: const Text('测'),
                      duration: const Duration(seconds: 1),
                      delay: const Duration(seconds: 1),
                      offset: Offset(0, -Utils.height)),
                  SlideInAnimation(
                      child: const Text('试'),
                      duration: const Duration(seconds: 1),
                      delay: const Duration(milliseconds: 1200),
                      offset: Offset(0, -Utils.height)),
                  SlideInAnimation(
                      child: const Text('掉'),
                      duration: const Duration(seconds: 1),
                      delay: const Duration(milliseconds: 1400),
                      offset: Offset(0, -Utils.height)),
                  SlideInAnimation(
                      child: const Text('落'),
                      duration: const Duration(seconds: 1),
                      delay: const Duration(milliseconds: 1600),
                      offset: Offset(0, -Utils.height)),
                  SlideInAnimation(
                      child: const Text('文'),
                      duration: const Duration(seconds: 1),
                      delay: const Duration(milliseconds: 1800),
                      offset: Offset(0, -Utils.height)),
                  SlideInAnimation(
                      child: const Text('字'),
                      duration: const Duration(seconds: 1),
                      delay: const Duration(seconds: 2),
                      offset: Offset(0, -Utils.height)),
                ],
              ),
            ),
            Line(color: Colors.grey),
            const Text('SlideFadeInAnimation'),
            SizedBox(
              height: 50,
              child: SlideFadeInAnimation(
                  child: const FlutterLogo(size: 50),
                  duration: const Duration(seconds: 2),
                  delay: const Duration(seconds: 2),
                  offset: Offset(0, Utils.height)),
            ),
            Line(color: Colors.grey),
            const Text('FadeOutWidget'),
            const SizedBox(
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
