import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../page_index.dart';

class TextFieldView extends StatelessWidget {
  final EdgeInsets margin;
  final IconData icon;
  final String hintText;
  final TextStyle style;
  final TextStyle hintStyle;
  final TextEditingController controller;
  final Color bgColor;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final BoxBorder border;

  TextFieldView({
    Key key,
    this.margin: const EdgeInsets.symmetric(horizontal: 28),
    this.icon,
    this.hintText,
    this.style,
    this.hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
    this.controller,
    this.bgColor,
    this.focusNode,
    this.keyboardType,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: margin,
      decoration: BoxDecoration(
        color: bgColor ?? Theme.of(context).scaffoldBackgroundColor,
        border: border ?? Border.all(color: Color(0xff0000ff), width: 0.5),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 22),
          Gaps.hGap12,
          Expanded(
            child: TextField(
              controller: controller,
              style: style,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: hintStyle,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
