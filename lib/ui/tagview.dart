import 'package:flutter/material.dart';

class TagView extends StatelessWidget {
  final String tag;
  final Color textColor;
  final Color borderColor;
  final EdgeInsetsGeometry padding;
  final Color bgColor;
  final VoidCallback onPressed;
  final double borderRadius;

  TagView(
      {Key key,
      @required this.tag,
      this.textColor,
      this.borderColor,
      this.padding,
      this.bgColor,
      this.onPressed,
      this.borderRadius: 3.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onPressed,
        child: Container(
            padding: padding ?? EdgeInsets.symmetric(horizontal: 5),
            alignment: Alignment.center,
            child: Text(tag,
                style: TextStyle(
                    color: textColor ?? Color(0xFF9A9AA7), fontSize: 11.5)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                border: Border.all(
                    width: 0.5, color: borderColor ?? Color(0xFF9A9AA7)),
                color: bgColor ?? Colors.transparent)),
      ),
    );
  }
}
