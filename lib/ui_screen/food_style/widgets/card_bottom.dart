import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

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
              IconButton(
                  icon: Icon(
                    Icons.thumb_up,
                    color: Color(0xFF5BB59A),
                  ),
                  onPressed: () {}),
              Text(
                '36',
                style: TextStyle(
                  color: Color(0xFF5A5A5A),
                ),
              )
            ],
            mainAxisSize: MainAxisSize.min,
          ),
          SizedBox(width: 10),
          IconButton(
              icon: Icon(
                Icons.save,
                color: Color(0xFF5BB59A),
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.share,
                color: Color(0xFF5A5A5A),
              ),
              onPressed: () {}),
          SizedBox(width: 40),
          Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Feather.message_circle,
                    color: Color(0xFF5A5A5A),
                  ),
                  onPressed: () {}),
              Text(
                '36',
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
