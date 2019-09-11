import 'dart:math';

import 'package:flutter/material.dart';

import 'utils.dart';

class CircleProgressWidget extends StatefulWidget {
  final double progress; // 进度 0～1
  final Color progressColor; // 进度条主色
  final Color ringColor; // 圆环颜色
  final double strokeWidth; // 进度条宽度
  final List<Color> colors;
  final int duration; // 动画时长
  final String lable;
  final Color lableColor; // 进度文字颜色
  final double lableFontSize;
  final String topLable; // 进度下面的文字
  final Color topLableColor; // 进度上面的文字颜色
  final String bottomLable; // 进度下面的文字
  final Color bottomLableColor; // 进度下面的文字颜色
  final Color backgroundColor; // 圆背景色
  final int totalDegree; // 圆弧总的度数
  final bool strokeCapRound; // 两端是否为圆角

  CircleProgressWidget(
      {Key key,
      @required this.progress,
      this.progressColor,
      this.ringColor,
      this.colors,
      this.duration: 1000,
      this.strokeWidth: 10.0,
      this.topLable,
      this.bottomLable,
      this.lable: '',
      this.lableFontSize = 30.0,
      this.lableColor,
      this.topLableColor,
      this.bottomLableColor,
      this.backgroundColor,
      this.totalDegree: 360,
      this.strokeCapRound: true})
      : assert(progress >= 0 && progress <= 1),
        super(key: key);

  @override
  createState() => _CircleProgressWidgetState();
}

class _CircleProgressWidgetState extends State<CircleProgressWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: widget.duration),
        upperBound: widget.progress,
        vsync: this)
      ..addListener(() {
        setState(() {});
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
    return Transform.rotate(
      angle: -degToRad(widget.totalDegree / 2 + 90),
      child: CustomPaint(
        painter: _CircleProgressPainter(
            _controller.value,
            widget.progressColor ?? Colors.redAccent,
            widget.ringColor ?? Colors.white54,
            widget.strokeWidth,
            widget.colors,
            widget.backgroundColor ?? Colors.transparent,
            widget.totalDegree,
            widget.strokeCapRound),
        child: Transform.rotate(
          angle: degToRad(widget.totalDegree / 2 + 90),
          child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Offstage(
                offstage: widget.topLable == null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('${widget.topLable ?? '2'}',
                        style: TextStyle(
                            color: widget.topLableColor ?? Colors.white,
                            fontSize: 14.0)),
                    SizedBox(height: 20)
                  ],
                ),
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        '${widget.lable ?? (_controller.value * 100).toStringAsFixed(0)}',
                        style: TextStyle(
                            color: widget.lableColor ?? Colors.white,
                            fontSize: widget.lableFontSize)),
                    Offstage(
                      offstage: widget.lable != null,
                      child: Column(children: <Widget>[
                        SizedBox(width: 5),
                        Text(
                          '%',
                          style: TextStyle(
                              color: widget.lableColor ?? Colors.white,
                              fontSize: 18.0),
                        )
                      ]),
                    ),
                  ]),
              Offstage(
                offstage: widget.bottomLable == null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text('${widget.bottomLable ?? '1'}',
                        style: TextStyle(
                            color: widget.bottomLableColor ?? Colors.white,
                            fontSize: 14.0))
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  final progress;
  final Color progressColor;
  final Color ringColor;
  final double strokeWidth;
  final List<Color> colors;
  final Color backgroundColor;
  final int totalDegree;
  final bool strokeCapRound;

  // 定义一个背景圆环的画笔
  final Paint ringPaint;

  // 定义一个进度路径的画笔
  final Paint progressPaint;

  _CircleProgressPainter(
      this.progress,
      this.progressColor,
      this.ringColor,
      this.strokeWidth,
      this.colors,
      this.backgroundColor,
      this.totalDegree,
      this.strokeCapRound)
      : assert(progress >= 0 && progress <= 1),
        ringPaint = Paint()
          ..color = ringColor // 画笔颜色
          ..style = PaintingStyle.stroke // 绘制模式，画线 or 充满
          ..strokeWidth = strokeWidth // 画笔宽度
          ..isAntiAlias = true //是否启动抗锯齿
          ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt,
        progressPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..isAntiAlias = true
          ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt;

  @override
  void paint(Canvas canvas, Size size) {
//    size = Size.fromRadius(radius);
    // 画布大小（取画布宽、高中小的那个值）
    final canvasWidth = size.width > size.height ? size.height : size.width;
    // 圆心坐标
    final center = Offset(size.width / 2, size.height / 2);
    // 外圆半径
    final centerRadius = canvasWidth / 2;
    // 进度条宽度
    final progressStrokeWidth = strokeWidth;
    // 圆环宽度
    final ringStrokeWidth = strokeWidth;
    // 圆环半径
    final radius = canvasWidth / 2 - ringStrokeWidth / 2;
    // 进度条弧度
    final double radians = degToRad(totalDegree * progress);

    ///////////////////////////////// 绘制实体外圆 ////////////////////////////////
    // 定义一个外圆画笔
    final backgroundPaint = Paint()..color = backgroundColor;

    final rect = Rect.fromCircle(center: center, radius: radius);

    // 绘制背景圆
    canvas.drawCircle(center, centerRadius, backgroundPaint);

    ///////////////////////////////// 绘制圆环 ////////////////////////////////////
    double startAngle =
        strokeCapRound ? asin(progressStrokeWidth * 0.5 / radius) : 0.0;
    double sweepAngle = radians - startAngle;

    // 绘制背景圆环
    canvas.drawArc(
        rect, startAngle, degToRad(totalDegree) - startAngle, false, ringPaint);
    /////////////////////////////// 绘制进度条 ////////////////////////////////////
    var _colors = colors;
    if (_colors == null) {
      _colors = [progressColor, progressColor];
    }

    // 扫描渐变 https://upload-images.jianshu.io/upload_images/4044518-25477bb0490755a3?imageMogr2/auto-orient/strip%7CimageView2/2/w/706/format/webp
    Gradient gradient = SweepGradient(endAngle: radians, colors: _colors);
    progressPaint.shader =
        gradient.createShader(rect); // 着色器，一般用来绘制渐变效果或ImageShader

    // 绘制进度条圆弧
    canvas.drawArc(rect, startAngle, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
