import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  Line({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 0.2,
        color: Colors.white,
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0));
  }
}
