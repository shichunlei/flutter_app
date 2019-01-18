import 'package:flutter/material.dart';

class ScorePage extends StatelessWidget {
  final int score;
  final int totalQuestion;

  ScorePage(this.score, this.totalQuestion);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Your Score:",
            style: TextStyle(
                color: Colors.white,
                fontSize: 50.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "$score/$totalQuestion",
            style: TextStyle(
                color: Colors.white,
                fontSize: 50.0,
                fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(Icons.arrow_right),
            onPressed: () {},
            color: Colors.white,
            iconSize: 50.0,
          ),
        ],
      ),
    );
  }
}
