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
      this.highlightColor,
      this.textSize: 18,
      this.disabledTextColor,
      this.width: double.infinity,
      this.hasBorder: false,
      this.disabledBorderColor,
      this.highlightedBorderColor,
      this.borderWidth: 1.0,
      this.borderColor})
      : super(key: key);

  /// 按钮文字
  final String text;

  /// 圆角半径
  final double borderRadius;

  /// 按钮文字大小
  final double textSize;

  final VoidCallback onPressed;

  /// 按钮文字颜色
  final Color textColor;
  final Color disabledTextColor;

  /// 按钮背景色
  final Color color;
  final Color disabledColor;
  final Color highlightColor;

  final double width;
  final double height;

  final bool hasBorder;
  final Color disabledBorderColor;
  final Color highlightedBorderColor;
  final double borderWidth;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    Widget _child = Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        child: Text('$text', style: TextStyle(fontSize: textSize)));

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
            highlightColor: highlightColor,
            shape: borderRadius >= height / 2
                ? StadiumBorder()
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius)),
            child: _child,
          )
        : FlatButton(
            onPressed: onPressed,
            textColor: textColor ?? Colors.white,
            disabledTextColor: disabledTextColor ?? Color(0xFFD4E2FA),
            color: color ?? Theme.of(context).accentColor,
            disabledColor: disabledColor ?? Color(0xFF96BBFA),
            highlightColor: highlightColor,
            shape: borderRadius >= height / 2
                ? StadiumBorder()
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius)),
            child: _child,
          );
  }
}
