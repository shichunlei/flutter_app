import 'package:flutter/material.dart';
import 'package:flutter_app/bean/hourly.dart';

class HourlyView extends StatelessWidget {
  final List<Hourly> hourly;

  HourlyView(this.hourly, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      color: Color(0x2a000000),
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('24小时预报', style: TextStyle(color: Colors.white)),
          Container(
            height: 0.2,
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 10.0),
          ),

        ],
      ),
    );
  }
}
