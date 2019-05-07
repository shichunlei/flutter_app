import 'package:flutter/material.dart';

class SuspensionTag extends StatelessWidget {
  final String susTag;
  final int susHeight;

  SuspensionTag({Key key, this.susTag, this.susHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        height: susHeight.toDouble(),
        width: double.infinity,
        alignment: Alignment.centerLeft,
        color: Color(0xfff3f4f5),
        child: Row(children: <Widget>[
          Text('$susTag', textScaleFactor: 1.2),
          Expanded(child: Divider(height: .0, indent: 10.0))
        ]));
  }
}
