import 'package:flutter/material.dart';

class ItemBarChartView extends StatelessWidget {
  final String title;
  final double max;
  final double value;
  final double avg;
  final Color teamColor;

  ItemBarChartView(
      {Key key, this.title, this.value, this.max, this.avg, this.teamColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  color: teamColor ?? Colors.deepPurple,
                  width: 10,
                  height: 120 * value / max,
                ),
                Container(
                  color: Colors.purpleAccent,
                  width: 10,
                  height: 120,
                ),
                Container(
                  color: Colors.lightBlue,
                  width: 10,
                  height: 120 * avg / max,
                ),
              ],
              mainAxisSize: MainAxisSize.min,
            ),
            Text('$title')
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
