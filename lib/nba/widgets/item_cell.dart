import 'package:flutter/material.dart';

class ItemCellView extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final Color textColor;

  ItemCellView(
      {Key key,
      @required this.title,
      this.height: 40.0,
      this.width: 50.0,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Text(
        '$title',
        style: TextStyle(color: textColor ?? Colors.black),
      ),
      alignment: Alignment.center,
    );
  }
}
