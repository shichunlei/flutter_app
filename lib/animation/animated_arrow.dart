import 'package:flutter/material.dart';

import '../page_index.dart';

class AnimatedArrowDemo extends StatefulWidget {
  AnimatedArrowDemo({Key key}) : super(key: key);

  @override
  createState() => _AnimatedArrowDemoState();
}

class _AnimatedArrowDemoState extends State<AnimatedArrowDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

    _animation.addStatusListener((value) {
      if (value == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 500), () {
          _controller.reset();
        });
      } else if (value == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('AnimatedArrow')),
        body: Center(
            child: AnimatedArrow(
                animation: _animation,
                child: Icon(Icons.keyboard_arrow_down, size: 20),
                direction: Direction.DOWN)));
  }
}

/// 源码出自：https://juejin.im/post/5d646c9e6fb9a06b084d037e
class AnimatedArrow extends AnimatedWidget {
  final Tween<double> _opacityTween = Tween(begin: 1.0, end: 0.0);
  final Tween<double> _marginTween = Tween(begin: 80, end: 0);

  final Widget child;
  final Direction direction;
  final Animation<double> animation;

  AnimatedArrow(
      {Key key,
      this.animation,
      this.child: const Icon(Icons.keyboard_arrow_up, size: 20),
      this.direction: Direction.UP})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Opacity(
          opacity: _opacityTween.evaluate(animation),
          child: Container(
              child: child,
              margin: EdgeInsets.only(
                  top: direction == Direction.UP
                      ? _marginTween.evaluate(animation)
                      : 0,
                  left: direction == Direction.LEFT
                      ? _marginTween.evaluate(animation)
                      : 0,
                  right: direction == Direction.RIGHT
                      ? _marginTween.evaluate(animation)
                      : 0,
                  bottom: direction == Direction.DOWN
                      ? _marginTween.evaluate(animation)
                      : 0))),
    );
  }
}
