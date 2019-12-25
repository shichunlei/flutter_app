import 'dart:ui';

import 'package:flutter/material.dart';

import '../../page_index.dart';

class WeatherTempView extends StatelessWidget {
  final double max;
  final double min;
  final double maxRange;
  final double minRange;
  final double width;
  final double height;

  WeatherTempView(
      {Key key,
      @required this.minRange,
      this.maxRange,
      this.max,
      this.min,
      this.height,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: Size(width ?? double.infinity, height ?? double.infinity),
        painter: TempRangePainter(
            max: max, min: min, maxRange: maxRange, minRange: minRange));
  }
}

class TempRangePainter extends CustomPainter {
  final double max;
  final double min;
  final double maxRange;
  final double minRange;

  Paint backgroundPaint;
  Paint valuePaint;

  Paint maxPointPaint;
  Paint minPointPaint;

  TempRangePainter({
    this.max,
    this.min,
    this.maxRange,
    this.minRange,
  })  : assert(max > min),
        backgroundPaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 1.5,
        valuePaint = Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 3,
        maxPointPaint = Paint()
          ..color = Colors.green
          ..strokeWidth = 4
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke,
        minPointPaint = Paint()
          ..color = Colors.orange
          ..strokeWidth = 4
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    /// 每℃在Y轴上所占的高度
    double yGap = size.height / (max - min);

    Path backgroundPath = Path();

    Path valuePath = Path();

    double itemWidth = size.width;

    /// X轴坐标
    double x = itemWidth / 2;

    backgroundPath.moveTo(x, 0);
    backgroundPath.lineTo(x, size.height);

    double yMax = (max - maxRange) * yGap;
    double yMin = (max - minRange) * yGap;

    /// 最大值坐标
    valuePath.moveTo(x, yMax);

    /// 最小值坐标
    valuePath.lineTo(x, yMin);

    /// 画背景虚线
    canvas.drawPath(
      dashPath(
        backgroundPath,
        dashArray: CircularIntervalList(<double>[6]),
      ),
      backgroundPaint,
    );

    /// 画温度区域实线
    canvas.drawPath(valuePath, valuePaint);

    /// 画最小点
//    canvas.drawPoints(PointMode.points, [Offset(x, yMin)], minPointPaint);

    /// 画最大点
//    canvas.drawPoints(PointMode.points, [Offset(x, yMax)], maxPointPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
