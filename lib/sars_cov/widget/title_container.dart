import 'package:flutter/material.dart';

class TitleContainer extends StatelessWidget {
  final String title;

  TitleContainer({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        child: Row(children: <Widget>[
          Container(
              color: Colors.blue,
              width: 5.0,
              height: 30,
              margin: EdgeInsets.only(right: 10)),
          Text('$title',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold))
        ]),
        color: Colors.white);
  }
}
