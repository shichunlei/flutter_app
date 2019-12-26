import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../page_index.dart';

class Line extends StatelessWidget {
  final Color color;
  final EdgeInsetsGeometry margin;
  final double lineHeight;

  Line(
      {Key key,
      this.color,
      this.margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      this.lineHeight: 0.2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: lineHeight,
        color: color ?? Theme.of(context).dividerColor,
        margin: margin);
  }
}

class DashLine extends StatelessWidget {
  final double lineHeight;
  final Color color;
  final EdgeInsetsGeometry padding;

  DashLine({
    Key key,
    this.color,
    this.lineHeight: 0.2,
    this.padding: EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: CustomPaint(
        painter: DashPathPainter(
            lineHeight, color ?? Theme.of(context).dividerColor),
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

class LineWidget extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final LineType lineType;

  LineWidget({
    Key key,
    this.width,
    this.height,
    this.color,
    this.lineType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return lineType == LineType.vertical
        ? _buildVerticalLine(context, color)
        : lineType == LineType.horizontal
            ? _buildHorizontalLine(context, color)
            : null;
  }

  Widget _buildVerticalLine(context, color) {
    return Container(
      height: height ?? 1.0,
      width: width,
      color: color ?? Theme.of(context).dividerColor,
    );
  }

  Widget _buildHorizontalLine(context, color) {
    return Container(
      height: height,
      width: width ?? 1.0,
      color: color ?? Theme.of(context).dividerColor,
    );
  }
}
