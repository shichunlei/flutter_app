import 'package:flutter/material.dart';

import '../../bean/he_weather.dart';
import '../../page_index.dart';

class HourlyView extends StatelessWidget {
  final List<Hourly> hourly;

  HourlyView(this.hourly, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<double> data = [];
    hourly.forEach((h) => data.add(h.tmp));
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        width: double.infinity,
        color: Color(0x2a000000),
        padding: EdgeInsets.all(10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('24小时预报', style: TextStyle(color: Colors.white)),
              Line(),
              Container(
                  height: 80.0,
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  alignment: Alignment.center,
                  child: SparkLine(
                      data: data,
                      pointsMode: PointsMode.all,
                      showValue: true,
                      xStartZero: false)),
              Row(
                  children: hourly.map((hour) {
                return Expanded(
                    child: Center(
                        child: Text(hour.time,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white))));
              }).toList()),
              Row(
                  children: hourly.map((hour) {
                return Expanded(
                    child: Center(
                        child: Text(hour.cond_txt,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white))));
              }).toList()),
              Row(
                  children: hourly.map((hour) {
                return Expanded(
                    child: Center(
                        child: Image.network(hour.condCode,
                            width: 20.0, height: 20.0)));
              }).toList())
            ]));
  }
}
