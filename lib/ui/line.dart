import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  final Color color;
  final EdgeInsetsGeometry margin;
  final double lineHeight;

  Line({Key key, this.color, this.margin, this.lineHeight: 0.2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: lineHeight,
        color: color ?? Colors.white,
        margin: margin ?? EdgeInsets.only(top: 10.0, bottom: 10.0));
  }
}
