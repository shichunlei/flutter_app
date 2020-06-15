import 'dart:ui';

import 'package:custom_widgets/utils.dart';
import 'package:flutter/material.dart';

import 'package:quiver/iterables.dart';

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
                    PopupMenuItem<Curve>(
                        value: Curves.ease, child: Text('ease')),
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
                        value: Curves.elasticInOut,
                        child: Text('elasticInOut')),
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
                  child: Container(
                      color: Colors.grey.shade200,
                      padding: const EdgeInsets.all(12),
                      constraints: BoxConstraints.expand(height: 200),
                      child: CustomPaint(
                          key: Key('curveGraph'),
                          painter:
                              CurvePainter(_controller, _curvedAnimation))))),
          Row(children: <Widget>[
            Expanded(
                child: Center(
                    child: Container(
                        width: 50,
                        height: 50,
                        child: FadeTransition(
                            alwaysIncludeSemantics: true,
                            opacity: _opacityTween.animate(_curvedAnimation),
                            child: Container(
                                width: 50, height: 50, color: Colors.red))))),
            Expanded(
                child: Center(
                    child: Container(
                        width: 50,
                        height: 50,
                        child: RotationTransition(
                            // 设置动画的旋转中心
                            alignment: Alignment.center,
                            turns: _rotationTween.animate(_curvedAnimation),
                            child: Container(
                                width: 50, height: 50, color: Colors.green)))))
          ]),
          SizedBox(height: 20),
          Row(children: <Widget>[
            Expanded(
                child: Center(
                    child: Container(
                        width: 50,
                        height: 50,
                        child: ScaleTransition(
                            scale: _scaleTween.animate(_curvedAnimation),
                            child: Container(
                                width: 50, height: 50, color: Colors.blue))))),
            Expanded(
                child: Center(
                    child: Container(
                        width: 50,
                        height: 50,
                        child: SlideTransition(
                            position: _slideTween.animate(_curvedAnimation),
                            child: Container(
                                width: 50, height: 50, color: Colors.orange)))))
          ]),
          SizedBox(height: 20)
        ]));
  }
}

const divisions = 500;

class CurvePainter extends CustomPainter {
  Paint axisPaint;

  CurvePainter(this.controller, this.anim) {
    axisPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 2;
  }

  final CurvedAnimation anim;

  final AnimationController controller;

  @override
  void paint(Canvas canvas, Size size) {
    final points = List.generate(
        divisions, (index) => 1 - anim.curve.transform(index / divisions));

    _drawAxis(canvas, size);
    _drawCurve(canvas, points, size);
    _drawCurrentValueMarker(canvas, size, points);
  }

  void _drawCurrentValueMarker(Canvas canvas, Size size, List<double> points) {
    canvas.drawCircle(
      Offset(controller.value * size.width,
          points[(controller.value * (divisions - 1)).floor()] * size.height),
      5.0,
      Paint()..color = Colors.pink,
    );
  }

  void _drawCurve(Canvas canvas, List<double> points, Size size) {
    canvas.drawPoints(
        PointMode.polygon,
        enumerate(points)
            .map((y) =>
                Offset(y.index / divisions * size.width, y.value * size.height))
            .toList(),
        Paint()
          ..color = Colors.cyan
          ..strokeWidth = 2);
  }

  void _drawAxis(Canvas canvas, Size size) {
    drawText(canvas, 'time', Offset(size.width, size.height) - Offset(30, 18),
        width: size.width);
    drawText(canvas, 'value', Offset(10, 0), width: size.width);

    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), axisPaint);
    canvas.drawLine(Offset(0, 0), Offset(0, size.height), axisPaint);
  }

  @override
  bool shouldRepaint(CurvePainter oldDelegate) => true;
}
