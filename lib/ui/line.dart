import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../page_index.dart';

class Line extends StatelessWidget {
  final Color color;
  final EdgeInsetsGeometry margin;
  final double lineHeight;

  Line(
      {Key key,
      this.color: Colors.white,
      this.margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      this.lineHeight: 0.2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: lineHeight, color: color, margin: margin);
  }
}

class DashLine extends StatelessWidget {
  final double lineHeight;
  final Color color;
  final EdgeInsetsGeometry padding;

  DashLine({
    Key key,
    this.color: Colors.black,
    this.lineHeight: 0.2,
    this.padding: EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: CustomPaint(
        painter: DashPathPainter(lineHeight, color),
        size: Size.fromHeight(lineHeight),
      ),
    );
  }
}

class DashPathPainter extends CustomPainter {
  final double lineHeight;
  final Color color;

  DashPathPainter(this.lineHeight, this.color)
      : black = Paint()
          ..color = color
          ..strokeWidth = lineHeight
          ..style = PaintingStyle.stroke,
        path = Path();

  final Paint black;

  final Path path;

  @override
  bool shouldRepaint(DashPathPainter oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    path
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width, size.height / 2);

    canvas.drawPath(
        dashPath(
          path,
          dashArray: CircularIntervalList<double>(
            <double>[5.0, 2.5],
          ),
        ),
        black);
  }
}
