import 'package:flutter/material.dart';

import '../../page_index.dart';
import 'temp_single_line.dart';

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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('24小时预报', style: TextStyle(color: Colors.white)),
          Line(),
          TempSingleLine(width: Utils.width - 20, tempList: hourly),
          Row(
              children: hourly.map((hour) {
            return Expanded(
                child: Center(
                    child: Text(hour.condTxt, textAlign: TextAlign.center, style: TextStyle(color: Colors.white))));
          }).toList()),
          Row(
              children: hourly.map((hour) {
            return Expanded(child: Center(child: Image.network(hour.condCode, width: 20.0, height: 20.0)));
          }).toList())
        ]));
  }
}
