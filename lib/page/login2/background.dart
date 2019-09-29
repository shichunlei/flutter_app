import 'package:flutter/material.dart';

class Background extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset(0.0, 0.0) & Size(size.width, size.height);
    var paint = Paint();
    var width = size.width;
    var height = size.height;

    paint
      ..color = Colors.deepOrangeAccent
      ..strokeWidth = 2.0
      ..shader = LinearGradient(
        colors: [Colors.deepOrangeAccent, Colors.purple],
        begin: Alignment.bottomRight,
        end: Alignment.centerLeft,
        tileMode: TileMode.clamp,
      ).createShader(rect)
      ..style = PaintingStyle.fill;

    var pathBottom = Path();
    pathBottom.moveTo(0.0, height);
    pathBottom.lineTo(0, height);
    pathBottom.lineTo(width, height);

    var p1 = Offset(width / 4, height);
    var p2 = Offset(0 * width / 4, 3.5 * height / 4);
    pathBottom.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);

    var p3 = Offset(2 * width / 4, 3.5 * height / 4);
    var p4 = Offset(0 * width / 4, 3.5 * height / 4);
    pathBottom.quadraticBezierTo(p3.dx, p3.dy, p4.dx, p4.dy);

    var pathTop = Path();
    pathTop.moveTo(0.0, 0.0);
    pathTop.lineTo(width, 0.0);
    pathTop.lineTo(0.0, 0.0);

    var p21 = Offset(0.5 * width / 4, 1 * height / 4);
    var p22 = Offset(5 * width / 4, 0 * height / 4);
    pathTop.quadraticBezierTo(p21.dx, p21.dy, p22.dx, p22.dy);

    canvas.drawPath(pathTop, paint);
    canvas.drawPath(pathBottom, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
