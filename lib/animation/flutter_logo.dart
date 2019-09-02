import 'package:flutter/material.dart';

class FlutterLogoWidget extends StatefulWidget {
  FlutterLogoWidget({Key key}) : super(key: key);

  @override
  _FlutterLogoWidgetState createState() => _FlutterLogoWidgetState();
}

class _FlutterLogoWidgetState extends State<FlutterLogoWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation _animation;

  bool forward = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('FlutterLogo')),
        body: Center(
            child: Container(
                // 透明度动画
                // child: FadeTransition(opacity: _animation, child: FlutterLogo(size: 100.0)),

                child: RotationTransition(
                    // 旋转动画
                    turns: _animation,
                    child: FlutterLogo(size: 200.0)))),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (forward)
                _controller.forward(); //向前播放动画
              else
                _controller.reverse(); //向后播放动画
              forward = !forward;
            },
            child: Icon(Icons.brush)));
  }
}
