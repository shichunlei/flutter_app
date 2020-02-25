import 'package:flutter/material.dart';

class CardTop extends StatelessWidget {
  final double radius;

  CardTop({Key key, this.radius: 25}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 20),
        CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage(
              'http://5b0988e595225.cdn.sohucs.com/q_70,c_zoom,w_640/images/20200117/ecb75626841940df8ebae55b9d266e4c.jpeg'),
        ),
        SizedBox(width: 10),
        Text(
          'Farhad Tarokh',
          style: TextStyle(
              color: Color(0xFF595959),
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        Spacer(),
        Text(
          'Just now',
          style: TextStyle(
              color: Color(0xFFA0A0A0),
              fontWeight: FontWeight.bold,
              fontSize: 12),
        ),
        SizedBox(width: 20),
      ],
    );
  }
}
