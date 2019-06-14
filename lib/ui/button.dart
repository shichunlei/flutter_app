import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button(
      {Key key, this.text, @required this.onPressed, this.borderRadius: 20.0})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: onPressed,
        textColor: Colors.white,
        color: Color(0xff4688FA),
        disabledTextColor: Color(0xFFD4E2FA),
        disabledColor: Color(0xFF96BBFA),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Column(children: <Widget>[
          Container(
              height: 48,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text('$text', style: TextStyle(fontSize: 18)))
        ]));
  }
}
