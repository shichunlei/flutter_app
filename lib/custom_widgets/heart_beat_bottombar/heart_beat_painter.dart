import 'package:flutter/material.dart';

import 'dart:math';

class HeartBeatPainter extends CustomPainter {
  double beginning;
  double ending;
  Animation<double> animation;

  double lerp(double v0, double v1, double t) {
    return (1 - t) * v0 + t * v1;
  }

  double sigmoid(double x) {
    return 0.5 * (sin(x * pi - pi / 2) + 1);
  }

  double parabola(double x) {
    return pow(((cos(x) + 1) / 2), 10);
  }

  bool inversed;
  List<Offset> _points;

  Paint heartBeatPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..strokeWidth = 4.0;

  HeartBeatPainter({
    @required this.animation,
    @required this.beginning,
    @required this.ending,
  }) : super(repaint: animation) {
    inversed = ending < beginning;
    if (!inversed) {
      double startingPoint = ((ending + beginning).abs() / 2) - 15;
      var a = (startingPoint - beginning) * 0.1;
      var b = (ending - startingPoint - 30) * 0.1;
      _points = [
        Offset(beginning, 0),
        Offset(beginning + a * 0.1, 0),
        Offset(beginning + a * 0.2, 0),
        Offset(beginning + a * 0.3, 0),
        Offset(beginning + a * 0.4, 0),
        Offset(beginning + a * 0.5, 0),
        Offset(beginning + a * 0.6, 0),
        Offset(beginning + a * 0.7, 0),
        Offset(beginning + a * 0.8, 0),
        Offset(beginning + a * 0.9, 0),
        Offset(beginning + a * 1, 0),
        Offset(beginning + a * 1.5, 0),
        Offset(beginning + a * 2, 0),
        Offset(beginning + a * 2.5, 0),
        Offset(beginning + a * 3, 0),
        Offset(beginning + a * 3.5, 0),
        Offset(beginning + a * 4, 0),
        Offset(beginning + a * 4.5, 0),
        Offset(beginning + a * 5, 0),
        Offset(beginning + a * 5.5, 0),
        Offset(beginning + a * 6, 0),
        Offset(beginning + a * 6.5, 0),
        Offset(beginning + a * 7, 0),
        Offset(beginning + a * 7.5, 0),
        Offset(beginning + a * 8, 0),
        Offset(beginning + a * 8.5, 0),
        Offset(beginning + a * 9, 0),
        Offset(beginning + a * 9.5, 0),
        Offset(startingPoint, 0),
        Offset(startingPoint + 1.5, -1.5),
        Offset(startingPoint + 3, -3),
        Offset(startingPoint + 4.5, 1),
        Offset(startingPoint + 6, 5),
        Offset(startingPoint + 7.5, -7.5),
        Offset(startingPoint + 9, -10),
        Offset(startingPoint + 11, -1),
        Offset(startingPoint + 13, 8),
        Offset(startingPoint + 15, 2),
        Offset(startingPoint + 17, -4),
        Offset(startingPoint + 19, 0),
        Offset(startingPoint + 21, 4),
        Offset(startingPoint + 23, 0.5),
        Offset(startingPoint + 25, -3),
        Offset(startingPoint + 27.5, -1.5),
        Offset(startingPoint + 30, 0),
        Offset(startingPoint + 30 + b * 0.5, 0),
        Offset(startingPoint + 30 + b * 1, 0),
        Offset(startingPoint + 30 + b * 1.5, 0),
        Offset(startingPoint + 30 + b * 2, 0),
        Offset(startingPoint + 30 + b * 2.5, 0),
        Offset(startingPoint + 30 + b * 3, 0),
        Offset(startingPoint + 30 + b * 3.5, 0),
        Offset(startingPoint + 30 + b * 4, 0),
        Offset(startingPoint + 30 + b * 4.5, 0),
        Offset(startingPoint + 30 + b * 5, 0),
        Offset(startingPoint + 30 + b * 5.5, 0),
        Offset(startingPoint + 30 + b * 6, 0),
        Offset(startingPoint + 30 + b * 6.5, 0),
        Offset(startingPoint + 30 + b * 7, 0),
        Offset(startingPoint + 30 + b * 7.5, 0),
        Offset(startingPoint + 30 + b * 8, 0),
        Offset(startingPoint + 30 + b * 8.5, 0),
        Offset(startingPoint + 30 + b * 9, 0),
        Offset(startingPoint + 30 + b * 9.1, 0),
        Offset(startingPoint + 30 + b * 9.2, 0),
        Offset(startingPoint + 30 + b * 9.3, 0),
        Offset(startingPoint + 30 + b * 9.4, 0),
        Offset(startingPoint + 30 + b * 9.5, 0),
        Offset(startingPoint + 30 + b * 9.6, 0),
        Offset(startingPoint + 30 + b * 9.7, 0),
        Offset(startingPoint + 30 + b * 9.8, 0),
        Offset(startingPoint + 30 + b * 9.9, 0),
        Offset(ending, 0),
      ];
      heartBeatPaint.shader = LinearGradient(
        colors: <Color>[Colors.pink[300], Colors.white],
        stops: [0.0, 0.3],
      ).createShader(
        Rect.fromPoints(_points[0], _points[_points.length - 1]),
      );
    } else if (inversed) {
      double startingPoint = ((ending + beginning).abs() / 2) + 15;
      var a = (startingPoint - beginning) * 0.1;
      var b = (ending - startingPoint + 30) * 0.1;
      _points = [
        Offset(beginning, 0),
        Offset(beginning + a * 0.1, 0),
        Offset(beginning + a * 0.2, 0),
        Offset(beginning + a * 0.3, 0),
        Offset(beginning + a * 0.4, 0),
        Offset(beginning + a * 0.5, 0),
        Offset(beginning + a * 0.6, 0),
        Offset(beginning + a * 0.7, 0),
        Offset(beginning + a * 0.8, 0),
        Offset(beginning + a * 0.9, 0),
        Offset(beginning + a * 1, 0),
        Offset(beginning + a * 1.5, 0),
        Offset(beginning + a * 2, 0),
        Offset(beginning + a * 2.5, 0),
        Offset(beginning + a * 3, 0),
        Offset(beginning + a * 3.5, 0),
        Offset(beginning + a * 4, 0),
        Offset(beginning + a * 4.5, 0),
        Offset(beginning + a * 5, 0),
        Offset(beginning + a * 5.5, 0),
        Offset(beginning + a * 6, 0),
        Offset(beginning + a * 6.5, 0),
        Offset(beginning + a * 7, 0),
        Offset(beginning + a * 7.5, 0),
        Offset(beginning + a * 8, 0),
        Offset(beginning + a * 8.5, 0),
        Offset(beginning + a * 9, 0),
        Offset(beginning + a * 9.5, 0),
        Offset(startingPoint, 0),
        Offset(startingPoint - 1.5, -1.5),
        Offset(startingPoint - 3, -3),
        Offset(startingPoint - 4.5, 1),
        Offset(startingPoint - 6, 5),
        Offset(startingPoint - 7.5, -7.5),
        Offset(startingPoint - 9, -10),
        Offset(startingPoint - 11, -1),
        Offset(startingPoint - 13, 8),
        Offset(startingPoint - 15, 2),
        Offset(startingPoint - 17, -4),
        Offset(startingPoint - 19, 0),
        Offset(startingPoint - 21, 4),
        Offset(startingPoint - 23, 0.5),
        Offset(startingPoint - 25, -3),
        Offset(startingPoint - 27.5, -1.5),
        Offset(startingPoint - 30, 0),
        Offset(startingPoint - 30 + b * 0.5, 0),
        Offset(startingPoint - 30 + b * 1, 0),
        Offset(startingPoint - 30 + b * 1.5, 0),
        Offset(startingPoint - 30 + b * 2, 0),
        Offset(startingPoint - 30 + b * 2.5, 0),
        Offset(startingPoint - 30 + b * 3, 0),
        Offset(startingPoint - 30 + b * 3.5, 0),
        Offset(startingPoint - 30 + b * 4, 0),
        Offset(startingPoint - 30 + b * 4.5, 0),
        Offset(startingPoint - 30 + b * 5, 0),
        Offset(startingPoint - 30 + b * 5.5, 0),
        Offset(startingPoint - 30 + b * 6, 0),
        Offset(startingPoint - 30 + b * 6.5, 0),
        Offset(startingPoint - 30 + b * 7, 0),
        Offset(startingPoint - 30 + b * 7.5, 0),
        Offset(startingPoint - 30 + b * 8, 0),
        Offset(startingPoint - 30 + b * 8.5, 0),
        Offset(startingPoint - 30 + b * 9, 0),
        Offset(startingPoint - 30 + b * 9.1, 0),
        Offset(startingPoint - 30 + b * 9.2, 0),
        Offset(startingPoint - 30 + b * 9.3, 0),
        Offset(startingPoint - 30 + b * 9.4, 0),
        Offset(startingPoint - 30 + b * 9.5, 0),
        Offset(startingPoint - 30 + b * 9.6, 0),
        Offset(startingPoint - 30 + b * 9.7, 0),
        Offset(startingPoint - 30 + b * 9.8, 0),
        Offset(startingPoint - 30 + b * 9.9, 0),
      ];
      heartBeatPaint.shader = LinearGradient(
        colors: <Color>[Colors.white, Colors.pink[300]],
        stops: [0.7, 1.0],
      ).createShader(
        Rect.fromPoints(_points[0], _points[_points.length - 1]),
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    double percentage = _points.length * animation.value;

    int start =
        lerp(0, percentage, pow(sigmoid(pow(animation.value, 5)), 1)).floor();

    Path heartBeatPath = Path()..moveTo(_points[start].dx, 0);
    for (int i = start + 1; i < (percentage).round(); i++) {
      heartBeatPath.lineTo(_points[i].dx, _points[i].dy);
    }

    canvas.drawPath(heartBeatPath, heartBeatPaint);

    canvas.drawCircle(
      !inversed
          ? Offset(
              heartBeatPath.getBounds().centerRight.dx,
              heartBeatPath.getBounds().centerRight.dy,
            )
          : Offset(
              heartBeatPath.getBounds().centerLeft.dx,
              heartBeatPath.getBounds().centerRight.dy,
            ),
      4 * parabola(animation.value * 2 * pi),
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(HeartBeatPainter oldDelegate) {
    return false;
  }
}
