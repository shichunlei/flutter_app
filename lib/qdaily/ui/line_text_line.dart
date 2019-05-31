import 'package:flutter/material.dart';

class LineTextLine extends StatelessWidget {
  final String text;
  final double horizontalPadding;
  final double verticalPadding;

  LineTextLine(
      {Key key,
      this.text,
      this.horizontalPadding = 0,
      this.verticalPadding = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(children: <Widget>[
          Expanded(child: Divider()),
          Text('$text', style: TextStyle(color: Colors.grey)),
          Expanded(child: Divider())
        ]),
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding));
  }
}
