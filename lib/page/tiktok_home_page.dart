import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';

/// 展示类似TikTok(抖音)的手势交互效果
class TikTokPage extends StatefulWidget {
  TikTokPage({Key key}) : super(key: key);

  @override
  createState() => _TikTokPageState();
}

class _TikTokPageState extends State<TikTokPage> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  double offsetX = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = Utils.width;
    final screenHeight = Utils.height;

    return Scaffold(
      body: GestureDetector(
        child: Container(
          color: Colors.black,
          child: Stack(
            children: <Widget>[
              buildLeftPage(screenWidth),
              buildMiddlePage(),
              buildRightPage(context, screenWidth, screenHeight)
            ],
          ),
        ),
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
        },
      ),
    );
  }

  /// 左侧Widget
  ///
  /// 通过 [Transform.scale] 进行根据 [offsetX] 缩放
  /// 最小 0.88 最大为 1
  Transform buildLeftPage(double screenWidth) {
    // 缩放可以直接采用Transform.scale
    return Transform.scale(
      scale: 0.88 + 0.12 * offsetX / screenWidth < 0.88
          ? 0.88
          : 0.88 + 0.12 * offsetX / screenWidth,
      child: Container(
        child: Image.asset(
          "images/left.png",
          fit: BoxFit.fill,
        ),
        // 前景色可以用foregroundDecoration通过改变Color的透明度来达到效果
        foregroundDecoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 1 - (offsetX / screenWidth)),
        ),
      ),
    );
  }

  /// 中间 Widget
  ///
  /// 通过 [Transform.translate] 根据 [offsetX] 进行偏移
  /// 水平偏移量为 [ offsetX] / 5 产生视差效果
  Transform buildMiddlePage() {
    return Transform.translate(
      offset: Offset(offsetX > 0 ? offsetX : offsetX / 5, 0),
      child: PageView(
        children: List(10)
            .map((_) => Container(
                  child: Image.asset(
                    "images/middle.jpg",
                    fit: BoxFit.fill,
                  ),
                ))
            .toList(),
        scrollDirection: Axis.vertical,
      ),
    );
  }

  /// 右侧Widget
  ///
  /// 通过 [Transform.translate] 根据 [offsetX] 进行偏移
  Transform buildRightPage(
      BuildContext context, double screenWidth, double screenHeight) {
    return Transform.translate(
        offset: Offset(max(0, offsetX + screenWidth), 0),
        child: Container(
          width: screenWidth,
          height: screenHeight,
          color: Colors.transparent,
          child: Image.asset(
            "images/right.jpg",
            fit: BoxFit.fill,
            width: screenWidth,
          ),
        ));
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
