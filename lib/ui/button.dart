import 'package:flutter/material.dart';
import 'package:flutter_app/enum/enum.dart';

class Button extends StatelessWidget {
  Button({
    Key key,
    @required this.child,
    @required this.onPressed,
    this.borderRadius: 5.0,
    this.color,
    this.height: 42.0,
    this.textColor,
    this.disabledColor,
    this.highlightColor,
    this.disabledTextColor,
    this.width: double.infinity,
    this.disabledBorderColor,
    this.highlightedBorderColor,
    this.borderWidth: 1.0,
    this.borderColor: Colors.black,
    this.buttonShape: ButtonShape.NORMAL,
    this.icon,
    this.halfRadius: false,
  }) : super(key: key);

  final Widget child;

  /// 圆角半径
  final double borderRadius;

  final Function onPressed;

  /// 按钮文字颜色
  final Color textColor;
  final Color disabledTextColor;

  /// 按钮背景色
  final Color color;
  final Color disabledColor;
  final Color highlightColor;

  final double width;
  final double height;

  final Color disabledBorderColor;
  final Color highlightedBorderColor;
  final double borderWidth;
  final Color borderColor;

  // shape
  final ButtonShape buttonShape;

  final IconData icon;
  final bool halfRadius;

  @override
  Widget build(BuildContext context) {
    ShapeBorder shape;

    if (halfRadius) {
      shape = StadiumBorder(
          side: buttonShape == ButtonShape.OUTLINE
              ? BorderSide(color: borderColor, width: borderWidth)
              : BorderSide.none);
    } else {
      if (buttonShape == ButtonShape.OUTLINE) {
        shape = RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor, width: borderWidth));
      } else if (buttonShape == ButtonShape.SQUARE_CORNER) {
        shape = BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius));
      } else if (buttonShape == ButtonShape.CIRCLE) {
        shape = CircleBorder(
          side: BorderSide(
            color: borderColor,
            width: borderWidth,
            style: BorderStyle.solid,
          ),
        );
      } else {
        shape = RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius));
      }
    }

    return Container(
      width: width,
      height: height,
      child: icon == null
          ? FlatButton(
              onPressed: onPressed,
              textColor: textColor ?? Colors.white,
              disabledTextColor: disabledTextColor ?? Color(0xFFD4E2FA),
              color: color ??
                  (buttonShape == ButtonShape.OUTLINE
                      ? Colors.transparent
                      : Theme.of(context).accentColor),
              disabledColor: disabledColor ?? Color(0xFF96BBFA),
              highlightColor: highlightColor,
              shape: shape,
              child: child,
              materialTapTargetSize: MaterialTapTargetSize.padded,
            )
          : FlatButton.icon(
              onPressed: onPressed,
              icon: Icon(icon, size: 22),
              label: child,
              textColor: textColor ?? Colors.white,
              disabledTextColor: disabledTextColor ?? Color(0xFFD4E2FA),
              color: color ??
                  (buttonShape == ButtonShape.OUTLINE
                      ? Colors.transparent
                      : Theme.of(context).accentColor),
              disabledColor: disabledColor ?? Color(0xFF96BBFA),
              highlightColor: highlightColor,
              shape: shape,
            ),
    );
  }
}
