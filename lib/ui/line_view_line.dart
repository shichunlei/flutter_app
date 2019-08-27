import 'package:flutter/material.dart';

class LineViewLine extends StatelessWidget {
  final double horizontalPadding;
  final double verticalPadding;
  final Widget child;
  final int leftFlex;
  final int rightFlex;
  final Color lineColor;

  LineViewLine(
      {Key key,
      this.child: const SizedBox(),
      this.horizontalPadding = 0,
      this.verticalPadding = 0,
      this.leftFlex = 1,
      this.rightFlex = 1,
      this.lineColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(children: <Widget>[
          Expanded(flex: leftFlex, child: Divider(color: lineColor)),
          child,
          Expanded(flex: rightFlex, child: Divider(color: lineColor))
        ]),
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding));
  }
}
