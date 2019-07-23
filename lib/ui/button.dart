import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button(
      {Key key,
      this.text,
      @required this.onPressed,
      this.borderRadius: 20.0,
      this.color,
      this.height: 48,
      this.textColor,
      this.disabledColor,
      this.textSize: 18,
      this.disabledTextColor,
      this.width})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final double borderRadius;
  final double textSize;
  final Color color;
  final double height;
  final Color textColor;
  final Color disabledColor;
  final Color disabledTextColor;
  final double width;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: onPressed,
        textColor: textColor ?? Colors.white,
        color: color ?? Color(0xff4688FA),
        disabledTextColor: disabledTextColor ?? Color(0xFFD4E2FA),
        disabledColor: disabledColor ?? Color(0xFF96BBFA),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Column(children: <Widget>[
          Container(
              height: height,
              width: width ?? double.infinity,
              alignment: Alignment.center,
              child: Text('$text', style: TextStyle(fontSize: textSize)))
        ]));
  }
}
