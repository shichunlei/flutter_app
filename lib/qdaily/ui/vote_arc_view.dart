import 'dart:math';

import 'package:flutter/material.dart';

class ArcPainter extends CustomPainter {
  final bool isCheck;
  final double rate;

  ArcPainter({this.isCheck: false, this.rate: 29.0});

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset(0.0, 0.0) & Size(size.width, size.height);
    var paint = Paint();

    paint..color = isCheck ? Colors.orange[300] : Colors.grey[300];
    canvas.drawCircle(
        Offset(size.width / 2, size.width / 2), size.width / 2, paint);

    paint..color = isCheck ? Colors.orange[500] : Colors.grey[500];
    canvas.drawArc(
        rect, 0 * (pi / 180.0), rate / 100 * 360 * (pi / 180.0), true, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
