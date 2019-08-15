import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button(
      {Key key,
      this.text,
      @required this.onPressed,
      this.borderRadius: 5.0,
      this.color,
      this.height: 48.0,
      this.textColor,
      this.disabledColor,
      this.textSize: 18,
      this.disabledTextColor,
      this.width,
      this.hasBorder: false,
      this.disabledBorderColor,
      this.highlightedBorderColor,
      this.borderWidth: 1.0,
      this.borderColor})
      : super(key: key);

  final String text;
  final double borderRadius;
  final double textSize;

  final VoidCallback onPressed;

  final Color textColor;
  final Color disabledTextColor;
  final Color color;
  final Color disabledColor;

  final double width;
  final double height;

  final bool hasBorder;
  final Color disabledBorderColor;
  final Color highlightedBorderColor;
  final double borderWidth;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return hasBorder
        ? OutlineButton(
            onPressed: onPressed,
            textColor: textColor ?? Colors.white,
            disabledTextColor: disabledTextColor ?? Color(0xFFD4E2FA),
            disabledBorderColor: disabledBorderColor ?? color ?? Colors.grey,
            highlightedBorderColor:
                highlightedBorderColor ?? Theme.of(context).accentColor,
            borderSide: BorderSide(
                width: borderWidth, color: borderColor ?? Colors.white),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
            child: Container(
                height: height,
                width: width ?? double.infinity,
                alignment: Alignment.center,
                child: Text('$text', style: TextStyle(fontSize: textSize))),
          )
        : FlatButton(
            onPressed: onPressed,
            textColor: textColor ?? Colors.white,
            disabledTextColor: disabledTextColor ?? Color(0xFFD4E2FA),
            color: color ?? Theme.of(context).accentColor,
            disabledColor: disabledColor ?? Color(0xFF96BBFA),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
            child: Container(
                height: height,
                width: width ?? double.infinity,
                alignment: Alignment.center,
                child: Text('$text', style: TextStyle(fontSize: textSize))),
          );
  }
}
