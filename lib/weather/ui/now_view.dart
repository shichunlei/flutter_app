import 'package:flutter/material.dart';
import 'package:flutter_app/bean/daily_forecast.dart';
import 'package:flutter_app/bean/now.dart';
import 'package:flutter_app/global/custom_icon.dart';

class NowView extends StatelessWidget {
  final NowBean now;
  final List<DailyForecast> daily_forecast;

  NowView(this.now, this.daily_forecast, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0x2a000000),
      padding:
          EdgeInsets.only(top: 100.0, bottom: 10.0, left: 10.0, right: 10.0),
      child: Column(
        children: <Widget>[
          Text(now.tmp, style: TextStyle(color: Colors.white, fontSize: 80.0)),
          SizedBox(height: 10.0),
          Text(
            now.cond_txt,
            style: TextStyle(color: Colors.white, fontSize: 17.0),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            height: 0.2,
            color: Colors.white,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Icon(CustomIcon.tmp, color: Colors.white, size: 20.0),
                    SizedBox(width: 5.0),
                    Text(
                      '${daily_forecast[0].tmp_max}/${daily_forecast[0].tmp_min}℃',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Icon(CustomIcon.wind, color: Colors.white, size: 20.0),
                    SizedBox(width: 5.0),
                    Text(
                      '${now.wind_dir}${now.wind_sc}级',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(CustomIcon.hum, color: Colors.white, size: 20.0),
                    SizedBox(width: 5.0),
                    Text(
                      now.hum,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
