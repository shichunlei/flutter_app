import 'package:flutter/material.dart';

class CurvesDemo extends StatefulWidget {
  CurvesDemo({Key key}) : super(key: key);

  @override
  createState() => _CurvesDemoState();
}

class _CurvesDemoState extends State<CurvesDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation _curvedAnimation;

  Tween _opacityTween;
  Tween _scaleTween;
  Tween _rotationTween;
  Tween _slideTween;

  Curve _curve = Curves.bounceIn;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _curvedAnimation = CurvedAnimation(parent: _controller, curve: _curve);

    // The Tweens are static because they don't change.
    _opacityTween = Tween<double>(begin: 0.0, end: 1.0);
    _scaleTween = Tween<double>(begin: 0.0, end: 1.0);
    _rotationTween = Tween<double>(begin: 0.0, end: 1.0);
    _slideTween = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset.zero);

    _controller
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // 动画从 controller.forward() 正向执行 结束时会回调此方法
          print("status is completed");
          // 重置起点
          //_controller.reset();
          // 开启
          // _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          // 动画从 controller.reverse() 反向执行 结束时会回调此方法
          print("status is dismissed");
          // 重置起点
          //_controller.reset();
          // 开启
          // _controller.forward();
        } else if (status == AnimationStatus.forward) {
          print("status is forward");
          // 执行 controller.forward() 会回调此状态
        } else if (status == AnimationStatus.reverse) {
          // 执行 controller.reverse() 会回调此状态
          print("status is reverse");
        }
      })
      ..addListener(() {
        debugPrint('====${_controller.value}');
      })
      ..forward();
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
      appBar: AppBar(title: Text('CurvesDemo'), actions: <Widget>[
        PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuItem<Curve>>[
                  PopupMenuItem<Curve>(
                      value: Curves.bounceIn, child: Text('bounceIn')),
                  PopupMenuItem<Curve>(
                      value: Curves.bounceInOut, child: Text('bounceInOut')),
                  PopupMenuItem<Curve>(
                      value: Curves.bounceOut, child: Text('bounceOut')),
                  PopupMenuItem<Curve>(
                      value: Curves.decelerate, child: Text('decelerate')),
                  PopupMenuItem<Curve>(value: Curves.ease, child: Text('ease')),
                  PopupMenuItem<Curve>(
                      value: Curves.easeIn, child: Text('easeIn')),
                  PopupMenuItem<Curve>(
                      value: Curves.easeInBack, child: Text('easeInBack')),
                  PopupMenuItem<Curve>(
                      value: Curves.easeInCirc, child: Text('easeInCirc')),
                  PopupMenuItem<Curve>(
                      value: Curves.easeInCubic, child: Text('easeInCubic')),
                  PopupMenuItem<Curve>(
                      value: Curves.easeInExpo, child: Text('easeInExpo')),
                  PopupMenuItem<Curve>(
                      value: Curves.easeInOut, child: Text('easeInOut')),
                  PopupMenuItem<Curve>(
                      value: Curves.easeInOutBack,
                      child: Text('easeInOutBack')),
                  PopupMenuItem<Curve>(
                      value: Curves.easeInOutCirc,
                      child: Text('easeInOutCirc')),
                  PopupMenuItem<Curve>(
                      value: Curves.easeInOutCubic,
                      child: Text('easeInOutCubic')),
                  PopupMenuItem<Curve>(
                      value: Curves.easeInOutExpo,
                      child: Text('easeInOutExpo')),
                  PopupMenuItem<Curve>(
                      value: Curves.easeInOutQuad,
                      child: Text('easeInOutQuad')),
                  PopupMenuItem<Curve>(
                      value: Curves.easeInOutQuart,
                      child: Text('easeInOutQuart')),
                  PopupMenuItem<Curve>(
                      value: Curves.easeInOutSine,
                      child: Text('easeInOutSine')),
                  PopupMenuItem<Curve>(
                      value: Curves.easeInOutQuint,
                      child: Text('easeInOutQuint')),
                  PopupMenuItem<Curve>(
                      value: Curves.easeInQuad, child: Text('easeInQuad')),
                  PopupMenuItem<Curve>(
                      value: Curves.easeInQuint, child: Text('easeInQuint')),
                  PopupMenuItem<Curve>(
                      value: Curves.easeInQuart, child: Text('easeInQuart')),
                  PopupMenuItem<Curve>(
                      value: Curves.easeInSine, child: Text('easeInSine')),
                  PopupMenuItem<Curve>(
                      value: Curves.easeInToLinear,
                      child: Text('easeInToLinear')),
                  PopupMenuItem<Curve>(
                      value: Curves.slowMiddle, child: Text('slowMiddle')),
                  PopupMenuItem<Curve>(
                      value: Curves.linear, child: Text('linear')),
                  PopupMenuItem<Curve>(
                      value: Curves.linearToEaseOut,
                      child: Text('linearToEaseOut')),
                  PopupMenuItem<Curve>(
                      value: Curves.fastOutSlowIn,
                      child: Text('fastOutSlowIn')),
                  PopupMenuItem<Curve>(
                      value: Curves.fastLinearToSlowEaseIn,
                      child: Text('fastLinearToSlowEaseIn')),
                  PopupMenuItem<Curve>(
                      value: Curves.fastOutSlowIn,
                      child: Text('fastOutSlowIn')),
                  PopupMenuItem<Curve>(
                      value: Curves.elasticIn, child: Text('elasticIn')),
                  PopupMenuItem<Curve>(
                      value: Curves.elasticInOut, child: Text('elasticInOut')),
                  PopupMenuItem<Curve>(
                      value: Curves.elasticOut, child: Text('elasticOut'))
                ],
            onSelected: (Curve value) {
              setState(() {
                _curve = value;
              });
              _curvedAnimation =
                  CurvedAnimation(parent: _controller, curve: value);
              _controller
                ..reset()
                ..forward();
            })
      ]),
      body: Column(children: <Widget>[
        Expanded(
            child: Center(
                child: FadeTransition(
                    alwaysIncludeSemantics: true,
                    opacity: _opacityTween.animate(_curvedAnimation),
                    child: Container(
                        width: 100, height: 100, color: Colors.red)))),
        Expanded(
            child: Center(
                child: RotationTransition(
                    // 设置动画的旋转中心
                    alignment: Alignment.center,
                    turns: _rotationTween.animate(_curvedAnimation),
                    child: Container(
                        width: 100, height: 100, color: Colors.green)))),
        Expanded(
            child: Center(
                child: ScaleTransition(
                    scale: _scaleTween.animate(_curvedAnimation),
                    child: Container(
                        width: 100, height: 100, color: Colors.blue)))),
        Expanded(
            child: Center(
                child: SlideTransition(
                    position: _slideTween.animate(_curvedAnimation),
                    child: Container(
                        width: 100, height: 100, color: Colors.orange)))),
      ]),
    );
  }
}
