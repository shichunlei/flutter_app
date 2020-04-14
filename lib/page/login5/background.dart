import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

class Background extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset(0.0, 0.0) & Size(size.width, size.height);
    var paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 2.0
      ..shader = LinearGradient(
        colors: [Colors.yellow[800], Colors.red],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        tileMode: TileMode.clamp,
      ).createShader(rect)
      ..style = PaintingStyle.fill;

    /// 整体背景。从右上角到左下角颜色渐变为[Colors.yellow[800], Colors.red],
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    paint
      ..shader = LinearGradient(
              colors: [
            Colors.yellow.withOpacity(1.0),
            Colors.red.withOpacity(1.0)
          ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              tileMode: TileMode.clamp)
          .createShader(rect);

    var path1 = Path()
      ..moveTo(size.width * 1, size.height)
      ..lineTo(size.width * 0, size.height);

    var endPoint1 = Offset(5 * size.width / 4, 4 * size.height / 4);
    var ctlPoint1 = Offset(4.5 * size.width / 4, 2.5 * size.height / 4);
    path1.quadraticBezierTo(
        ctlPoint1.dx, ctlPoint1.dy, endPoint1.dx, endPoint1.dy);

    canvas.drawPath(path1, paint);

    paint
      ..shader = LinearGradient(
              colors: [
            Colors.red.withOpacity(0.2),
            Colors.yellow[800].withOpacity(0.3)
          ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              tileMode: TileMode.clamp)
          .createShader(rect);

    var path = Path()
      ..moveTo(size.width * 0, size.height)
      ..lineTo(size.width, size.height);
    var endPoint = Offset(0 * size.width / 4, 4 * size.height / 4);
    var ctlPoint = Offset(0.2 * size.width / 4, 3 * size.height / 4);
    path.quadraticBezierTo(ctlPoint.dx, ctlPoint.dy, endPoint.dx, endPoint.dy);

    canvas.drawPath(path, paint);

    var path2 = Path()
      ..moveTo(size.width, 0.0)
      ..lineTo(size.width, size.height)
      ..lineTo(0.0, size.height)
      ..lineTo(0.0, size.height + 5);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path2.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    canvas.drawPath(path2, paint);

    paint
      ..shader = LinearGradient(
              colors: [
            Colors.white,
            Colors.white,
          ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              tileMode: TileMode.clamp)
          .createShader(rect);
    canvas.drawCircle(Offset(size.width / 2, 160), 50, paint);
    canvas.drawCircle(Offset(size.width / 2.5, 240), 20, paint);
    canvas.drawCircle(Offset(size.width / 1.5, 200), 10, paint);
    canvas.drawCircle(Offset(size.width / 1.7, 210), 3, paint);
    canvas.drawOval(Rect.fromLTWH(70, 450, 45, 25), paint);

    // 文字左上角起始点
    Offset offset = Offset(size.width / 2 - 50, 125.0);

    drawText(canvas, 'GO', offset,
        color: Colors.red,
        fontSize: 65.0,
        fontWeight: FontWeight.bold,
        width: 100);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
