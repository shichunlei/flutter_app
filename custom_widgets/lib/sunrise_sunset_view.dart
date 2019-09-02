import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'utils.dart';

class SunriseSunsetView extends StatefulWidget {
  final double progress; // 进度 0～1
  final int duration; // 动画时长
  SunriseSunsetView({@required this.progress, this.duration = 1000, Key key})
      : assert(progress >= 0 && progress <= 1),
        super(key: key);

  @override
  createState() => _SunriseSunsetViewState();
}

class _SunriseSunsetViewState extends State<SunriseSunsetView>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    if (widget.progress > 0) {
      _controller = AnimationController(
          duration: Duration(milliseconds: widget.duration),
          upperBound: widget.progress,
          vsync: this)
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _SunriseSunsetPainter(_controller?.value ?? 0));
  }
}

class _SunriseSunsetPainter extends CustomPainter {
  final double progress;

  _SunriseSunsetPainter(this.progress) : assert(progress >= 0 && progress <= 1);

  @override
  void paint(Canvas canvas, Size size) {
    // 画布大小（取画布宽、高中小的那个值）
    final canvasWidth =
        size.width / 2 > size.height ? size.height : size.width / 2;
    // 圆弧宽度
    final strokeWidth = 1.5;

    // 定义一个圆弧的画笔
    final arcPaint = Paint()
      ..color = Colors.white // 画笔颜色
      ..style = PaintingStyle.stroke // 绘制模式，画线 or 充满
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    // 绘制底部的横线
    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), arcPaint);

    // 圆心坐标
    final center = Offset(size.width / 2, size.height);
    // 太阳半径
    final dotRadius = 8.0;
    // 半径
    final radius = canvasWidth - dotRadius;

    // 进度条角度
    final progressAngle = 180 * progress;
    // 进度条弧度
    final double radians = degToRad(progressAngle);
    final double dx = size.width / 2 - radius * cos(radians);
    final double dy = size.height - radius * sin(radians);

    // 起始弧度
    final double startRadians = degToRad(-180);
    // 结束弧度
    final double endRadians = degToRad(180);

    final rect = Rect.fromCircle(center: center, radius: radius);

    // 绘制进度条圆弧
    canvas.drawArc(rect, startRadians, endRadians, false, arcPaint);

    /// 当太阳落山后不画太阳
    if (progress < 1 && progress > 0) {
      final Paint dotPaint = Paint()
        ..color = Colors.deepOrangeAccent
        ..strokeCap = StrokeCap.round
        ..strokeWidth = dotRadius * 2;

      // 绘制圆点（即太阳的位置）
      canvas.drawPoints(PointMode.points, [Offset(dx, dy)], dotPaint);

      final linePaint90 = Paint()
        ..color = Colors.deepOrangeAccent
        ..strokeWidth = 0.8;

      for (int i = 0; i < 4; i++) {
        canvas.drawLine(
            Offset(dx - (dotRadius + 3) * cos(degToRad(90 * i)),
                dy - (dotRadius + 3) * sin(degToRad(90 * i))),
            Offset(dx - (dotRadius + 10) * cos(degToRad(90 * i)),
                dy - (dotRadius + 10) * sin(degToRad(90 * i))),
            linePaint90);
      }

      final linePaint45 = Paint()
        ..color = Colors.deepOrangeAccent
        ..strokeWidth = 0.5;

      for (int i = 0; i < 4; i++) {
        canvas.drawLine(
            Offset(dx - (dotRadius + 3) * cos(degToRad(90 * i + 45)),
                dy - (dotRadius + 3) * sin(degToRad(90 * i + 45))),
            Offset(dx - (dotRadius + 8) * cos(degToRad(90 * i + 45)),
                dy - (dotRadius + 8) * sin(degToRad(90 * i + 45))),
            linePaint45);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
