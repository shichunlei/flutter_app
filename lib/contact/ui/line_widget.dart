import 'package:flutter/material.dart';

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
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: color ?? Theme.of(context).dividerColor,
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalLine(context, color) {
    return Container(
      height: height,
      width: width ?? 1.0,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: color ?? Theme.of(context).dividerColor,
          ),
        ),
      ),
    );
  }
}

enum LineType { vertical, horizontal }
