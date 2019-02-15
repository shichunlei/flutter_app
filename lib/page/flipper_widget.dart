import 'dart:math';

import 'package:flutter/material.dart';

class FlipperWidget extends StatefulWidget {
  @override
  _FlipperWidgetState createState() => _FlipperWidgetState();
}

class _FlipperWidgetState extends State<FlipperWidget>
    with SingleTickerProviderStateMixin {
  bool reversed = false;
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: -pi / 2),
        weight: 0.5,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -pi / 2, end: 0.0),
        weight: 0.5,
      )
    ]).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _doAnim() {
    if (!mounted) return;
    if (reversed) {
      _controller.reverse();
      reversed = false;
    } else {
      _controller.forward();
      reversed = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Flipper Widget'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) => Transform(
                /// 设置container的变换矩阵，类型为Matrix4
                transform: Matrix4.identity()
                  ..setEntry(
                    3,
                    2,
                    0.001,
                  )
                  ..rotateY(
                    _animation.value,
                  ),

                /// 控制child的对齐方式
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: _doAnim,

                  /// IndexedStack继承自Stack，它的作用是显示第index个child，其他child都是不可见的。所以IndexedStack的尺寸永远是跟最大的子节点尺寸一致。
                  child: IndexedStack(
                    children: <Widget>[
                      CardOne(),
                      CardTwo(),
                    ],

                    /// 对齐方式，默认是左上角（topStart）
                    alignment: Alignment.center,

                    /// children中显示的子Widget下标
                    index: _controller.value < 0.5 ? 0 : 1,
                  ),
                ),
              ),
        ),
      ),
    );
  }
}

class CardOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red,
      child: Container(
        width: 300,
        height: 200,
        child: Center(
          child: Text(
            "Tap to see the code",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
        ),
      ),
    );
  }
}

class CardTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: Container(
        width: 300,
        height: 200,
        child: Center(
          child: Text(
            "356789",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 35.0,
            ),
          ),
        ),
      ),
    );
  }
}
