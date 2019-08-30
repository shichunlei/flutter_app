import 'package:flutter/material.dart';

class TagView extends StatelessWidget {
  final String tag;
  final Color textColor;
  final Color borderColor;

  TagView({Key key, this.tag, this.textColor, this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        alignment: Alignment.center,
        child: Text(tag,
            style: TextStyle(
                color: textColor ?? Color(0xFF9A9AA7), fontSize: 11.5)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
            border: Border.all(
                width: 0.5, color: borderColor ?? Color(0xFF9A9AA7))));
  }
}
