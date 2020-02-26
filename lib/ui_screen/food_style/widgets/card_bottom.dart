import 'package:flutter/material.dart';

class CardBottom extends StatelessWidget {
  CardBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, bottom: 5),
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset(
                'images/thumbUp.png',
                width: 20,
                height: 20,
                color: Color(0xFF4FA16D),
              ),
              Text(
                '36',
                style: TextStyle(
                  color: Color(0xFF4FA16D),
                ),
              )
            ],
            mainAxisSize: MainAxisSize.min,
          ),
          SizedBox(width: 10),
          IconButton(
              icon: Image.asset(
                'images/save.png',
                color: Color(0xFF4FA16D),
                width: 18,
                height: 18,
              ),
              onPressed: () {}),
          IconButton(
              icon: Image.asset(
                'images/forward.png',
                width: 20,
                height: 20,
              ),
              onPressed: () {}),
          SizedBox(width: 40),
          Row(
            children: <Widget>[
              Image.asset(
                'images/chat.png',
                color: Color(0xFF4FA16D),
                width: 20,
                height: 20,
              ),
              Text(
                '5',
                style: TextStyle(
                  color: Color(0xFF5A5A5A),
                ),
              )
            ],
            mainAxisSize: MainAxisSize.min,
          ),
        ],
      ),
    );
  }
}
