import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';

class ToolBar extends StatelessWidget {
  final Color backgroundColor;
  final String title;

  ToolBar({
    Key key,
    this.backgroundColor = Colors.red,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor),
      padding: EdgeInsets.fromLTRB(20, Utils.topSafeHeight, 0, 0),
      height: Utils.navigationBarHeight,
      child: Align(
        child: Text(
          '$title',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
