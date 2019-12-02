import 'package:flutter/material.dart';

import 'package:flutter_app/bean/he_weather.dart';
import 'package:flutter_app/page_index.dart';
import 'package:flutter_app/utils/date_format.dart';

import 'temp_range_painter.dart';

class WeeklyView extends StatelessWidget {
  final List<DailyForecast> dailyForecast;

  WeeklyView(this.dailyForecast, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        color: Color(0x2a000000),
        padding: EdgeInsets.all(10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('未来一周天气预报', style: TextStyle(color: Colors.white)),
              Line(),
              SizedBox.fromSize(
                size: Size(Utils.width * 1.5, 271.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: dailyForecast.map(
                    (daily) {
                      DateTime dt = DateTime.parse(daily.date);
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        color: Color(0x2a000000),
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
                            WeatherTempView(
                              width: Utils.width * 1.5 / 7,
                              height: 110.0,
                              minRange: double.parse(daily.tmp_min),
                              min: -20,
                              max: 50,
                              maxRange: double.parse(daily.tmp_max),
                            ),
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
                          ],
                        ),
                      );
                    },
                  ).toList()),
                ),
              ),
            ]));
  }
}
