import 'package:flutter/material.dart';
import 'video.dart';
import 'package:flutter_app/utils/utils.dart';

import 'left_menu.dart';
import 'person.dart';

/// 展示类似TikTok(抖音)的手势交互效果
class TikTokPage extends StatefulWidget {
  TikTokPage({Key key}) : super(key: key);

  @override
  createState() => _TikTokPageState();
}

class _TikTokPageState extends State<TikTokPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  double offsetX = 0.0;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = Utils.width;

    return Scaffold(
        body: GestureDetector(
            child: Container(
                color: Colors.black,
                child: Stack(children: <Widget>[
                  LeftMenu(offsetX: offsetX),
                  VideoPage(offsetX: offsetX),
                  PersonPage(offsetX: offsetX)
                ])),
            onHorizontalDragEnd: (details) {
              // 当滑动停止的时候 根据 offsetX 的偏移量进行动画
              // 为了方便这里取 screenWidth / 2为临界条件
              if (offsetX.abs() < screenWidth / 2) {
                animateToMiddle();
              } else if (offsetX > 0) {
                animateToLeft(screenWidth);
              } else {
                animateToRight(screenWidth);
              }
            },
            onHorizontalDragStart: (_) {
              _controller?.stop();
            },
            onHorizontalDragUpdate: (details) {
              // 控制 offsetX 的值在 -screenWidth 到 screenWidth 之间
              if (offsetX + details.delta.dx >= screenWidth) {
                setState(() {
                  offsetX = screenWidth;
                });
              } else if (offsetX + details.delta.dx <= -screenWidth) {
                setState(() {
                  offsetX = -screenWidth;
                });
              } else {
                setState(() {
                  offsetX += details.delta.dx;
                });
              }
            }));
  }

  /// 滑动到中间
  void animateToMiddle() {
    _controller = AnimationController(
        duration: Duration(milliseconds: offsetX.abs() * 1000 ~/ 500),
        vsync: this);
    _animation = Tween(begin: offsetX, end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic))
      ..addListener(() {
        setState(() {
          offsetX = _animation.value;
        });
      });
    _controller.forward();
  }

  /// 滑动到左边
  void animateToLeft(double screenWidth) {
    _controller = AnimationController(
        duration: Duration(milliseconds: offsetX.abs() * 1000 ~/ 500),
        vsync: this);
    _animation = Tween(begin: offsetX, end: screenWidth).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic))
      ..addListener(() {
        setState(() {
          offsetX = _animation.value;
        });
      });
    _controller.forward();
  }

  /// 滑动到右边
  void animateToRight(double screenWidth) {
    _controller = AnimationController(
        duration: Duration(milliseconds: offsetX.abs() * 1000 ~/ 500),
        vsync: this);
    _animation = Tween(begin: offsetX, end: -screenWidth).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic))
      ..addListener(() {
        setState(() {
          offsetX = _animation.value;
        });
      });
    _controller.forward();
  }
}
