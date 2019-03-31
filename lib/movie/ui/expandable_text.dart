import 'package:flutter/material.dart';

class ExpandableText extends StatelessWidget {
  final String text;
  final bool isShow;
  final VoidCallback onPressed;
  final MainAxisAlignment alignment;
  final Color textColor;
  final Color iconColor;
  final Color iconTextColor;
  final double fontSize;
  final int lines;

  ExpandableText(
    this.text, {
    Key key,
    this.isShow = false,
    this.onPressed,
    this.alignment = MainAxisAlignment.center,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
    this.iconTextColor = Colors.white,
    this.fontSize = 14.0,
    this.lines = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(fontSize: fontSize, color: textColor),
          maxLines: isShow ? null : lines,
          overflow: TextOverflow.clip,
        ),
        GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: alignment,
              children: <Widget>[
                Text(
                  isShow ? '收起' : '显示全部',
                  style: TextStyle(
                    fontSize: fontSize,
                    color: iconTextColor,
                  ),
                ),
                Icon(
                  isShow ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: iconColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
