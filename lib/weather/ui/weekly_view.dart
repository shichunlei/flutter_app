import 'package:flutter/material.dart';

import '../../bean/he_weather.dart';
import '../../page_index.dart';
import '../../utils/date_format.dart';

import 'temp_line.dart';

class WeeklyView extends StatelessWidget {
  final List<DailyForecast> dailyForecast;

  WeeklyView(this.dailyForecast, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        color: Color(0x2a000000),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('未来一周天气预报', style: TextStyle(color: Colors.white))),
          Row(
              children: dailyForecast.map((daily) {
            DateTime dt = DateTime.parse(daily.date);
            return Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                              isToday(daily.date)
                                  ? "今天"
                                  : formatDate(dt, formats: [EE_ZH]),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white)),
                          Text(daily.cond_txt_d,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white)),
                          ImageLoadView(daily.cond_code_d,
                              width: 20.0, height: 20.0),
                        ])));
          }).toList()),
          TempLine(Utils.width, dailyForecast),
          Row(
              children: dailyForecast.map((daily) {
            return Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(daily.cond_txt_n,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white)),
                          ImageLoadView(daily.cond_code_n,
                              width: 20.0, height: 20.0),
                          Text(daily.wind_dir,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white)),
                          Text('${daily.wind_sc}级',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white))
                        ])));
          }).toList())
        ]));
  }
}
