import 'package:flutter/material.dart';
import 'package:flutter_app/res/colors.dart';

class CountView extends StatelessWidget {
  final Color textColor;
  final int count;
  final int addCount;
  final String title;

  CountView({Key key, this.textColor, this.count, this.addCount, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        RichText(
            text: TextSpan(
                text: '较昨日:',
                style: TextStyle(color: Colors.black54, fontSize: 12.0),
                children: <TextSpan>[
              TextSpan(
                  text: addCount == null
                      ? "待公布"
                      : '${addCount > 0 ? "+$addCount" : addCount}',
                  style: TextStyle(color: textColor, fontSize: 10.0))
            ])),
        Text('$count',
            style: TextStyle(
                color: textColor, fontSize: 28.0, fontWeight: FontWeight.bold)),
        Text('$title', style: TextStyle(color: grey6Color, fontSize: 14.0))
      ]),
    );
  }
}
